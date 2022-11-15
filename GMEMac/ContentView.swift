//
//  ContentView.swift
//  GMEMac
//
//  Created by Ryan Anderson on 2/5/20.
//  Copyright © 2020 Ryan Anderson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Vars
    @ObservedObject var main:Main
    

    //MARK: Body
    var body: some View {
        VStack{
            HStack{
                Text("\(self.main.output)")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color("PanelForeground"))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 100, idealHeight: 100, maxHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color("PanelForeground"), lineWidth: 2)
                    )
                    .onTapGesture {
                        self.main.output = ""
                    }
                }
                .background(Color("PanelBackground"))
                .cornerRadius(10.0)
                .shadow(radius: 3.0, x: 2.0, y: 3.0)
                .padding(.horizontal)
                .padding(.top)
            Spacer()
            //MARK: Window Aspect Mode
            if(!self.main.slimMode){
            Divider()
            HStack{
                Text("Active Descriptors")
                    .font(.headline)
                Stepper("", value: $main.activeDescriptors, in: -3...3, onEditingChanged: {_ in
                    oracle.activeDescriptors = self.main.activeDescriptors
                    self.main.disposition = oracle.disposition
                }).labelsHidden()
                Text("\(self.main.activeDescriptors)")
                Button(action: { self.main.npcDisposition() }){ Text("Disposition") }
                MenuButton(label: Text(oracle.npcDispositionDescriptionTable[self.main.disposition])) {
                    ForEach(0..<oracle.npcDispositionDescriptionTable.count){ i in
                        Button(action: { self.main.disposition = i }){ Text(oracle.npcDispositionDescriptionTable[i]) }
                    }
                }.frame(width: 120)
                Button(action: { self.main.action() }){ Text("Action") }
            }
            Divider()
            HStack{
                Button(action: { self.main.sceneChange() }){ Text("New Scene").frame(width: 80) }
                Button(action: { self.main.description() }){ Text("Description").frame(width: 80) }
                Button(action: { self.main.action() }){ Text("Action").frame(width: 80) }
                Button(action: { self.main.event() }){ Text("Event").frame(width: 80) }
            }
            Divider()
            HStack{
                Text("Chaos")
                    .font(.headline)
                Stepper("", value: $main.chaos, in: 3...6).labelsHidden()
                Text("\(self.main.chaos)")
                MenuButton(label: Text(self.main.Odds[self.main.odds])) {
                    ForEach(0..<main.Odds.count){ i in
                        Button(action: { self.main.odds = i }){ Text(self.main.Odds[i]) }
                    }
                }.frame(width: 160)
                Button(action: { self.main.ask() }){ Text("Ask").frame(width: 80) }
            }.padding(.horizontal).padding(.bottom)
        }
            //MARK: Slim Mode
            if(self.main.slimMode){
                Divider()
                HStack{
                    Text("Active Descriptors")
                        .font(.headline)
                    Stepper("", value: $main.activeDescriptors, in: -3...3, onEditingChanged: {_ in
                        oracle.activeDescriptors = self.main.activeDescriptors
                        self.main.disposition = oracle.disposition
                    }).labelsHidden()
                    Text("\(self.main.activeDescriptors)")
                    Button(action: { self.main.action() }){ Text("Action") }
                    Spacer()
                }.padding(.horizontal)
                HStack{
                    Button(action: { self.main.npcDisposition() }){ Text("Disposition") }
                    MenuButton(label: Text(oracle.npcDispositionDescriptionTable[self.main.disposition])) {
                        ForEach(0..<oracle.npcDispositionDescriptionTable.count){ i in
                            Button(action: { self.main.disposition = i }){ Text(oracle.npcDispositionDescriptionTable[i]) }
                        }
                    }.frame(width: 120)
                    
                }
                Divider()
                HStack{
                    Button(action: { self.main.sceneChange() }){ Text("New Scene").frame(width: 80) }
                    Button(action: { self.main.description() }){ Text("Description").frame(width: 80) }
                }
                HStack{
                    Button(action: { self.main.action() }){ Text("Action").frame(width: 80) }
                    Button(action: { self.main.event() }){ Text("Event").frame(width: 80) }
                }
                HStack{
                    MenuButton(label: Text(self.main.Odds[main.odds])) {
                        ForEach(0..<main.Odds.count){ i in
                            Button(action: { self.main.odds = i }){ Text(self.main.Odds[i]) }
                        }
                    }.frame(width: 120)
                    Button(action: { self.main.ask() }){ Text("Ask").frame(width: 65) }
                }
                HStack{
                    Text("Chaos").font(.headline)
                    Stepper("", value: $main.chaos, in: 3...6).labelsHidden()
                    Text("\(self.main.chaos)")
                    Spacer()
                }.padding(.horizontal).padding(.bottom)
            }
            
        }.frame(minWidth: 300.0, maxWidth: .infinity, minHeight: 480.0, maxHeight: .infinity)
        .background(Color("Background"))
    }
}


//MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(main: viewModel).environment( \.colorScheme, .dark)
    }
}
