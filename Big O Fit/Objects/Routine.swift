//
//  Routine.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class Routine: ObservableObject {
    @Published var completed: Bool = false
    
    var exercises: [[SpecExercise]]
    
    var name: String
    var currentExerciseInd: [Int]
    var currentExercise: SpecExercise
    var changedSpecExercise: Int = 0
    
    init(name: String, exercises: [[SpecExercise]]) {
        self.name = name
        self.exercises = exercises
        self.currentExerciseInd = [0, 0]
        self.currentExercise = exercises[self.currentExerciseInd[0]][self.currentExerciseInd[1]]
    }
    
    
    init(name: String, exercises: [[SpecExercise]], currentExerciseInd: [Int]) {
        self.name = name
        self.exercises = exercises
        self.currentExerciseInd = currentExerciseInd
        self.currentExercise = exercises[self.currentExerciseInd[0]][self.currentExerciseInd[1]]
    }
    
    func setNextExerciseCurrent() {
        let set = currentExerciseInd[0]
        let rep = currentExerciseInd[1]
        let lastRep = self.exercises[set].count - 1
        let lastSet = self.exercises.count - 1
        
        if rep + 1 > lastRep {
            if set + 1 > lastSet {
                self.completed = true
            } else {
                self.currentExerciseInd = [set + 1, 0]
                self.currentExercise = self.exercises[set + 1][0]
            }
        } else {
            self.currentExerciseInd = [set, rep + 1]
            self.currentExercise = self.exercises[set][rep + 1]
        }
        
    }
    
    func setCurrentExerciseStats(weight: Int, reps: Int) {
        currentExercise.setResults(weight: weight, reps: reps)
    }
    
    func setSpecificExerciseStat(exerciseInd: [Int], weight: Int, reps: Int) {
        self.exercises[exerciseInd[0]][exerciseInd[1]].setResults(weight: weight, reps: reps)
    }
    
    func changeCurrentExercise(currentExerciseInd: [Int]) {
        if currentExerciseInd[0] < self.exercises.count && currentExerciseInd[1] < self.exercises[currentExerciseInd[0]].count {
            self.currentExerciseInd = currentExerciseInd
            self.currentExercise = self.exercises[currentExerciseInd[0]][currentExerciseInd[1]]
        }
        
    }
    
    func getCurrentRest() -> [Int] {
        return currentExercise.rest
    }
}
