//
//  ExerciseTab.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ExerciseTab: View {
    static let horizPadding: CGFloat = 10.0
    let fontDSize: CGFloat = 17.0
    
    var exercise: GenExercise
    
    var body: some View {
        var allBodyParts = ""
        
        for text in self.exercise.bodyPartsToString() {
            allBodyParts += text
        }
        
        return VStack {
            VStack (spacing: 0) {
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito-Bold", size: 22))
                        .padding(0)
                    
                    Text(allBodyParts)
                        .font(.custom("Nunito-Regular", size: 14))
                        .lineLimit(1)
                        .padding(0)
                        
                }
                .padding(.bottom, 4)
                .padding(.horizontal, ExerciseTab.horizPadding)
                .frame(width: Constants.screenWidth * 0.88, alignment: .leading)
                
                
                Divider()
                    .frame(width: Constants.screenWidth * 0.84, alignment: .center)
                    .padding(.top, 1)
                    .background(CustomColors.darkishred)
                
                VStack (alignment: .leading) {
                    Text(exercise.description)
                    .lineSpacing(0)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito-Regular", size: fontDSize))
                }
                .padding(.top, 10)
                .padding(.horizontal, 10)
                .frame(width: Constants.screenWidth * 0.88, height: fontDSize * 6, alignment: .topLeading)

                
                
            }
            .padding(12)
            .frame(width: Constants.screenWidth * 0.88)
            .background(Color.white)
            .clipped()
            .shadow(radius: 2, y: 1)

        }
        .frame(width: Constants.screenWidth)

        
    }

        
        

}

struct ExerciseTab_Previews: PreviewProvider {
    
    static var previews: some View {
        ExerciseTab(exercise: ExerciseList.allExercisesArray[0][0])
    }
}
