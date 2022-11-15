//
//  WheelSelector.swift
//  GME
//
//  Created by Ryan Anderson on 2/3/20.
//  Copyright © 2020 Ryan Anderson. All rights reserved.
//

import SwiftUI

struct WheelSelector: View {
     let OptionsArray: [String]
        @State var selected: Int
        @State var delegate: ContentView!
        var body: some View {
            Picker(selection: $selected, label: Text("")){
                ForEach(0..<OptionsArray.count){
                    Text(self.OptionsArray[$0]).tag($0)
                }
            }
            .padding(.horizontal)
            .frame(height: 300.0)
            .labelsHidden()
            .onTapGesture {
                if self.delegate != nil {
                    self.delegate.select(value: self.selected)
    //                self.delegate.selectorResult = self.selected
    //                self.delegate.showSelector = false
                }
            }
        }
}

struct WheelSelector_Previews: PreviewProvider {
    static var previews: some View {
        WheelSelector(OptionsArray: ["test1", "test2", "test3"], selected: 1)
    }
}
