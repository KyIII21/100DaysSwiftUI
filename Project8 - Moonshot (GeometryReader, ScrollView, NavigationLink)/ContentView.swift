//
//  ContentView.swift
//  Project8 - Moonshot (GeometryReader, ScrollView, NavigationLink)
//
//  Created by Дмитрий on 28.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingViewName = true
    
    func changeView(){
        self.showingViewName.toggle()
    }
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        if self.showingViewName {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                        }else{
                            Text(mission.formattedLaunchDate)
                                .font(.headline)
                            Text(mission.displayName)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: self.changeView){
                Text("Change")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
