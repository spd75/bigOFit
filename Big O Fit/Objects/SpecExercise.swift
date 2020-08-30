//
//  SpecExercise.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class SpecExercise: Hashable, ObservableObject {
    static func == (lhs: SpecExercise, rhs: SpecExercise) -> Bool {
        return lhs.name == rhs.name && lhs.genExercise == rhs.genExercise && lhs.rest == rhs.rest
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.genExercise)
        hasher.combine(self.rest)
    }
    
    var name: String
    var genExercise: GenExercise
    var rest: [Int]
    
    @Published var weight: Int?
    @Published var reps: Int?
    @Published var weightStr: String = "-"
    @Published var repsStr: String = "-"
    
    
    init(exercise: GenExercise, rest: [Int]) {
        self.genExercise = exercise
        self.name = exercise.name
        self.rest = rest
    }
    
    func setResults(weight: Int, reps: Int) {
        self.weight = weight
        self.reps = reps
        self.weightStr = weight < 0 ? "BW" : String(weight)
        self.repsStr = String(reps)
        self.genExercise.updatePersonalRecord(weight: weight)
    }
    
}
