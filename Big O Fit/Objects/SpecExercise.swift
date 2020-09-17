//
//  SpecExercise.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


/** SpecExercise represents everytime a genExercise is used during a workout. A Workout is made up of a series of SpecExercises, which holds the data for the amount of reps and weight performed.
 
    GenExercise is like the outline, SpecExercise is all the specific instances of that outline occuring.  For example, a Push-Up would be an example SpecExercise.  However, everytime I decided to do a set of Push-Ups, a SpecExercise would be used to represent this.
 
    Fields:
        - name: the name of the exercise, which is just assigned to genExercise.name
        - genExercise: the exercise which provides most general information for this SpecExercise
        - rest: A 2 integer array which contains the rest necessary after this exercise - rest[0] holds minutes, rest[1] holds seconds
        = @Published weight: the number of weight lifted when this exercise is performed
        - @Published reps: the number of repititions performed in this instance of
        - @Published weightStr: the string used to display the weight lifted in certain Views
        - @Published repsStr: the string used to display the number of repititions performed in certain Views
 
 */

class SpecExercise: Hashable, ObservableObject {
    
    
    /// Function to conform to Hashable
    static func == (lhs: SpecExercise, rhs: SpecExercise) -> Bool {
        return lhs.name == rhs.name && lhs.genExercise == rhs.genExercise && lhs.rest == rhs.rest
    }
    
    
    /// Function to conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.genExercise)
        hasher.combine(self.rest)
    }
    
    
    /// Check lines 17-23 for field documentation
    var name: String
    var genExercise: GenExercise
    var rest: [Int]
    
    @Published var weight: Int?
    @Published var reps: Int?
    @Published var weightStr: String = "-"
    @Published var repsStr: String = "-"
    
    
    
    /** Only constructor for a SpecExercise
            - Parameter exercise: assigned to genExercise
            - Parameter rest: assigned to rest */
    
    init(exercise: GenExercise, rest: [Int]) {
        self.genExercise = exercise
        self.name = exercise.name
        self.rest = rest
    }
    
    
    /** Sets weight, reps, repsStr, and repsStr all in one method.  When a specExercise has just been performed, this method will likely be called to update its statistics.
            - Parameter weight: the weight lifted
            - Parameter reps: the number of repetitions of the weight lifted
     */
    
    func setResults(weight: Int, reps: Int) {
        self.weight = weight
        self.reps = reps
        self.weightStr = weight < 0 ? "BW" : String(weight)
        self.repsStr = String(reps)
        self.genExercise.updatePersonalRecord(weight: weight)
    }
    
}
