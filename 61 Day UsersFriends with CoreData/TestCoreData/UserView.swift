//
//  UserView.swift
//  Day 60 - Challenge3 (ListOfUsersAndFriens)
//
//  Created by Дмитрий on 12.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct UserView: View {
    let user: UserCore
    //let users: [UserCore]
    @State var showingAllRows = false
    
    @FetchRequest(entity: UserCore.entity(), sortDescriptors: []) var usersCore: FetchedResults<UserCore>
    @Environment(\.managedObjectContext) var moc
    
    func dateFormat() -> String{
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .short
        dateFormater.dateStyle = .short
        dateFormater.dateFormat = "MMM dd yyyy, hh:MM"
        return dateFormater.string(from: self.user.registered ?? Date())
    }
    
    func searchUser(friend: FriendCore) -> some View{
        for user in self.usersCore{
            if user.id == friend.id{
                return AnyView(NavigationLink(destination: UserView( user:  user)){
                    Text("\(friend.name)")
                })
            }
        }
        return AnyView(Text("\(friend.name)"))
        //return self.users.filter{ $0.id == id }[0]
    }
    
    var body: some View {
        Group{
            Form{
                Section{
                    HStack{
                        Text("Age")
                        Spacer()
                        Text("\(user.age)")
                            .foregroundColor(Color.gray)
    //                        Text(user.isActive ? "Active" : "Busy")
    //                            .foregroundColor(user.isActive ? Color.green : Color.red)
                    }
                }
                Section(header: Text("Contact Info")){
                    HStack{
                        Text("Company")
                        Spacer()
                        Text("\(user.company)")
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        Text("Email")
                        Spacer()
                        Text("\(user.email)")
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        Text("Address   ")
                        Spacer()
                        Text("\(user.address)")
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                }
                Section(header: Text("Date & Time Registered")){
                    HStack{
                        Text("Registered")
                        Spacer()
                        Text("\(self.dateFormat())")
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                }
                Section(header: Text("About")){
                    VStack{
                        Text("\(user.about)")
                            .foregroundColor(Color.gray)
                            .lineLimit(self.showingAllRows ? nil : 2)
                        Button(action: {self.showingAllRows.toggle()}){
                            Text(self.showingAllRows ? "Hide" : "Read more")
                        }
                    }
                    
                }

                Section(header: Text("Friends")){
                    ForEach(Array(user.friend! as Set), id: \.self){ friend in
                        self.searchUser(friend: friend as! FriendCore)
                        
                    }
                }
            }
            Section(header: Text("Tags")){
                TagsView(tags: self.user.unicTags)
                    //.frame(height: ) // Придкмать как получить нужный размер из view
            }
        }
        .navigationBarTitle(user.name + (user.isActive ? "  ✅" : "  ⛔️"))
    }
}

//struct UserView_Previews: PreviewProvider {
//    static let user = UserCore
//    static var previews: some View {
//        UserView(user: user)
//    }
//}
