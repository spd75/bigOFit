//
//  ExerciseTab.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ExerciseTabData: View {
        static let horizPadding: CGFloat = 10.0
        let fontDSize: CGFloat = 17.0
        
        var exercise: GenExercise
        
        var body: some View {
            var allBodyParts = ""
            
            for text in self.exercise.bodyPartsToString() {
                allBodyParts += text
            }
            
            return VStack {
                VStack(alignment: .center) {
                    Text(exercise.name)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito-Bold", size: 22))
                        .padding(0)
                    
                    Text(allBodyParts)
                        .font(.custom("Nunito-Regular", size: 14))
                        .lineLimit(1)
                        .padding(0)
                        
                }
            }
            .padding(10)
            .frame(width: Constants.screenWidth * 0.75)
            .background(Color.white)
            .clipped()
            .shadow(radius: 5)

            
    }
            

}

struct ExerciseTabData_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTabData(exercise: ExerciseList.allExercisesArray[0][0])
    }
}
