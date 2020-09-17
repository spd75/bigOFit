//
//  Routine.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


/** A Routine object is the outline for each specific Workout performed.
    
    Fields:
        - name: the name of the routine
        - description: the description of the routine
        - exercises: a 2D array of GenExercises which represents all the exercises performed
        - restArr: a 2D array of Ints which each holds the resting time for a certain exercise in self.exercises
 */


class Routine: ObservableObject, Hashable {
    
    /// Function to conform to Hashable
    static func == (lhs: Routine, rhs: Routine) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description && lhs.exercises == rhs.exercises
    }
    
    /// Function to conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.description)
    }
    
    
    /// Check lines 17-23 for field documentation
    var name: String
    var description: String
    var exercises: [[GenExercise]]
    var restArr: [[Int]]
    
    
    /** The only constructor for a Routine.
            - Parameter name: assigned to name
            - Parameter description: assigned to description
            - Parameter exercises: assigned to exercises -- Post-Condition: all sub arrays must contain different instances of the same genExercise to represent multiple sets of the same exercise
            - Parameter restArr: assigned to restArr */
    init(name: String, description: String, exercises: [[GenExercise]], restArr: [[Int]]) {
        self.name = name
        self.description = description
        self.exercises = exercises
        self.restArr = restArr
    }
    
    
}
