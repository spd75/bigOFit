//
//  ActionButton.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/24/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ActionButton: View {
    var text: String
    var widthRatio: CGFloat?
    var fontName: String?
    var fontSize: CGFloat?
    var buttonColor: Color?
    var buttonPadding: CGFloat?
    var textColor: Color?
    var shadow: CGFloat?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
                Section {
                    Text(text)
                        .font(.custom(fontName ?? "Nunito-SemiBold", size: fontSize ?? 24))
                        .foregroundColor(textColor ?? Color.white)
                    
                }
                .shadow(radius: 10)
                .frame(width: Constants.screenWidth * (widthRatio ?? 0.78))
                .padding(.vertical, buttonPadding ?? 15)
                .background(buttonColor ?? CustomColors.darkishred)
                .clipped()
                .shadow(color: Color(red: 136/255, green: 136/255, blue: 136/255), radius: shadow ?? 3, y: 1)
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(text: "Test", action: {})
    }
}
