//
//  AddingExerciseTab.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/21/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct AddingExerciseTab: View {
    var exercise: GenExercise
    @Binding var setsNum: Int
    @Binding var timeNum: [Int]
    
    var body: some View {
        HStack (alignment: .center) {
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .multilineTextAlignment(.leading)
                    .font(.custom("Nunito-Regular", size: 20))
                    .padding(0)
            }
            
            
            Spacer()
            Divider()
                
            
            VStack (alignment: .leading) {
                HStack {
                    Text("Sets:")
                        .font(.custom("Nunito-Regular", size: 18))
                        .padding(2)
                    NumPickerH(numValue: self.$setsNum, numIncrement: 1, fontName: "Nunito-Light", fontSize: 18, minLimit: 1)
                }
                HStack {
                    Text("Rest:")
                        .font(.custom("Nunito-Regular", size: 18))
                        .padding(2)
                    TimePickerH(timeValue: self.$timeNum, numIncrement: 5, fontName: "Nunito-Light", fontSize: 18, minLimit: 6)
                }

            }.padding(.horizontal, 15)
            

        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .frame(width: Constants.screenWidth * 0.88, height: 84)
        .background(Color.white)
        .clipped()
        .shadow(radius: 2, y: 1)
        

    }
}

struct AddingExerciseTab_Previews: PreviewProvider {
    static var previews: some View {
        AddingExerciseTab(exercise: ExerciseList.allExercisesArray[0][0], setsNum: Binding.constant(1), timeNum: Binding.constant([1, 0]))
            .background(CustomColors.darkGrayBackground)
    }
}
