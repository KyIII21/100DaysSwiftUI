//
//  AstronautView.swift
//  Project8 - Moonshot (GeometryReader, ScrollView, NavigationLink)
//
//  Created by Дмитрий on 28.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var myMissions: [String]{
        var myMissions = [String]()
        for mission in missions {
            for crewNenmer in mission.crew {
                if astronaut.id == crewNenmer.name{
                    myMissions.append(mission.displayName)
                }
            }
        }
        return myMissions
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.9)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .accessibility(label: Text("Photo \(self.astronaut.name)"))

                    Text(self.astronaut.description)
                        .padding()
                    Text("Missions \(self.astronaut.name):")
                        .bold()
                        .padding(.bottom, 5)
                    ForEach(0..<self.myMissions.count){ mission in
                        Text(self.myMissions[mission])
                            .padding(5)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[7], missions: missions)
    }
}
