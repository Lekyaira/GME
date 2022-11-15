//
//  MainViewModel.swift
//  GME
//
//  Created by Ryan Anderson on 2/6/20.
//  Copyright © 2020 Ryan Anderson. All rights reserved.
//

import Foundation

class Main: ObservableObject {
    let Odds = ["Has To Be", "Sure Thing", "Very Likely", "Likely", "50/50", "Unlikely", "Very Unlikely", "No Way", "Impossible"]
    @Published var odds = 4
    @Published var chaos = 4
    @Published var output = ""
    @Published var disposition = 1
    @Published var activeDescriptors = 0
    @Published var slimMode = false
    
    public func description() {
        oracle.chaos = self.chaos
        var detailResult = ""
        var descriptionResult = ""
        (detailResult, descriptionResult) = oracle.descriptionDetailCheck()
        self.output = detailResult + "\n" + descriptionResult
    }
    
    public func action() {
        oracle.chaos = self.chaos
        var detailResult = ""
        var actionResult = ""
        (detailResult, actionResult) = oracle.descriptionDetailCheck()
        self.output = detailResult + "\n" + actionResult
    }
    
    public func event() {
        oracle.chaos = self.chaos
        var eventResult = ""
        var actionResult = ""
        (eventResult, actionResult) = oracle.eventCheck()
        self.output = eventResult + "\n" + actionResult
    }
    
    public func ask() {
        oracle.chaos = self.chaos
        oracle.odds = self.odds
        var result: Oracle.FateResult
        var random: Bool
        var eventResult: String
        var actionResult: String
        (result, random, (eventResult, actionResult)) = oracle.fateCheck()
        var outStr = ""
        if result == .yes { outStr = "Yes." }
        else if result == .no { outStr = "No." }
        else if result == .extremeYes { outStr = "YES!" }
        else if result == .extremeNo { outStr  = "NO!" }
        else if result == .yesNo { outStr = "Yes/No" }
        else if result == .extremeYesNo { outStr = "YES!/NO!" }
        
        self.output = "\(outStr)"
        if random { self.output += "\nRandom: \(eventResult)\n\(actionResult)" }
    }
    
    public func sceneChange() {
        oracle.chaos = self.chaos
        var result: Oracle.SceneChangeResult
        var eventResult = ""
        var actionResult = ""
        var outStr = ""
        
        (result, (eventResult, actionResult)) = oracle.sceneChange()
        
        if result == .none { outStr = "None" }
        else if result == .altered { outStr = "Altered" }
        else if result == .interrupt { outStr = "Interrupt: \(eventResult)!\n \(actionResult)" }
        
        self.output = outStr
    }
    
    public func npcDisposition() {
        (_, self.disposition) = oracle.npcDisposition(activeDescriptorsModifier: self.activeDescriptors)
    }

    public func npcAction() {
        var action1 = ""
        var action2 = ""
        var hasAction2 = false
        
        (action1, hasAction2, action2, self.disposition) = oracle.npcAction()
        self.output = "\(action1)\(hasAction2 ? "\n\(action2)" : "")"
    }
}
let viewModel = Main()
