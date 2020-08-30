//
//  ExerciseBox.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/20/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ExerciseBox: View {
    var exercises: [SpecExercise]   /// The array of exercises provided, where each exercise represents a set
    var titleSpacing: CGFloat?      /// The spacing between the title and body of the container
    var titleFont: String?          /// Font name for the title
    var setFont: String?            /// Font name for the body
    var titleFontSize: CGFloat?     /// Font size for the title
    var setFontSize: CGFloat?       /// Font size for the body
    var fontColor: Color?           /// Font color fo the entire container
    var titleIndent: CGFloat?       /// Indent from left part of screen for the title
    var setIndent: CGFloat?         /// Indent from left part of screen for the body
    
    
    var body: some View {
        VStack {
            
            /// The dividing line at the top of the view which seperates all ExerciseBoxes from each other
            /// when put together
            Divider().foregroundColor(.white)
                .padding(.bottom, 1)
                .background(fontColor ?? Color.white)
            
            /// The title row which contains the name of the exercise and no weight or rep data
            TextRow(leftText: exercises[0].name, fontColor: self.fontColor)
                .padding(.bottom, titleSpacing ?? 0)
            
            ForEach(0..<exercises.count, id: \.self) { i in
                /// Each row which displays information of the respective set
                ExerciseRow(exercise: self.exercises[i], leftText: "Set \(i + 1)", fontName: self.setFont, fontSize: self.setFontSize, fontColor: self.fontColor, leftIndent: self.setIndent ?? 0)
            }
        }
        
    }
}

struct ExerciseBox_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseBox(exercises: ExerciseList.sampleWorkout.specExercises[0], titleSpacing: 4, setIndent: 30)
            .background(CustomColors.darkishred)
    }
}
