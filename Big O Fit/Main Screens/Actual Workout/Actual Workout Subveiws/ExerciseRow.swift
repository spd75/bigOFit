//
//  ExerciseText.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/18/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ExerciseRow: View {
    @ObservedObject var exercise: SpecExercise  /// The exercise which contains the data which the row will output
    var leftText: String?                       /// The text being put in the leftmost text view
    var fontName: String?                       /// The name of the font style to be used
    var fontSize: CGFloat?                      /// Size of font
    var fontColor: Color?                       /// Color of font
    var leftIndent: CGFloat?                    /// Space indented from the left most part of screen
    
    
    var body: some View {
        
        /// The row of text
        TextRow(leftText: leftText ?? "", rightText1: exercise.weightStr, rightText2: exercise.repsStr, fontName: fontName, fontSize: fontSize, fontColor: fontColor, leftIndent: leftIndent)
    }
}


struct ExerciseText_Previews: PreviewProvider {
    static var previews: some View {
        TextRow(leftText: "Exercise", rightText1: "Wt.", rightText2: "Rps.").background(CustomColors.darkishred)
    }
}
