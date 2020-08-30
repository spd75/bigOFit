//
//  TextRow.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/21/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct TextRow: View {
    var leftText: String?       /// The text being put in the leftmost text view
    var rightText1: String?     /// The text second to the right edge of the screen
    var rightText2: String?     /// The text to the right most edge of the screen
    var fontName: String?       /// The name of the font style to be used
    var fontSize: CGFloat?      /// Size of font
    var fontColor: Color?       /// Color of font
    var leftIndent: CGFloat?    /// Space indented from the left most part of screen
    
    
    var body: some View {
        HStack {
            /// The leftmost text which usually contains either the exercise name or set number
            Text(leftText ?? "")
                .padding(.leading, leftIndent ?? 0)
                .font(.custom(fontName ?? "Nunito-Bold", size: fontSize ?? 20))
                .frame(width: Constants.screenWidth * 0.52, alignment: .leading)
            
            /// The first text view on the right which contains the weight of the exercise
            Text(rightText1 ?? "")
                .font(.custom(fontName ?? "Nunito-Bold", size: fontSize ?? 20))
                .frame(width: Constants.screenWidth * 0.15)
            
            /// The second text view on the right which contains the repititions of the exercise
            Text(rightText2 ?? "")
                .font(.custom(fontName ?? "Nunito-Bold", size: fontSize ?? 20))
                .frame(width: Constants.screenWidth * 0.15)
        }.foregroundColor(fontColor ?? .white)
    }
}

struct TextRow_Previews: PreviewProvider {
    static var previews: some View {
        TextRow(leftText: "Exercise", rightText1: "Wt.", rightText2: "Rps.").background(CustomColors.darkishred)
    }
}
