//
//  CreateMotherView.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

/**
    #MotherViews
 */
struct CreateMotherView: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var allExercises: [[GenExercise]] = ExerciseList.allExercisesArray
    @State var createExerciseName: String = ""
    @State var createExerciseDescription: String = ""
    @State var createMainBodyPart: [String] = []
    @State var createIncludedBodyPart: [String] = []
    
    var body: some View {
        
        return VStack {
            if viewRouter.currentFivePage[3] == .createMain {
                CreateView(viewRouter: self.viewRouter, allExercises: $allExercises, newWorkoutName: $createExerciseName, newWorkoutDesc: $createExerciseDescription)
                    
            } else if viewRouter.currentFivePage[3] == .createAddExercise {
                CreateExercise(viewRouter: self.viewRouter, workoutName: $createExerciseName, description: $createExerciseDescription, allExercises: $allExercises, mainList: $createMainBodyPart, includedList: $createIncludedBodyPart)
            } else if viewRouter.currentFivePage[3] == .createSearchMuscleGroupMain {
                SearchScreen(viewRouter: self.viewRouter, searchTitle: "Search muscle groups", returnPage: PageTrack.createAddExercise, searchOptions: Array(GenExercise.bodyPartsToName.values.sorted()), selectedOptions: $createMainBodyPart)
            } else if viewRouter.currentFivePage[3] == .createSearchMuscleGroupIncluded {
                SearchScreen(viewRouter: self.viewRouter, searchTitle: "Search muscle groups", returnPage: PageTrack.createAddExercise, searchOptions: Array(GenExercise.bodyPartsToName.values.sorted()), selectedOptions: $createIncludedBodyPart)
            }
        }.background(CustomColors.grayBackground)
    }
    
}

struct CreateMotherView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMotherView(viewRouter: ViewRouter())
    }
}
