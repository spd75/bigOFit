//
//  HorizontalPicker.swift
//  Big O Fit
//
//  Created by Home on 7/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct NumPickerH: View {
    @Binding var numValue: Int
    let numIncrement: Int
    var fontName: String?
    var fontSize: CGFloat?
    var fontColor: Color?
    
    static let increment = 10
    @State var checkAddX = NumPickerH.increment
    @State var checkSubX = -NumPickerH.increment
    
    var body: some View {
        Text(String(numValue))
            .font(.custom(self.fontName ?? "Nunito-Regular", size: self.fontSize ?? 20))
            .foregroundColor(self.fontColor ?? Color.black)
        .gesture(
            DragGesture()
                .onChanged({ gest in
                    let currentX = Int(gest.location.x - gest.startLocation.x)
                    
                    if currentX > self.checkAddX {
                        self.checkAddX += NumPickerH.increment
                        self.checkSubX += NumPickerH.increment
                        self.numValue += self.numIncrement
                    } else if currentX < self.checkSubX {
                        self.checkAddX -= NumPickerH.increment
                        self.checkSubX -= NumPickerH.increment
                        self.numValue -= self.numIncrement
                    }
                })
                .onEnded({ gest in
                    self.checkAddX = NumPickerH.increment
                    self.checkSubX = -NumPickerH.increment
                })
        )
    }
}

struct NumPickerH_Previews: PreviewProvider {
    static var previews: some View {
        NumPickerH(numValue: Binding.constant(50), numIncrement: 5)
    }
}
