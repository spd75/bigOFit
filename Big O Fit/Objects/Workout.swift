//
//  Workout.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation

/** A Workout object provides all the information for an individual workout session.  This is crucial for screens like the main Workout screen where
    a list of all workouts are displayed.
 */
class Workout: Hashable, ObservableObject {
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.month == rhs.month && lhs.weekday == rhs.weekday && lhs.day == rhs.day && lhs.workoutName == rhs.workoutName 
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.workoutName)
        hasher.combine(self.groupName)
        hasher.combine(self.month)
        hasher.combine(self.day)
    }
    
    public static var workoutSelected: Workout? = nil   /// Static variable used in certain view to determine if a workout has been clicked on to view
    
    var workoutName: String         /// The name off the workout
    
    var dateComp: DateComponents {
        didSet {
            self.year = self.dateComp.year
            self.month = self.dateComp.month
            self.day = self.dateComp.day
            self.weekday = self.dateComp.weekday
            self.hour = self.dateComp.hour
            self.minute = self.dateComp.minute
        }
    }
    
    var month: Int?                  /// An integer value 1-12 which represents the month of the workout, starting with January.
    var day: Int?                    /// An integer value 1-31 which represents the day of the workout.
    var weekday: Int?                /// An integer value 1-7 which represents the weekday of the workout, starting with Sunday.
    var year: Int?                   /// An integer value which represents the year the workout takes place.
    var hour: Int?                  /// The hour of the day in which the workout is set to take place  (OPTIONAL)
    var minute: Int?                /// The minute of the hour in which the workout is set to take place  (OPTIONAL)
    
    var groupName: String           /// Name of the group hosting the workout
    var imageName: String           /// Name of the image used to display for the workout -- usually the user's profile picture or group picture.
    
    
    @Published var started: Bool = false
    @Published var completed: Bool = false
    
    var routine: Routine
    var specExercises: [[SpecExercise]]!
    var exercisesPerformed: [GenExercise] = []
    
    var currentExerciseInd: [Int]?
    var currentExercise: SpecExercise?
    var changedSpecExercise: Int = 0
    var finalExercise: SpecExercise?
    var finalExerciseInd: [Int]?
    
    /** Only constructor for a Workout object
        - Parameter dateComp: must contain [.month, .day, .weekday, .year] or else an error will occur due to force unwrap
        - Parameter workoutName: if no value is provided, self.workoutName will default to "Workout" (OPTIONAL)
        - Parameter groupName: if no value is provided, self.groupName will default to "Individual" (OPTIONAL)
        - Parameter imageName: if no value is provided, self.imageName will defaults to "beaver" (OPTIONAL)
     */
    init(routine: Routine, dateComp: DateComponents, groupName: String? = nil, imageName: String? = nil) {
        self.routine = routine
        self.dateComp = dateComp
        
        self.month = dateComp.month
        self.day = dateComp.day
        self.weekday = dateComp.weekday
        self.year = dateComp.year
        
        self.hour = dateComp.hour
        self.minute = dateComp.minute
        
        self.workoutName = routine.name
        self.groupName = groupName ?? "Individual"
        self.imageName = imageName ?? "beaver"
        
        self.specExercises = Workout.getSpecExercises(genExercises: routine.exercises, restArr: routine.restArr)
        
        if self.getNumExercises() > 0 {
            let lastSetInd = self.specExercises.count - 1
            let lastRepInd = self.specExercises[lastSetInd].count - 1
            self.currentExerciseInd = [0, 0]
            self.currentExercise = self.specExercises[0][0]
            self.finalExercise = self.specExercises[lastSetInd][lastRepInd]
            self.finalExerciseInd = [lastSetInd, lastRepInd]
            if let finalExercise = self.finalExercise {
                finalExercise.rest = [0, 10]
            }
        }
        
        for exercise in routine.exercises {
            self.exercisesPerformed.append(exercise[0])
        }
        
        
    }
    
    static func getSpecExercises(genExercises: [[GenExercise]], restArr: [[Int]]) -> [[SpecExercise]] {
        var specExercises: [[SpecExercise]] = []
        
        for i in 0..<genExercises.count {
            var specSet: [SpecExercise] = []
            for j in 0..<genExercises[i].count {
                specSet.append(SpecExercise(exercise: genExercises[i][j], rest: restArr[i]))
            }
            specExercises.append(specSet)
        }
        
        return specExercises
    }
    

    func setNextExerciseCurrent() {
        if let currentExerciseInd = self.currentExerciseInd {
            let set = currentExerciseInd[0]
            let rep = currentExerciseInd[1]
            let lastRep = self.specExercises[set].count - 1
            let lastSet = self.specExercises.count - 1
            
            if rep + 1 > lastRep {
                if set + 1 > lastSet {
                    self.completed = true
                } else {
                    self.currentExerciseInd = [set + 1, 0]
                    self.currentExercise = self.specExercises[set + 1][0]
                }
            } else {
                self.currentExerciseInd = [set, rep + 1]
                self.currentExercise = self.specExercises[set][rep + 1]
            }
        }

        
    }
    
    
    func setCurrentExerciseStats(weight: Int, reps: Int) {
        if let currentExercise = self.currentExercise {
            currentExercise.setResults(weight: weight, reps: reps)
        }
        
    }
    
    
    func setSpecificExerciseStat(exerciseInd: [Int], weight: Int, reps: Int) {
        self.specExercises[exerciseInd[0]][exerciseInd[1]].setResults(weight: weight, reps: reps)
    }
    
    
    func changeCurrentExercise(currentExerciseInd: [Int]) {
        if currentExerciseInd[0] < self.specExercises.count && currentExerciseInd[1] < self.specExercises[currentExerciseInd[0]].count {
            self.currentExerciseInd = currentExerciseInd
            self.currentExercise = self.specExercises[currentExerciseInd[0]][currentExerciseInd[1]]
        }
        
    }
    
    
    func getCurrentRest() -> [Int] {
        return currentExercise?.rest ?? [0, 0]
    }
    
    func getNumExercises() -> Int {
        var sum = 0
        for i in 0..<self.specExercises.count {
            for j in 0..<self.specExercises[i].count {
                sum += 1
            }
        }
        
        return sum
    }
    
    
    func genCompleteTextFromDateComp() -> String {
            let currentComponents = CurrentDateTime.getUpdatedTime()
            
            let year = currentComponents.year == self.year
            let month = currentComponents.month == self.month
            let day = currentComponents.day == self.day
            let hour = currentComponents.hour == self.hour
            let minute = currentComponents.minute == self.minute
            
            let currentTotalTime = currentComponents.hour! * 60 + currentComponents.minute!
            let workoutTotalTime = self.hour! * 60 + self.minute!
            let difference: Int = currentTotalTime - workoutTotalTime
            
            
            if self.minute != nil && self.hour != nil {
                if year && month && day && hour && minute {
                    return "Completed Now"
                } else if year && month && day && difference < 60 {
                    let plural = difference == 1 ? "" : "s"
                    return "Completed \(difference) min\(plural) ago"
                } else if year && month && day {
                    let hourDifference = difference/60
                    let plural = hourDifference == 1 ? "" : "s"
                    return "Completed \(Int(hourDifference)) hour\(plural) ago"
                }
                
            }
            
        let workoutOverall = self.getOverallDate(year: self.year!, month: self.month!, day: self.day!)
            let currentOverall = self.getOverallDate(year: currentComponents.year!, month: currentComponents.month!, day: currentComponents.day!)
        
            if year && (currentOverall - workoutOverall == 1) {
                return "Completed Yesterday"
            } else if year && currentOverall - workoutOverall < 7 {
                return "Completed \(Constants.weekdays[self.weekday! - 1])"
            }
            
            return "Comleted \(Constants.months[self.month! - 1]) \(String(self.day!)), \(self.year!)"
            
    }
    
    func genDateTextFromDateComp() -> String {
        return "\(Constants.months[self.month! - 1]) \(String(self.day!)), \(self.year!)"
    }
        
    func getOverallDate(year: Int, month: Int, day: Int) -> Int {
        var overallDate = 0
        var dateLimits = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        if year % 4 == 0 {
            dateLimits[1] = 29
        }
        
        for i in 0..<(month - 1) {
            overallDate += dateLimits[i]
        }
        
        return overallDate + day
    }
    
    func getOverallDateWithyear(year: Int, month: Int, day: Int) -> Int {
        var overallDate = 0
        var dateLimits = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        if year % 4 == 0 {
            dateLimits[1] = 29
        }
        
        for i in 0..<(month - 1) {
            overallDate += dateLimits[i]
        }
        
        return (overallDate + day) + (year * 365) + Int(year / 4)
    }
    

    func getOverallTime(hour: Int, minute: Int) -> Int {
        return (hour * 60) + (minute)
    }
    
    func getSpecExercises1D() -> [SpecExercise] {
        var specExercises1D: [SpecExercise] = []
        for exercise in self.specExercises {
            for set in exercise {
                specExercises1D.append(set)
            }
        }
        return specExercises1D
    }
    
    
    
    
    




    

        
    

}

