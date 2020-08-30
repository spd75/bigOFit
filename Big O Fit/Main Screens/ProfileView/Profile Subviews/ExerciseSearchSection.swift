//
//  ExerciseSearchSection.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ExerciseSearchSection: View {
    @EnvironmentObject var user: BigOFitUser
    @ObservedObject var viewRouter: ViewRouter
    @Binding var currentExercise: GenExercise
    @Binding var text: String
    @Binding var remainingOptions: [String]
    @Binding var textFieldFrame: CGRect
   
    
    
    
    var body: some View {
        let exList = user.genStringExerciseDict()
        
        return VStack {
            TextField("Search Exercises", text: self.$text)
                .font(.custom("Nunito-Regular", size: 20))
                .frame(width: Constants.screenWidth * 0.78)
                .padding(10)
                .background(Color.white)
                .border(Color.gray)
                .clipped()
                .shadow(radius: 1, y: 1)
                .background(GeometryGetter(rect: self.$textFieldFrame))
            
            VStack (spacing: 8) {
                ForEach(self.remainingOptions, id: \.self) { exerciseName in
                    ExerciseTabData(exercise: exList[exerciseName]!)
                    .onTapGesture {
                        self.currentExercise = exList[exerciseName]!
                        self.viewRouter.currentFivePage[4] = .profileViewExerciseData
                    }
                }
            }.padding(.top, 10)
            
        }
        
    }
    
}

struct ExerciseSearchSection_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSearchSection(viewRouter: ViewRouter(), currentExercise: Binding.constant(ExerciseList.allExercisesArray[0][0]), text: Binding.constant(""), remainingOptions: Binding.constant([]), textFieldFrame: Binding.constant(CGRect()))
    }
}
