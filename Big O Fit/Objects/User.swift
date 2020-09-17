//
//  User.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/27/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

/** BigOFitUser is the class which keeps track of a user's data. In the completed version, the user's infomration will be stored in Firebase.
        
    Fields:
        - name: the name of the user
        - bio: the biography of the user which is usually displayed on the profile screen
        - profilePicName: the filename for the picture used
        - allExercises: all the exercises which a user
        - allRoutines: all the default routines plus the created routines a user has made
        
        - @Published friends: an array of other BigOFit friends the user has
        - @Published scheduledWorkouts: an array of all the workouts that the user has scheduled
        - @Published completedWorkouts: an array of all the workouts that the user has completed
        - @Published completedExercises: dicitonary of all the exercises that have been completed
        - @Published personalRecords: a dictionary of all the personal records that have been set
 */


class BigOFitUser: ObservableObject {
    
    // Check lines 13-24 to view field documentation.
    var name: String
    var bio: String
    var profilePicName: String
    var allExercises: [[GenExercise]]
    var allRoutines: [Routine]

    @Published var friends: [BigOFitUser]
    @Published var scheduledWorkouts: [Workout]
    @Published var completedWorkouts: [Workout]
    @Published var completedExercises: Dictionary<String, [GenExercise]>
    @Published var personalRecords: Dictionary<String, Dictionary<String, Int>>


    /** Only constructor for BigOFit user. Created everytime a user creates an account.
        - Parameter name: the name of the user -- set to empty string by default
        - Parameter bio: the bio of the user -- set to empty string by default
        - Parameter profilePicName: asigned to profilePicName */
    
    init(name: String = "", bio: String = "", profilePicName: String) {
        self.name = name
        self.bio = bio
        self.profilePicName = profilePicName

        self.allExercises = UserInitProps.defaultExer
        self.allRoutines = UserInitProps.routines

        self.friends = []
        self.scheduledWorkouts = []
        self.completedWorkouts = []
        self.personalRecords = [:]
        self.completedExercises = [:]
    }
    
    
    
    
    func addToScheduledWorkoutsArr(workout: Workout) {
        let current = DateTime.getUpdatedTime()
        let currentVal = DateTime.getDateTimeVal(comp: current)
        let workoutToVal = workout.getDateTimeVal()
        
        if workoutToVal < currentVal  {
            print("called because \(workoutToVal) is less than \(currentVal)")
            return
        }
        
        let originalSize = scheduledWorkouts.count
        var max = originalSize == 1 ? 1 : scheduledWorkouts.count - 1
        var min = 0
        var i = (max - min) / 2
        
        while max - min > 0 {
            let workoutInVal = self.scheduledWorkouts[i].getDateTimeVal()
            
            if workoutToVal <= workoutInVal {
                max = i
            } else {
                min = i
            }
            
            i = ((max - min) / 2) + min
            
            if max - min <= 1 {
                let maxD = originalSize == 1 ? 0 : max
                
                let minW = scheduledWorkouts[min]
                let minVal = DateTime.getDateTimeVal(comp: minW.dateComp)
                
                let maxW = scheduledWorkouts[maxD]
                let maxVal = DateTime.getDateTimeVal(comp: maxW.dateComp)
                
                if workoutToVal <= minVal {
                    max = min
                    i = min
                } else if originalSize == 1 {
                    min = 1
                    i = 1
                } else {
                    min = max
                    i = max
                }
                
                if i == originalSize - 1 && workoutToVal > maxVal {
                    i = originalSize + 1
                }
            }
        }

        if i < scheduledWorkouts.count {
            scheduledWorkouts.insert(workout, at: i)
        } else {
            scheduledWorkouts.append(workout)
        }
        
    }
    
    
    func removeFromScheduledWorkouts(workout: Workout) {
        for i in 0..<self.scheduledWorkouts.count {
            if workout == self.scheduledWorkouts[i] {
                self.scheduledWorkouts.remove(at: i)
            }
        }
        
    }
    
    func addToCompletedWorkout(workout: Workout) {
        self.completedWorkouts.append(workout)
    }
    
    
    func getExerciseArrString() -> [String] {
        var stringArray: [String] = []
        for group in self.allExercises {
            for exercise in group {
                stringArray.append(exercise.name)
            }
        }
        return stringArray
    }
    
    
    func genStringExerciseDict() -> Dictionary<String, GenExercise> {
        var stringExerciseDict: Dictionary<String, GenExercise> = [:]
        
        for exerciseGroup in self.allExercises {
            for exercise in exerciseGroup {
                stringExerciseDict[exercise.name] = exercise
            }
        }
        
        return stringExerciseDict
    }
    
    
    func getExerciseFromName() -> GenExercise {
        for group in self.allExercises {
            for exercise in group {
                if exercise.name == name {
                    return exercise
                }
            }
        }
        return GenExercise(name: "", description: "", bodyParts: [])
    }
    
    
    func getRoutineArrString() -> [String] {
        var stringArray: [String] = []
        for routine in self.allRoutines {
            stringArray.append(routine.name)
        }
        return stringArray
    }
    
    func checkCompletedWorkoutsForPRs() {
        self.personalRecords = [:]
        for workout in self.completedWorkouts {
            self.addToPersonalRecords(workout: workout)
        }
    }
    
    
    func addToPersonalRecords(workout: Workout) {
        let specExercises = workout.getSpecExercises1D()
        for exercise in specExercises {
            let name = exercise.name
            let weight = exercise.weight
            let category = exercise.genExercise.categoryString
            if self.personalRecords.keys.contains(category) {
                if self.personalRecords[category]!.keys.contains(name) {
                    if weight! > self.personalRecords[category]![name]! {
                        self.personalRecords[category]![name] = weight!
                    }
                } else {
                    self.personalRecords[category]![name] = weight!
                }
            } else {
                self.personalRecords[category] = [name: weight!]
            }
        }
    }
    
    
    func getRoutineFromName(name: String) -> Routine {
        for routine in self.allRoutines {
            if routine.name == name {
                return routine
            }
        }
        return Routine(name: "", description: "", exercises: [], restArr: [])
    }

    



    func getScheduledWorkouts2D() -> [[Workout]] {
        if scheduledWorkouts.count == 0 {
            return []
        }
        
        var final2D: [[Workout]] = []
        var currentArr: [Workout] = [self.scheduledWorkouts[0]]
        
        for i in 1..<scheduledWorkouts.count {
            let months = scheduledWorkouts[i].month == scheduledWorkouts[i - 1].month
            let years = scheduledWorkouts[i].year == scheduledWorkouts[i - 1].year
            
            if months && years {
                currentArr.append(self.scheduledWorkouts[i])
            } else {
                final2D.append(currentArr)
                currentArr = [self.scheduledWorkouts[i]]
            }
        }
        
        if currentArr.count > 0 {
            final2D.append(currentArr)
        }
        
        return final2D
    }

    
}
