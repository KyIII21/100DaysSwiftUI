//
//  ProspectsView.swift
//  Project16 - HotProspect
//
//  Created by Дмитрий on 20.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

enum SortType {
    case byName, byRecent
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    @State private var isShowingScanner = false
    @State private var showingSortSheet = false
    //@State private var sortType = SortType.byRecent
    @State private var sortsType: [FilterType : SortType] = [.none : .byRecent, .contacted : .byRecent, .uncontacted : .byRecent]
    
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people.sorted(by: sorting)
        case .contacted:
            return prospects.people.filter { $0.isContacted }.sorted(by: sorting)
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }.sorted(by: sorting)
        }
    }
    
    func sorting(left: Prospect, right: Prospect) -> Bool{
        switch sortsType[filter] {
        case .byName:
            return left.name < right.name
        default:
            return false
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
        
       switch result {
       case .success(let code):
           let details = code.components(separatedBy: "\n")
           guard details.count == 2 else { return }

           let person = Prospect()
           person.name = details[0]
           person.emailAddress = details[1]

           self.prospects.add(person)
       case .failure(let error):
           print("Scanning failed: \(error)")
       }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

//            at 09:00 in the next morning
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        if self.filter == .none && prospect.isContacted {
                            Spacer()
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: {self.showingSortSheet.toggle()}){
                Image(systemName: "line.horizontal.3.decrease.circle")
                Text("Sort")
            }, trailing: Button(action: {
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                
                CodeScannerView(codeTypes: [.qr], simulatedData: "Archi Cuson\nql@hackingwithswift.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: $showingSortSheet) {
                ActionSheet(title: Text("Sorting.."), message: Text("Only for this Tab."), buttons: [.default(Text( self.sortsType[filter] == .byName ? "✔︎ By Name" : "By Name")){self.sortsType[self.filter] = .byName}, .default(Text(self.sortsType[filter] == .byRecent ? "✔︎ By Most Recent" : "By Most Recent")){self.sortsType[self.filter] = .byRecent}])
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
