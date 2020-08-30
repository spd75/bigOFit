//
//  User.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/27/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class BigOFitUser: ObservableObject {
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
    @Published var exerciseLog: Dictionary<GenExercise, Workout>

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
        self.exerciseLog = [:]
        self.completedExercises = [:]
    }
    
    
//    func addToScheduledWorkouts(workout: Workout) {
//        let current = CurrentDateTime.getUpdatedTime()
//        let monthDiff = workout.month! - current.year!
//        let yearDiff = workout.year! - current.year!
//        
//        if monthDiff == 0 && yearDiff == 0 {
//            self.addToScheduledWorkoutsArr(workout: workout)
//        } else {
//            let adjustedYearDiff = yearDiff == 0 ? 0 : (yearDiff - 1)
//            self.addToScheduledWorkoutsArr(workout: workout)
//        }
//    }
    
//    func addToScheduledWorkoutsArr(workout: Workout, key: Int) {
//        if self.scheduledWorkouts.keys.contains(key) {
//            var workoutArr = self.scheduledWorkouts[key]!
//            for i in 0..<self.scheduledWorkouts[key]!.count {
//                if workout.day! < self.scheduledWorkouts[key]![i].day! {
//                    self.scheduledWorkouts[key]!.insert(workout, at: i)
//                } else if workout.day! == self.scheduledWorkouts[key]![i].day! {
//                    if workout.hour! < self.scheduledWorkouts[key]![i].hour! {
//                        self.scheduledWorkouts[key]!.insert(workout, at: i)
//                    } else if workout.hour! == self.scheduledWorkouts[key]![i].hour! {
//                        if workout.minute! <= self.scheduledWorkouts[key]![i].minute! {
//                            self.scheduledWorkouts[key]!.insert(workout, at: i)
//                        }
//                    }
//                }
//             }
//        } else {
//            self.scheduledWorkouts[key] = [workout]
//        }
//    }
    
    
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
    
    
    func addWorkout(at i: Int, workoutInArr: Workout, workoutToInsert: Workout) -> Bool {

        
        return false
    }


    func addToScheduledWorkoutsArr(workout: Workout) {
        for i in 0..<self.scheduledWorkouts.count {
            let workoutInArrDate = self.scheduledWorkouts[i].getOverallDate(year: self.scheduledWorkouts[i].year!, month: self.scheduledWorkouts[i].month!, day: self.scheduledWorkouts[i].day!)
            let workoutInArrTime = self.scheduledWorkouts[i].getOverallTime(hour: self.scheduledWorkouts[i].hour!, minute: self.scheduledWorkouts[i].minute!)
            let workoutToInsertDate = workout.getOverallDate(year: workout.year!, month: workout.month!, day: workout.day!)
            let workoutToInsertTime = workout.getOverallTime(hour: workout.hour!, minute: workout.minute!)
            
            
            if workoutToInsertDate < workoutInArrDate {
                self.scheduledWorkouts.insert(workout, at: i)
            } else if workoutToInsertDate == workoutInArrDate {
                if workoutToInsertTime < workoutInArrTime {
                    self.scheduledWorkouts.insert(workout, at: i)
                }
            }
        }
        
        scheduledWorkouts.append(workout)
    }
    
    
    func getScheduledWorkouts2D() -> [[Workout]] {
        var array2D: [[Workout]] = []
        if self.scheduledWorkouts.count <= 0 {
            return array2D
        }
        
        let cd = CurrentDateTime.getUpdatedTime()
        let currentDate = CurrentDateTime.getOverallDateWithyear(year: cd.year!, month: cd.month!, day: cd.day!)
        var currentArray: [Workout] = []
        var i = 0
        var start: Workout
        var scheduledDate: Int
        
        
        
        
        repeat {
            start = self.scheduledWorkouts[i]
            scheduledDate = start.getOverallDateWithyear(year: start.year!, month: start.month!, day: start.day!)
            currentArray.append(self.scheduledWorkouts[i])
            
            i += 1
        } while (scheduledDate - currentDate < 7 && cd.weekday! < start.weekday! && i < self.scheduledWorkouts.count)
        
//        while scheduledDate - currentDate < 7 && cd.weekday! < start.weekday! && i < self.scheduledWorkouts.count {
//
//            i += 1
//            start = self.scheduledWorkouts[i]
//            scheduledDate = start.getOverallDateWithyear(year: start.year!, month: start.month!, day: start.day!)
//        }
        
        array2D.append(currentArray)
        if i < self.scheduledWorkouts.count - 1 {
            i += 1
            currentArray = [self.scheduledWorkouts[i]]
        }
        
        while i < self.scheduledWorkouts.count {
            let current = self.scheduledWorkouts[i]
            let past = self.scheduledWorkouts[i - 1]
            if current.year == past.year && current.month == past.month {
                currentArray.append(current)
            } else {
                array2D.append(currentArray)
                currentArray = [current]
            }
        }
        
        return array2D
    }

    
}
