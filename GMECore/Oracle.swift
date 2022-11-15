//
//  Oracle.swift
//  GME
//
//  Created by Ryan Anderson on 1/30/20.
//  Copyright © 2020 Ryan Anderson. All rights reserved.
//

// MARK: Tables
public class Oracle {
    private let detailTable = [
        "Anger",
        "Sadness",
        "Fear",
        "Disfavors Thread",
        "Disfavors PC",
        "Focus NPC",
        "Favors NPC",
        "Focus PC",
        "Disfavors NPC",
        "Focus Thread",
        "Favors PC",
        "Favor Thread",
        "Courage",
        "Happiness",
        "Calm"
    ]
    
    private let eventFocusTable = [
        "Remote Event", "Remote Event", "Remote Event", "Remote Event", "Remote Event", "Remote Event", "Remote Event", "Remote Event",
        "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action", "NPC Action",
        "Introduce a new NPC", "Introduce a new NPC", "Introduce a new NPC", "Introduce a new NPC", "Introduce a new NPC", "Introduce a new NPC", "Introduce a new NPC",
        "Move toward a thread", "Move toward a thread", "Move toward a thread", "Move toward a thread", "Move toward a thread", "Move toward a thread", "Move toward a thread", "Move toward a thread", "Move toward a thread", "Move toward a thread",
        "Move away from a thread", "Move away from a thread", "Move away from a thread", "Move away from a thread", "Move away from a thread", "Move away from a thread", "Move away from a thread",
        "Close a thread", "Close a thread", "Close a thread",
        "PC Negative", "PC Negative", "PC Negative", "PC Negative", "PC Negative", "PC Negative", "PC Negative", "PC Negative", "PC Negative", "PC Negative", "PC Negative", "PC Negative",
        "PC Positive", "PC Positive", "PC Positive", "PC Positive", "PC Positive", "PC Positive", "PC Positive", "PC Positive",
        "Ambiguous Event", "Ambiguous Event", "Ambiguous Event", "Ambiguous Event", "Ambiguous Event", "Ambiguous Event", "Ambiguous Event", "Ambiguous Event",
        "NPC Negative", "NPC Negative", "NPC Negative", "NPC Negative", "NPC Negative", "NPC Negative", "NPC Negative", "NPC Negative", "NPC Negative",
        "NPC Positive", "NPC Positive", "NPC Positive", "NPC Positive", "NPC Positive", "NPC Positive", "NPC Positive", "NPC Positive"
    ]
    
    private let npcDispositionTable = [
        ("Passive", -2), ("Passive", -2), ("Passive", -2), ("Passive", -2), ("Passive", -2), ("Passive", -2), ("Passive", -2), ("Passive", -2), ("Passive", -2), ("Passive", -2),
        ("Moderate", 0), ("Moderate", 0), ("Moderate", 0), ("Moderate", 0), ("Moderate", 0),
        ("Active", 2), ("Active", 2), ("Active", 2), ("Active", 2), ("Active", 2),
        ("Aggressive", 4)
    ]
    
    public let npcDispositionDescriptionTable = [
        "Passive",
        "Moderate",
        "Active",
        "Aggressive"
    ]
    
    private let npcActionTable1 = [
        "Theme Action", "Theme Action", "Theme Action",
        "NPC Continues", "NPC Continues",
        "NPC Continues +2",
        "NPC Continues -2",
        "NPC Action",
        "NPC Action -4",
        "NPC Action +4",
    ]
    
    private let npcActionTable2 = [
        "Talks, Exposition",
        "Performs an Ambiguous Action", "Performs an Ambiguous Action",
        "Acts out of PC Interest", "Acts out of PC Interest",
        "Gives Something",
        "Seeks to End the Encounter",
        "Changes the Theme",
        "Changes Descriptor",
        "Acts out of Self Interest", "Acts out of Self Interest", "Acts out of Self Interest",
        "Takes Something",
        "Causes Harm"
    ]
    
    private let descriptorTable1 = [
        "Abnormally", "Adventurously", "Aggressively", "Angrily", "Anxiously", "Awkwardly", "Beautifully",
        "Bleakly", "Boldly", "Bravely", "Busily", "Calmly", "Carefully", "Cautiously", "Ceaselessly", "Cheerfully",
        "Combatively", "Coolly", "Crazily", "Curiously", "Dantily", "Dangerously", "Defiantly", "Deliberately",
        "Delightfully", "Dimly", "Efficiently", "Energetically", "Enormously", "Enthusiastically", "Excitedly",
        "Fearfully", "Ferociously", "Fiercely", "Foolishly", "Fortunately", "Frantically", "Freely", "Frighteningly",
        "Fully", "Generously", "Gently", "Gladly", "Gracefully", "Gratefully", "Happily", "Hastily", "Healthily",
        "Helpfully", "Helplessly", "Hopelessly", "Innocently", "Intensely", "Interestingly", "Irritatingly",
        "Jovially", "Joyfully", "Judgementally", "Kindly", "Kookily", "Lazily", "Lightly", "Loosely", "Loudly",
        "Lovingly", "Loyally", "Majestically", "Meaningfully", "Mechanically", "Miserably", "Mockingly",
        "Mysteriously", "Naturally", "Neatly", "Nicely", "Oddly", "Offensively", "Officially", "Partially",
        "Peacefully", "Perfectly", "Playfully", "Politely", "Positively", "Powerfully", "Quaintly", "Quarrelsomely",
        "Quietly", "Roughly", "Rudely", "Ruthlessly", "Slowly", "Softly", "Swiftly", "Threateningly", "Very",
        "Violently", "Wildly", "Yieldingly"
    ]
    
    private let descriptorTable2 = [
        "Abandoned", "Abnormal", "Amusing", "Ancient", "Aromatic", "Average", "Beautiful",
        "Bizarre", "Classy", "Clean", "Cold", "Colorful", "Creepy", "Cute",
        "Damaged", "Dark", "Defeated", "Delicate", "Delightful", "Dirty", "Disagreeable",
        "Disgusting", "Drab", "Dry", "Dull", "Empty", "Enormous", "Exotic",
        "Faded", "Familiar", "Fancy", "Fat", "Feeble", "Feminine", "Festive",
        "Flawless", "Fresh", "Full", "Glorious", "Good", "Graceful", "Hard",
        "Harsh", "Healthy", "Heavy", "Historical", "Horrible", "Important", "Interesting",
        "Juvenile", "Lacking", "Lame", "Large", "Lavish", "Lean", "Less",
        "Lethal", "Lonely", "Lovely", "Macabre", "Magnificent", "Masculine", "Mature",
        "Messy", "Mighty", "Military", "Modern", "Extravagant", "Mundane", "Mysterious",
        "Natural", "Nondescript", "Odd", "Pale", "Petite", "Poor", "Powerful",
        "Quaint", "Rare", "Reassuring", "Remarkable", "Rotten", "Rough", "Ruined",
        "Rustic", "Scary", "Simple", "Small", "Smelly", "Smooth", "Soft",
        "Strong", "Tranquil", "Ugly", "Valuable", "Warlike", "Warm", "Watery",
        "Weak", "Young"
    ]
    
    private let actionTable1 = [
        "Attainment", "Starting", "Neglect", "Fight", "Recruit", "Triumph", "Violate", "Oppose", "Malice", "Communicate",
        "Persecute", "Increase", "Decrease", "Abandon", "Gratify", "Inquite", "Antagonize", "Move", "Waste", "Truce",
        "Release", "Befriend", "Judge", "Desert", "Dominate", "Procrastinate", "Praise", "Separate", "Take", "Break",
        "Heal", "Delay", "Stop", "Lie", "Return", "Imitate", "Struggle", "Inform", "Bestow", "Postpone",
        "Expose", "Haggle", "Imprison", "Release", "Celebrate", "Develop", "Travel", "Block", "Harm",
        "Debase", "Overindulge", "Adjorn", "Adversity", "Kill", "Disrupt", "Usurp", "Create", "Betray", "Agree", "Abuse",
        "Oppress", "Inspect", "Ambush", "Spy", "Attach", "Carry", "Open", "Carelessness", "Ruin", "Extravagance",
        "Trick", "Arrive", "Propose", "Divide", "Refuse", "Mistrust", "Deceive", "Cruelty", "Intolerance", "Trust",
        "Excitement", "Activity", "Assist", "Care", "Negligence", "Passion", "Work", "Control", "Attract",
        "Failure", "Pursue", "Vengeance", "Proceedings", "Dispute", "Punish", "Guide", "Transform", "Overthrow", "Oppress", "Change"
    ]
    
    private let actionTable2 = [
        "Goals", "Dreams", "Environment", "Outside", "Inside", "Reality", "Allies", "Enemies", "Evil", "Good", "Emotions", "Opposition", "War", "Peace", "Innocent", "Love", "Spirit", "Intellect", "Ideas", "Joy", "Messages", "Energy", "Balance", "Tension", "Friendship", "Physical", "Project", "Pleasures", "Pain", "Possessions", "Benefits", "Plans", "Lies", "Expectations", "Legal", "Bureaucracy", "Business", "Path", "News", "Exterior", "Advice", "Plot", "Competition", "Prison", "Illness", "Food", "Attention", "Success", "Failure", "Travel", "Jealousy", "Dispute", "Home", "Investment", "Suffering", "Wishes", "Tactics", "Stalemate", "Randomness", "Misfortune", "Death", "Disruption", "Power", "Burden", "Intrigues", "Fears", "Ambush", "Rumor", "Wounds", "Extravagance", "Representative", "Adversities", "Opulence", "Liberty", "Military", "Mundane", "Trials", "Masses", "Vehicle", "Art", "Victory", "Dispute", "Riches", "Normal", "Technology", "Hope", "Magic", "Illusions", "Portals", "Danger", "Weapons", "Animals", "Weather", "Elements", "Nature", "Masses", "Leadership", "Fame", "Anger", "Information"
    ]
    
    // MARK: Vars
    private var _odds: Int
    public var chaos: Int
    public var _disposition: Int
    private var dispositionRoll: Int
    private var _activeDescriptors: Int
    private let rnd = xorshift1024star()
    
    public enum FateResult {
        case yes
        case no
        case extremeYes
        case extremeNo
        case yesNo
        case extremeYesNo
    }
    
    public enum SceneChangeResult {
        case none
        case altered
        case interrupt
    }
    
    init(){
        _odds = 0
        chaos = 4
        _disposition = 0
        dispositionRoll = 7
        _activeDescriptors = 0
    }
    
    // MARK: Functions
    public func fateCheck() -> (FateResult, Bool, (String, String)) {
        let d1 = rnd.getInt(min: 1, max: 10)
        let d2 = rnd.getInt(min: 1, max: 10)
        let chaosDie = rnd.getInt(min: 1, max: 10)
        let roll = d1 + d2
        let both = d1 == d2
        let random = ((d1 % 2 == 0 && d2 % 2 == 0) || both) && chaosDie <= chaos
        let extreme = ((d1 % 2 != 0 && d2 % 2 != 0) || both) && chaosDie <= chaos
        let yes = roll >= 11 + _odds
        let split = ((chaos >= 6) && !yes && (roll + 2 >= 11)) || ((chaos <= 3) && yes && (roll - 2 < 11))
        
        var result: FateResult = .yes
        
        if yes && !extreme { if split { result = .yesNo } else { result = .yes }}
        else if !yes && !extreme { if split { result = .yesNo } else { result = .no }}
        else if yes && extreme { if split { result = .extremeYesNo } else { result = .extremeYes }}
        else if !yes && extreme { if split { result = .extremeYesNo } else { result = .extremeNo }}
        
        if random {
            return (result, random, eventCheck())
        } else {
            return (result, random, ("", ""))
        }
    }
    
    private func detailCheck() -> String {
        let modifier = chaos <= 3 ? +2 : chaos >= 6 ? -2 : 0
        let roll = (rnd.getInt(min: 1, max: 10) + rnd.getInt(min: 1, max: 10)) + modifier
        let check = (roll <= 4 ? 4 : roll >= 18 ? 18 : roll) - 4
//        var modifier = 0;
//        if chaos <= 3 { modifier = +2 } else if chaos >= 6 { modifier = -2 }

        return detailTable[check]
    }
    
    public func descriptionDetailCheck() -> (String, String) {
        return (detailCheck(), descriptorTable1[rnd.getInt(min: 0, max: 99)] + " " + descriptorTable2[rnd.getInt(min: 0, max: 99)])
    }
    
    public func actionDetailCheck() -> (String, String) {
        return (detailCheck(), actionTable1[rnd.getInt(min: 0, max: 99)] + " " + actionTable2[rnd.getInt(min: 0, max: 99)])
    }
    
    public func eventCheck() -> (String, String) {
        let focus = eventFocusTable[rnd.getInt(min: 0, max: 99)]
        let detail = actionTable1[rnd.getInt(min: 0, max: 99)] + " " + actionTable2[rnd.getInt(min: 0, max: 99)]
        
        return (focus, detail)
    }
    
    public func sceneChange() -> (SceneChangeResult, (String, String)) {
        let roll = rnd.getInt(min: 1, max: 10)
        let change: SceneChangeResult = roll <= chaos && roll % 2 == 0 ? .altered : roll <= chaos && roll % 2 != 0 ? .interrupt : .none
        
        return (change, eventCheck())
    }
    
    public func npcDisposition(activeDescriptorsModifier: Int) -> (String, Int) {
        dispositionRoll = rnd.getInt(min: 1, max: 10) + rnd.getInt(min: 1, max: 10)
        var result: String
        (result, _disposition) = getNPCDisposition()
        
        return (result, npcDispositionModToDesc(mod: _disposition))
    }
    
    public func npcAction() -> (String, Bool, String, Int) {
        let roll = rnd.getInt(min: 1, max: 10)
        let action1 = npcActionTable1[roll - 1]
        
        var action = false
        var actionMod = 0
        var action2 = ""
        
        if roll == 6 {
            dispositionRoll += 2
            if dispositionRoll > 20 { dispositionRoll = 20 }
            (_, _disposition) = getNPCDisposition()
        }
        else if roll == 7 {
            dispositionRoll -= 2
            if dispositionRoll < 2 { dispositionRoll = 2 }
            (_, _disposition) = getNPCDisposition()
        }
        else if roll == 8 { action = true }
        else if roll == 9 {
            action = true
            actionMod = -4
        }
        else if roll == 10 {
            action = true
            actionMod = 4
        }
        
        if action {
            var roll2 = rnd.getInt(min: 1, max: 10) + rnd.getInt(min: 1, max: 10) + actionMod + _disposition
            if roll2 > 13 { roll2 = 13 }
            else if roll2 < 0 { roll2 = 0 }
            
            action2 = npcActionTable2[roll2]
        }
        
        return (action1, action, action2, self.disposition)
    }
    
    private func getNPCDisposition() -> (String, Int) {
        let rollMod = dispositionRoll + _activeDescriptors + 4
        let rollResult = rollMod > 20 ? 20 : rollMod < 0 ? 0 : rollMod

        let result = npcDispositionTable[rollResult]
        
        return result
    }
    
    private func npcDispositionModToDesc(mod: Int) -> Int {
        var value = 0
        if mod <= -2 { value = 0 }
        else if mod <= 0 { value = 1 }
        else if mod <= 2 { value = 2 }
        else if mod <= 4 { value = 3 }
        else if mod > 4 { value = 3 }
        
        return value
    }
    
    private func npcDispositionDescToMod(desc: Int) -> Int {
        var value = 0
        if desc <= 0 { value = -2 }
        else if desc == 1 { value = 0 }
        else if desc == 2 { value = 2 }
        else if desc >= 3 { value = 4 }
        
        return value
    }
    
    // MARK: Properties
    public var odds: Int { // 0 - 8
        set {
            var val: Int
            if newValue > 8 { val = 8 }
            else if newValue < 0 { val = 0 }
            else { val = newValue }
            
            val -= 4
            val *= 2
            
            _odds = val
        }
        get {
            return _odds
        }
    }
    
    public var disposition: Int {
        set {
            if newValue <= 0 { dispositionRoll = 4 }
            else if newValue == 1 { dispositionRoll = 7 }
            else if newValue == 2 { dispositionRoll = 11 }
            else if newValue >= 3 { dispositionRoll = 18 }
            (_, _disposition) = getNPCDisposition()
        }
        get {
            return npcDispositionModToDesc(mod: _disposition)
        }
    }
    
    public var activeDescriptors: Int {
        set {
            _activeDescriptors = newValue * 2
            (_, _disposition) = getNPCDisposition()
        }
        get {
            return _activeDescriptors / 2
        }
    }
}
let oracle = Oracle()
