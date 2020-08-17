//
//  Routine.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class Routine {
    var name: String
    var exercises: [[SpecExercise]]
    
    init(name: String, exercises: [[SpecExercise]]) {
        self.name = name
        self.exercises = exercises
    }
}
