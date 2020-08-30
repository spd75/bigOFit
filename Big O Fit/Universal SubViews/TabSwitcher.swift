//
//  DoubleTabSwitcher.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct TabSwitcher: View {
    var textArr: [String]
    @Binding var currentTab: Int
    
    var fontSize: CGFloat?
    

    
    var body: some View {
        var choiceBC: [Color] = []
        var choiceTC: [Color] = []
        var choiceFont: [String] = []
        
        for i in 0..<self.textArr.count {
            if i == self.currentTab {
                choiceBC.append(CustomColors.darkishred)
                choiceTC.append(Color.white)
                choiceFont.append("Nunito-Regular")
            } else {
                choiceBC.append(Color.white)
                choiceTC.append(Color.black)
                choiceFont.append("Nunito-Regular")
            }
            
        }

        
        return HStack (spacing: 0) {
            ForEach(0..<textArr.count, id: \.self) { i in
                Section {
                    Text(self.textArr[i])
                        .font(.custom(choiceFont[i], size: self.fontSize ?? 17))
                }
                .padding(5)
                .frame(width: Constants.screenWidth / CGFloat(self.textArr.count + 1))
                .background(choiceBC[i])
                .foregroundColor(choiceTC[i])
                .onTapGesture {
                    self.currentTab = i
                }
            }
            
        }
    }
}

struct TabSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        TabSwitcher(textArr: ["First", "Second", "Third"], currentTab: Binding.constant(0))
    }
}
