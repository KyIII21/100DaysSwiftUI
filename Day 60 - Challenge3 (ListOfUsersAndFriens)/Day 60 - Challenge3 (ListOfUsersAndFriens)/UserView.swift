//
//  UserView.swift
//  Day 60 - Challenge3 (ListOfUsersAndFriens)
//
//  Created by Дмитрий on 12.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct UserView: View {
    let user: User
    let users: [User]
    @State var showingAllRows = false
    
    func dateFormat() -> String{
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .short
        dateFormater.dateStyle = .short
        dateFormater.dateFormat = "MMM dd yyyy, hh:MM"
        return dateFormater.string(from: self.user.registeredDate)
    }
    
    func searchUser(friend: User.Friend) -> some View{
        for user in self.users{
            if user.id == friend.id{
                return AnyView(NavigationLink(destination: UserView( user:  user, users: self.users)){
                    Text("\(friend.name)")
                })
            }
        }
        return AnyView(Text("\(friend.name)"))
        //return self.users.filter{ $0.id == id }[0]
    }
    
    var body: some View {
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
            Section(header: Text("Tags")){
                TagsView(tags: self.user.unicTags)
                    .frame(height: 80) // Придкмать как получить нужный размер из view
            }
            Section(header: Text("Friends")){
                ForEach(self.user.friends, id: \User.Friend.name){ friend in
                    self.searchUser(friend: friend)
                    
                }
            }
        }
        .navigationBarTitle(user.name + (user.isActive ? "  ✅" : "  ⛔️"))
    }
}

struct UserView_Previews: PreviewProvider {
    static let user = User(id: UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954")!, isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n",
    registered: "2015-11-10T01:47:18-00:00", tags: [
        "cillum",
        "consequat",
        "deserunt",
        "nostrud",
        "eiusmod",
        "minim",
        "tempor"
    ], friends: [User.Friend(id: UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0")!, name: "Hawkins Patel"), User.Friend(id: UUID(uuidString:"0c395a95-57e2-4d53-b4f6-9b9e46a32cf6")!, name: "Jewel Sexton")])
    static var previews: some View {
        UserView(user: user, users: [User]())
    }
}
