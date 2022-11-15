//
//  ContentView.swift
//  GME
//
//  Created by Ryan Anderson on 1/27/20.
//  Copyright © 2020 Ryan Anderson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private enum SelectorType {
        case odds
        case disposition
    }
    
    //MARK: Vars
    @ObservedObject var main:Main
    
    @State private var showSelector = false
    @State private var selectorType = SelectorType.odds
    @State private var selectorArray = ["1", "2"]
    @State private var selected = 0
    
    //MARK: Functions
    public func select(value: Int) {
        if selectorType == .odds { self.main.odds = value }
        else if selectorType == .disposition {
            self.main.disposition = value
            oracle.disposition = self.main.disposition
        }
        
        self.showSelector = false
    }
    
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
            VStack{
                Divider()
                HStack{
                    Text("Active Descriptors")
                        .font(.title)
                        .fontWeight(.light)
                    Stepper("", value: $main.activeDescriptors, in: -3...3, onEditingChanged: {_ in
                        oracle.activeDescriptors = self.main.activeDescriptors
                        self.main.disposition = oracle.disposition
                    }).labelsHidden()
                    Text("\(self.main.activeDescriptors)").frame(width: 18).padding(.horizontal, 8.0)
                }
                //Divider()
                HStack{
                    Button(action: {
                        self.main.npcDisposition()
                    }){
                        Text("Disposition")
                            .lineLimit(1)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(6)
                            .foregroundColor(Color("ButtonForeground"))
                    }
//                    Stepper("", value: $disposition, in: 0...3).labelsHidden()
                    Button(action: {
                        self.selectorType = .disposition
                        self.showSelector = true
                        self.selectorArray = oracle.npcDispositionDescriptionTable
                        self.selected = self.main.disposition
                    }){
                        Text("\(oracle.npcDispositionDescriptionTable[self.main.disposition])")
                            .frame(width: 100)
                            .lineLimit(1)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(6)
                            .foregroundColor(Color("ButtonForeground"))
                    }
                    Button(action: {
//                        oracle.disposition = self.disposition
                        self.main.npcAction()
                    }){
                        Text("Action")
                            .lineLimit(1)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(6)
                            .foregroundColor(Color("ButtonForeground"))
                    }
                }
                Divider()
                HStack{
                    Button(action: {
                        self.main.description()
                    }){
                        Text("Description")
                            .lineLimit(1)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(6)
                            .foregroundColor(Color("ButtonForeground"))
                    }
                    Button(action: {
                        self.main.action()
                    }){
                        Text("Action")
                            .lineLimit(1)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(6)
                            .foregroundColor(Color("ButtonForeground"))
                    }
                    Button(action: {
                        self.main.event()
                    }){
                        Text("Event")
                            .lineLimit(1)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(6)
                            .foregroundColor(Color("ButtonForeground"))
                    }
                }.padding(.horizontal)
                Divider()
                
                HStack{
                    Button(action: {
                        self.main.sceneChange()
                    }){
                        Text("New Scene")
                            .lineLimit(1)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(6)
                            .foregroundColor(Color("ButtonForeground"))
                    }
                    Button(action: {
                        self.selectorType = .odds
                        self.showSelector = true
                        self.selectorArray = self.main.Odds
                        self.selected = self.main.odds
                    }){
                        Text("\(main.Odds[main.odds])")
                            .frame(width: 100)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(6)
                            .foregroundColor(Color("ButtonForeground"))
                    }
                    
                    Button(action: {
                        self.main.ask()
                    }){Text("Ask")
                        //.frame(width: 80)
                        .padding(.vertical, 6.0)
                        .padding(.horizontal)
                        .background(Color("ButtonBackground"))
                        .cornerRadius(6)
                        .foregroundColor(Color("ButtonForeground"))}
                }.padding(.horizontal)
                Divider()
                HStack{
                    Text("Chaos")
                        .font(.title)
                        .fontWeight(.light)
                    Stepper("", value: $main.chaos, in: 3...6).labelsHidden()
                    Text("\(self.main.chaos)")
                        .padding(.horizontal, 8.0)
                    Spacer()
                }.padding(.horizontal)
            }
            }.padding(.bottom).background(Color("Background"))
                .sheet(isPresented: $showSelector){
                    WheelSelector(OptionsArray: self.selectorArray, selected: self.selected, delegate: self)
        }
        .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
        .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
    }
}

//MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(main: viewModel).environment( \.colorScheme, .light)
    }
}
