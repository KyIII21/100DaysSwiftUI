//
//  MissionView.swift
//  Project8 - Moonshot (GeometryReader, ScrollView, NavigationLink)
//
//  Created by Дмитрий on 28.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    let missions: [Mission]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    
    init(mission: Mission, astronauts: [Astronaut], missions: [Mission]) {
        self.mission = mission
        self.missions = missions

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { scrollGeo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: scrollGeo.size.width, maxHeight: scrollGeo.size.height)
                            .scaleEffect(scrollGeo.frame(in: .global).minY > 10 ? 1.0 : 0.6)
                            .animation(.easeInOut)
                            .padding(.top)
                    }
                    
                    Text("Date Mission: \(self.mission.formattedLaunchDate)")
                        .padding(.top)
                        .font(.footnote)

                    Text(self.mission.description)
                        .padding()
                    
                    HStack(){
                        Text("Crew Members:")
                            .font(.title)
                            .padding([.top, .leading])
                        Spacer()
                    }
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 90, height: 70)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                                    .accessibility(label: Text("Photo \(crewMember.astronaut.name)"))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts, missions: self.missions)
    }
}
