//
//  ActiveWorkoutMotherView.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/21/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ActiveWorkoutMotherView: View {
    @ObservedObject var routine: Routine
    
    var body: some View {
        VStack {
            if !routine.completed {
                ActiveWorkout(routine: routine)
            } else {
                VStack {
                    Text("Workout Completed")
                }
            }
        }
    }
}

struct ActiveWorkoutMotherView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveWorkoutMotherView(routine: ExerciseList.sampleRoutine)
    }
}
