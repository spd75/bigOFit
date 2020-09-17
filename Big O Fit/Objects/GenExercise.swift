//
//  GenExercise.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

/** GenExercise provides the outline for a specific exercise. This exercise is then repeatable and is used with SpecExercise to create certain instances of the exercise performed within workouts. It contains the exercise name, description, body parts, etc.
 
    GenExercise is like the outline, SpecExercise is all the specific instances of that outline occuring.  For example, a Push-Up would be an example of a SpecExercise.  However, everytime I decided to do a set of Push-Ups, a SpecExercise would be used to represent this.
 
    Fields:
        - name: the name of the exercise
        - description: the description of the exercise
        - bodyParts: an array that holds the bodyparts of the exercise, which are represented with the BodyPart enum
        - categoryString: category string holds the name of the main body part to which the exercise belongs
        - @Published workoutsIn: tracks in which workout this exercise was performed
        - @Published workoutsInLocator: a [[Int]] that contains the indicies of where this exercise was performed in each set of each workout
        - @Published personalRecord: tracks the personal record ever performed on this exercise
 */


class GenExercise: Hashable, ObservableObject {
    
    
    /// Function to conform to Hashable
    static func == (lhs: GenExercise, rhs: GenExercise) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description
    }
    
    
    /// Function to conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.description)
    }
    
    
    /// Converts each BodyPart to its corresponding string
    static let bodyPartsToName: Dictionary<BodyPart, String>  = [
        BodyPart.forearms: "Forearms",
        BodyPart.biceps: "Biceps",
        BodyPart.triceps: "Triceps",
        BodyPart.shoulders: "Shoulders",
        BodyPart.frontShoulders: "Front Shoulders",
        BodyPart.outerShoulders: "Outer Shoulders",
        BodyPart.rearShoulders: "Rear Shoulders",
        BodyPart.chest: "Chest",
        BodyPart.traps: "Traps",
        BodyPart.lats: "Lats",
        BodyPart.upperabs: "Upper Abs",
        BodyPart.lowerabs: "Lower Abs",
        BodyPart.glutes: "Glutes",
        BodyPart.quads: "Quads",
        BodyPart.hamstrings: "Hamstrings",
        BodyPart.calves: "Calves",
        BodyPart.other: "Other"
    ]
    
    
    /// Converts each name to its corresponding BodyPart
    static let nameToBodyParts: Dictionary<String, BodyPart>  = [
        "Forearms": BodyPart.forearms,
        "Biceps": BodyPart.biceps,
        "Triceps": BodyPart.triceps,
        "Shoulders": BodyPart.shoulders,
        "Front Shoulders": BodyPart.frontShoulders,
        "Rear Shoulders": BodyPart.rearShoulders,
        "Chest": BodyPart.chest,
        "Traps": BodyPart.traps,
        "Lats": BodyPart.lats,
        "Upper Abs": BodyPart.upperabs,
        "Lower Abs": BodyPart.lowerabs,
        "Glutes": BodyPart.glutes,
        "Quads": BodyPart.quads,
        "Hamstrings": BodyPart.hamstrings,
        "Calves": BodyPart.calves,
        "Other": BodyPart.other
    ]
    
    
    /// Organizes all the category names into an array of all the belonging BodyParts
    static let bodyPartCategories: Dictionary<String, [BodyPart]> = [
        "Arms": [.forearms, .biceps, .triceps, .shoulders, .frontShoulders, .outerShoulders, .rearShoulders],
        "Chest": [.chest],
        "Back": [.lats, .traps],
        "Core": [.upperabs, .lowerabs],
        "Legs": [.glutes, .quads, .calves, .hamstrings]
    ]
    
    
    /// Check lines 14-20 for field documentation
    var name: String
    var description: String
    var bodyParts: [BodyPart]
    var categoryString: String
    
    @Published var workoutsIn: [Workout] = []
    @Published var workoutsInLocator: [[Int]] = []
    @Published var personalRecord: Int = 0
    
    
    
    /** Only constructor for a GenExercise
        - Parameter name: assigned to name
        - Parameter description: assigned to description
        - Parameter bodyParts: assigned to bodyParts */
    
    init(name: String, description: String, bodyParts: [BodyPart]) {
        self.name = name
        self.description = description
        self.bodyParts = bodyParts
        
        if bodyParts.count <= 0 {
            self.categoryString = "Other"
        } else {
            self.categoryString = GenExercise.assignCategory(mainBodyPart: bodyParts[0])
        }
        
    }
    
    
     
    /** Converts all elements in self.bodyParts to a readable string
            - Returns: an array of all BodyPart names used in this genExercise */
    
    func bodyPartsToString() -> [String] {
        var bodyPartsString: [String] = []
        
        for i in 0..<self.bodyParts.count {
            let nameComma = i == (self.bodyParts.count - 1) ? "\(GenExercise.bodyPartsToName[self.bodyParts[i]]!)"
                                    : "\(GenExercise.bodyPartsToName[self.bodyParts[i]]!), "
            bodyPartsString.append(nameComma)
        }
        
        return bodyPartsString
    }
    
    
    /** Assigns a category name to this genExercise
            - Parameter mainBodyPart: the mainBodyPart to convert to
            - Returns: the category string of the main BodyPart which is used to assign the genExercise to a certain group within the ExerciseAllGroup subview. */
    
    static func assignCategory(mainBodyPart: BodyPart) -> String {
        for key in GenExercise.bodyPartCategories.keys {
            if GenExercise.bodyPartCategories[key]?.contains(mainBodyPart) ?? false {
                return key
            }
        }
        
        return "Other"
    }
    
    
    /** Adds a workout to self.workoutsIn, which signifies this exercise was used in another workout. It also adds the corresponding location into self.workoutsInLocator which represents where this genExercise is found within the new workout added.
            - Parameter workout: the workout that recently contained this genExercise within its Routine */
    
    func addToWorkoutsIn(workout: Workout) {
        if workout.exercisesPerformed.contains(self) {
            workoutsIn.append(workout)
            var locator: [Int] = []
            for i in 0..<workout.exercisesPerformed.count {
                if workout.exercisesPerformed[i] == self {
                    locator.append(i)
                }
            }
            self.workoutsInLocator.append(locator)
        }
    }
    
    
    /** Updates the personal best (highest weight) for this exercise if the new weight is greater than the current personal record.
            - Parameter weight: new weight to be compared to the current personal record. */
    
    func updatePersonalRecord(weight: Int) {
        self.personalRecord = self.personalRecord < weight ? weight : self.personalRecord
    }
    
}

