//
//  ActiveHolder.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/27/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

/** Simple class used to hold data for the current routines and workouts selected to perform a specExercie in the app.
 
    Fields:
        - routine: the Routine currently selected
        - workout: the Workout currently selected
 */


class ActiveHolder: ObservableObject {
    var routine: Routine? = nil
    var workout: Workout? = nil
}
