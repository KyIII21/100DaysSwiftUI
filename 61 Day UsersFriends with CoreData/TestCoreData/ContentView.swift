//
//  ContentView.swift
//  Day 60 - Challenge3 (ListOfUsersAndFriens)
//
//  Created by Дмитрий on 11.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var users = [User]()
    @FetchRequest(entity: UserCore.entity(), sortDescriptors: []) var usersCore: FetchedResults<UserCore>
    @Environment(\.managedObjectContext) var moc
    private let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
    
    
    func getListOfUsersFromServer(){
        if self.url == nil{
            fatalError("Invalid URL")
        }
        let request = URLRequest(url: self.url!)
        URLSession.shared.dataTask(with: request){ data, responce, error in
            if let data = data{
                if self.decodeFromData(data: data){
                    return
                }else{
                    fatalError("Fatal Error: Decoding, see above for know reason")
                }
            }
            fatalError("Fatal Error: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func decodeFromData(data: Data) -> Bool{
        do{
            let decoderResponce = try JSONDecoder().decode([User].self, from: data)
            self.users = decoderResponce
            for user in decoderResponce{
                let userCore = UserCore(context: self.moc)
                userCore.id = user.id
                userCore.isActive = user.isActive
                userCore.name = user.name
                userCore.address = user.address
                userCore.email = user.email
                userCore.about = user.about
                userCore.company = user.company
                userCore.tags = user.tags as NSObject
                userCore.age = Int16(user.age)
                userCore.registered = user.registeredDate
                
                for friend in user.friends{
                    let friendCore = FriendCore(context: self.moc)
                    friendCore.id = friend.id
                    friendCore.name = friend.name
                    
                    userCore.addToFriend(friendCore)
                    do{
                        if self.moc.hasChanges{
                            try self.moc.save()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                do{
                    if self.moc.hasChanges{
                        try self.moc.save()
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            
            return true
        //Поиск всевозможных ошибок связанных с декодированием
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return false
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(usersCore, id: \.self){ user in
                    NavigationLink(destination: UserView(user: user)){
                        HStack{
                            Text(user.isActive ? "  ✅" : "  ⛔️")
                            Text("\(user.name)")
                        }
                    }
                }
            }//.onAppear(perform: self.getListOfUsersFromServer)
            .navigationBarTitle("ListOfUsers")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

