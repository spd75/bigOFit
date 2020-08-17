//
//  SpecExercise.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class SpecExercise {
    var name: String
    var genExercise: GenExercise
    var rest: Int
    var weight: Int?
    var reps: Int?
    
    
    init(exercise: GenExercise, rest: Int) {
        self.genExercise = exercise
        self.name = exercise.name
        self.rest = rest
    }
    
    func setResults(weight: Int, reps: Int) {
        self.weight = weight
        self.reps = reps
    }
    
}
