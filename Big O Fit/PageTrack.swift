//
//  ExerciseNav.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


/** PageTrack provides all options that determine which page the app is currently on.  This is crucial for
    app navigation since this app does not utilize the traditional "navigation view."
 */
enum PageTrack {
    case    workoutMain,
            workoutAddPage,
            workoutQuickStartPage,
            workoutSpecificPage,
            groupsMain,
            searchMain,
            createMain,
            createAddExercise,
            createSearchExercise,
            createSearchMuscleGroupMain,
            createSearchMuscleGroupIncluded,
            profileMain
}


/** ViewRouter is an ObservableObject that is used across many views in the app.  ViewRouter allows for a single
    object to track the current page of the app through the currentPage variable.
    - Note: Using a class like this helps for tasks such as automatically updating the navigation bar to display different
            text and working with a TabbedView style layout.
 */
class ViewRouter: ObservableObject {
    let objectWillChange = PassthroughSubject<ViewRouter, Never>()
    var currentFivePage: [PageTrack] = [.workoutMain, .groupsMain, .searchMain, .createMain, .profileMain] {
        didSet {
            objectWillChange.send(self)
        }
    }
}
