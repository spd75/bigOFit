//
//  DoubleTabSwitcher.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct DoubleTabSwitcher: View {
    var leftText: String
    var rightText: String
    
    @Binding var isOnLeft: Bool
    
    var body: some View {
        let leftChoiceBC = isOnLeft ? CustomColors.darkishred : Color.white
        let leftChoiceTC = isOnLeft ? Color.white : Color.black
        let leftChoiceFont = isOnLeft ? "Nunito-Bold" : "Nunito-Regular"
        
        let rightChoiceBC = isOnLeft ? Color.white : CustomColors.darkishred
        let rightChoiceTC = isOnLeft ? Color.black : Color.white
        let rightChoiceFont = isOnLeft ? "Nunito-Regular" : "Nunito-Bold"

        
        
        return HStack (spacing: 0) {
            Section {
                Text(leftText)
                    .font(.custom(leftChoiceFont, size: 17))
            }
            .padding(5)
            .frame(width: Constants.screenWidth / 3)
            .background(leftChoiceBC)
            .foregroundColor(leftChoiceTC)
            .onTapGesture {
                self.isOnLeft = true
            }
            
            Section {
                Text(rightText)
                    .font(.custom(rightChoiceFont, size: 16))
                    
            }
            .padding(5)
            .frame(width: Constants.screenWidth / 3)
            .background(rightChoiceBC)
            .foregroundColor(rightChoiceTC)
            .onTapGesture {
                self.isOnLeft = false
            }
        }
    }
}

struct DoubleTabSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        DoubleTabSwitcher(leftText: "Exercises", rightText: "Routines", isOnLeft: Binding.constant(true))
    }
}
