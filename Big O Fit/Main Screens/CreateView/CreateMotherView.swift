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
    @EnvironmentObject var user: BigOFitUser
    @ObservedObject var viewRouter: ViewRouter
    
    @State var exerciseInfo: [[[Int]]] = []
    @State var tabTracker = 0
    @State var currentSpecRoutine: Routine = Routine(name: "first", description: "", exercises: [], restArr: [])
    
//    @State var createExerciseName: String = InputTextHolder(charLimit: 5).text
//    @State var createExerciseDescription: String = InputTextHolder(charLimit: 5).text
//    @State var createRoutineName: String = InputTextHolder(charLimit: 5).text
//    @State var createRoutineDescription = InputTextHolder(charLimit: 5).text
    
    
    @State var exerciseNameHold = ""
    @State var exerciseDescriptionHold = ""
    @State var routineNameHold = ""
    @State var routineDescriptionHold = ""
    @State var subtext = "No exercises added to routine yet."
    
    @State var createMainBodyPart: [String] = []
    @State var createIncludedBodyPart: [String] = []
    @State var createExerciseList: [String] = []
    
    var body: some View {
        print("Says: \(exerciseNameHold)")
        
        return VStack {
            if viewRouter.currentFivePage[3] == .createMain {
                CreateView(viewRouter: self.viewRouter, tabTracker: $tabTracker, currentSpecRoutine: $currentSpecRoutine, newWorkoutName: $exerciseNameHold, newWorkoutDesc: $exerciseDescriptionHold, newWorkoutMainBodyPart: $createMainBodyPart, newWorkoutIncludedBodyPart: $createIncludedBodyPart, routineName: $routineNameHold, routineDescription: $routineDescriptionHold, exerciseStringArray: $createExerciseList, exerciseInfo: $exerciseInfo)
            } else if viewRouter.currentFivePage[3] == .createAddExercise {
                CreateExercise(viewRouter: self.viewRouter, name: $exerciseNameHold, desc: $exerciseDescriptionHold, mainList: $createMainBodyPart, includedList: $createIncludedBodyPart)
            } else if viewRouter.currentFivePage[3] == .createAddRoutine {
                CreateRoutine(viewRouter: self.viewRouter, exerciseStringArray: $createExerciseList, exerciseInfo: $exerciseInfo, conversionDict: self.user.genStringExerciseDict(), subText: self.$subtext, name: $routineNameHold, desc: $routineDescriptionHold)
            } else if viewRouter.currentFivePage[3] == .createSearchMuscleGroupMain {
                SearchScreen(viewRouter: self.viewRouter, search: Search(inputText: "", searchOptions: Array(GenExercise.bodyPartsToName.values.sorted())), searchTitle: "Search muscle groups", returnPage: PageTrack.createAddExercise, selectedOptions: self.$createMainBodyPart)
            } else if viewRouter.currentFivePage[3] == .createSearchMuscleGroupIncluded {
                SearchScreen(viewRouter: self.viewRouter, search: Search(inputText: "", searchOptions: Array(GenExercise.bodyPartsToName.values.sorted())), searchTitle: "Search muscle groups", returnPage: PageTrack.createAddExercise, selectedOptions: self.$createIncludedBodyPart)
            } else if viewRouter.currentFivePage[3] == .createSearchExercise {
                ExerciseSearchScreen(viewRouter: self.viewRouter, search: Search(inputText: "", searchOptions: self.user.getExerciseArrString()), searchTitle: "Search exercises", returnPage: PageTrack.createAddRoutine, selectedOptions: $createExerciseList, exerciseInfo: $exerciseInfo)
            } else if viewRouter.currentFivePage[3] == .createSpecificRoutine {
                ClickedRoutine(routine: $currentSpecRoutine)
            }
        }.background(CustomColors.grayBackground)
    }
    
}

struct CreateMotherView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMotherView(viewRouter: ViewRouter())
            .environmentObject(ExerciseList.getTestUser())
    }
}
