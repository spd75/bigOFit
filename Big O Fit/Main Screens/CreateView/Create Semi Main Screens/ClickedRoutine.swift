//
//  ClickedRoutine.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/23/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ClickedRoutine: View {
    @Binding var routine: Routine
    
    var body: some View {
        ScrollView {
                VStack {
                    Text(routine.name)
                        .font(.custom("Nunito-SemiBold", size: 30))
                    Text(routine.description)
                        .multilineTextAlignment(.center)
                        .font(.custom("Nunito-Regular", size: 18))
                        .frame(width: Constants.screenWidth * 0.88)
                        .padding(.top, 8)
                        .padding(.bottom, 13)

                    VStack {
                        ForEach(0..<self.routine.exercises.count, id: \.self) { i in
                            AddingExerciseTab(exercise: self.routine.exercises[i][0], setsNum: Binding.constant(self.routine.exercises[i].count), timeNum: Binding.constant(self.routine.restArr[i]))
                        }
                    }
                }.padding(18)
            .frame(width: Constants.screenWidth)
        }
        

    }
}

struct ClickedRoutine_Previews: PreviewProvider {
    static var previews: some View {
        ClickedRoutine(routine: Binding.constant(ExerciseList.sampleRoutine1))
    }
}
