//
//  CustomNavBar.swift
//  Big O Fit
//
//  Created by Home on 7/12/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CustomNavBar: View {
    @Binding var selection: Int
    @ObservedObject var viewRouter: ViewRouter
    let height = UIScreen.main.bounds.size.height
    let width = UIScreen.main.bounds.size.width
    
    let requiresAddButton: [PageTrack] = [
                    .workoutMain
                ]
    let requiresBackButton: [PageTrack] = [
                    .workoutAddPage,
                    .workoutQuickStartPage,
                    .workoutSpecificPage,
                    .createAddExercise,
                    .createSearchExercise,
                    .createSearchMuscleGroupMain,
                    .createSearchMuscleGroupIncluded
                ]
    
    let addScreens: [PageTrack] = [.workoutAddPage, .createMain, .createMain, .createMain, .createMain]
    let backScreens: [[PageTrack? : PageTrack]] = [
            [nil: .workoutMain],
            [nil: .groupsMain],
            [nil: .searchMain],
            [nil: .createMain,
                .createSearchMuscleGroupMain: .createAddExercise,
                .createSearchMuscleGroupIncluded: .createAddExercise,
                .createSearchExercise: .createAddExercise],
            [nil: .profileMain]
        ]
    
    
    var body: some View {
        let title = determineTitle()
        
        return HStack {
            genLeftButton()
            Spacer()
            
            VStack(alignment: .center) {
                Text(title)
                    .font(.custom("Nunito-Bold", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            genRightButton()

        }
        .edgesIgnoringSafeArea(.top)
        .frame(maxWidth: .infinity)
        .frame(height: height / 15)
        .padding(.top, 22)
        .padding(.bottom, 4)
        .background(Color(red: 200/255, green: 15/255, blue: 40/255, opacity: 0.75))
        
    }
    
    
    
    func determineTitle() -> String {
        var title: String = ""
        
        switch viewRouter.currentFivePage[self.selection] {
        case .workoutMain:
            title = "Workouts"
        case .workoutAddPage:
            title = "Add Workouts"
        case .workoutQuickStartPage:
            title = "Quick Start"
        case .workoutSpecificPage:
            title = "Workout"
        case .groupsMain:
            title = "Groups"
        case .searchMain:
            title = "Search"
        case .createMain:
            title = "Create"
        case .profileMain:
            title = "Profile"
        case .createAddExercise:
            title = "Add Exercise"
        case .createSearchExercise:
            title = "Search Exercise"
        case .createSearchMuscleGroupMain:
            title = "Search Muscle"
        case .createSearchMuscleGroupIncluded:
            title = "Search Muscle"
        }
        
        return title
    }
    
    
    func genLeftButton() -> some View {
        return Section {
            if self.requiresBackButton.contains(viewRouter.currentFivePage[self.selection])  {
                Button(action: {
                    var selectionPage: PageTrack? = self.viewRouter.currentFivePage[self.selection]
                    
                    if !self.backScreens[self.selection].keys.contains(selectionPage) {
                        selectionPage = nil
                    }
                    
                    self.viewRouter.currentFivePage[self.selection] = self.backScreens[self.selection][selectionPage] ?? PageTrack.workoutMain
                }) {
                    Image(systemName: "arrow.left")
                    .padding(.horizontal, 14)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                }
                

            } else {
                Image(systemName: "plus")
                    .padding(.horizontal, 15)
                    .font(.system(size: 22))
                    .hidden()
            }
        }

    }
    
    
    func genRightButton() -> some View {
        return Section {
            if requiresAddButton.contains(viewRouter.currentFivePage[self.selection]) {
                Button(action: {
                    self.viewRouter.currentFivePage[self.selection] = self.addScreens[self.selection]
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                }
            } else {
                Image(systemName: "plus")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .padding(.horizontal, 15)
                    .hidden()
            }
        }
    }
    
}

struct CustomNavBar_Previews: PreviewProvider {
    var height = UIScreen.main.bounds.size.height
    var width = UIScreen.main.bounds.size.width
    
    static var previews: some View {
        CustomNavBar(selection: Binding.constant(0), viewRouter: ViewRouter())
    }
}
