//
//  Workout.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation

/** A Workout object provides all the information for an individual workout session. This is crucial for screens like the main Workout screen where
   a list of all workouts are displayed.
 
    Each Workout uses a Routine to outline its structure. Routines are a general outline for Workouts. Workouts, however, are specific instances of when a Routine is specifically performed.
 
    Fields:
        - workoutName: the name of the workout
 
        - dateComp: DateComponents which contain the information for the date and time that the workout is scheduled to occur
        - month: An integer value 1-12 which represents the month of the workout, starting with January
        - day: An integer value 1-31 which represents the day of the workout
        - year: An integer value which represents the year the workout takes place
        - weekday: an integer value 1-7 which represents the weekday of the workout, starting with Sunday
        - hour: the hour of the day in which the workout is set to take place
        - minute: The minute of the hour in which the workout is set to take place
 
        - groupName: the name of the group with which the workout will happen -> "Individual" if there isn't a group
        - imageName: the name of the image file associated with the workout
        
        - @Publihed started: boolean which is true when workout has started, false otherwise
        - @Published completed: boolean which is true when workout has been completed, false otherwise
        
        - routine: the routine that provides the outline for all exercises and rest periods
        - specExercises: the specific exercises which will store the data
        - exercisesPerformed: an array of all the genExercises contained within the routine
 
        - currentExerciseInd: holds the index for which exercise is currenlty being performed -- must have a count of 2 to be valid
        - currentExercise: the specExercise that is currently being performed
        - finalExerciseInd: the index for the final exercise in the routine
        - finalExercise: the final specExercise in the routine

 */
class Workout: Hashable, ObservableObject {
    
    /// Function to conform to Hashable
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.month == rhs.month && lhs.weekday == rhs.weekday && lhs.day == rhs.day && lhs.workoutName == rhs.workoutName 
    }
    
    /// Function to conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.workoutName)
        hasher.combine(self.groupName)
        hasher.combine(self.month)
        hasher.combine(self.day)
    }
    
    public static var workoutSelected: Workout? = nil
    
    
    /// Check lines 16-40 for field documentation
    var workoutName: String
    
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
    
    var month: Int?
    var day: Int?
    var weekday: Int?
    var year: Int?
    var hour: Int?
    var minute: Int?
    
    var groupName: String
    var imageName: String
    
    
    @Published var started: Bool = false
    @Published var completed: Bool = false
    
    var routine: Routine
    var specExercises: [[SpecExercise]]!
    var exercisesPerformed: [GenExercise] = []
    
    var currentExerciseInd: [Int]?
    var currentExercise: SpecExercise?
    var finalExerciseInd: [Int]?
    var finalExercise: SpecExercise?
    
    
    /** Only constructor for a Workout object
        - Parameter routine: assinged to routine
        - Parameter dateComp: must contain [.month, .day, .weekday, .year, .hour, .minute] or else an error will occur due to force unwrap
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
    
    
    
    /** Loops through the exercise outline and rest array in the routine to create the 2D array of specExercises
            - Parameter genExercies: the 2D array of exercises to loop through
            - Parameter restArr: the 2D array of rest to loop through
            - Returns: a 2D array of specExercises to track statistics on each set performed */
    
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
    

    /** Changes the current specExercise to the next Exercise */
    
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
    
    
    /** Changes the current exercise to the 2D array index provided
            - Parameter currentExerciseInd: must be an array with a count of 2 that provides the index to switch the currentExercise */
    
    func changeCurrentExercise(currentExerciseInd: [Int]) {
        if currentExerciseInd[0] < self.specExercises.count && currentExerciseInd[1] < self.specExercises[currentExerciseInd[0]].count {
            self.currentExerciseInd = currentExerciseInd
            self.currentExercise = self.specExercises[currentExerciseInd[0]][currentExerciseInd[1]]
        }
    }
    
    
    /** Updates the current weight and reps of the currentExercise
            - Parameter weight: the weight performed and assigned to the currentExercise
            - Parameter reps: the reps performed and assigned to the currentExercise */
    
    func setCurrentExerciseStats(weight: Int, reps: Int) {
        if let currentExercise = self.currentExercise {
            currentExercise.setResults(weight: weight, reps: reps)
        }
    }
    
    
    /** Sets the statistics for the exercise at the index provided
            - Parameter exerciseInd: the index of the exercise to change -- array must be a 2 element 1D array to locate the exercise
            - Parameter weight: the weight performed
            - Parameter reps: the number of repititions
     */
    
    func setSpecificExerciseStat(exerciseInd: [Int], weight: Int, reps: Int) {
        self.specExercises[exerciseInd[0]][exerciseInd[1]].setResults(weight: weight, reps: reps)
    }
    
    
    /** Gets the current rest from the current specExercise
            Returns: the current rest time, which is represented by a 2 element 1D array where [0] is minutes and [1] is seconds */
    
    func getCurrentRest() -> [Int] {
        return currentExercise?.rest ?? [0, 0]
    }
    

    /** Gets the total number of exercises in the workout. Cannot simply perform specExercises.count to get this because specExercises is a 2D array.
            - Returns: the total number of exercises in the workout */
    
    func getNumExercises() -> Int {
        var sum = 0
        for i in 0..<self.specExercises.count {
            for j in 0..<self.specExercises[i].count {
                sum += 1
            }
        }
        return sum
    }
    
    
    /** Takes the month and day for which the workout is scheduled and converts it to a number 1-365 (or 366 for leap years) based off when the date occurs in chronological order in the year. This is used to find which date occur first when comparing to another workout.
            - Returns: the integer representation of when the date occurs in the year */
    
    func getOverallDate() -> Int {
        var overallDate = 0
        let year = self.year ?? 0
        let month = self.month ?? 0
        let day = self.day ?? 0
        
        if (month - 1) % 2 == 0 {
            let mult = (month - 1) / 2
            overallDate = (30 * mult) + (31 * mult)
        } else if self.month == 2 {
            overallDate = 31
        } else {
            let mult31 = month / 2
            let mult30 = mult31 - 1
            overallDate = (30 * mult31) + (31 * mult30)
        }
        overallDate += day
        overallDate = year % 4 == 0 ? overallDate - 1 : overallDate - 2
        overallDate = month >= 9  ? overallDate + 1 : overallDate
        
        return overallDate
    }
    
    
    /** Takes the year, month, and day and converts it to a number that represents how many days it has been since 0 A.D. This is used to find which date occurs first when comparing to another workout. Leap years are accounted for.
            - Returns: the integer representation of how many days have occured since 0 A.D. */
        
    func getOverallDateWithYear() -> Int {
        return self.getOverallDate() + (self.year! * 365 + Int(self.year! / 4))
    }
    
    
    /** Takes the hour and minute and converts it to a number 1-1440 to find when the time scheduled occurs in chronological order. This is used to find which time occurs first when comparing to another workout.
            - Returns: the integer representation of the time */

    func getOverallTime() -> Int {
        return (self.hour ?? 0 * 60) + (self.minute ?? 0)
    }
    
    
    /** Combines getOverallDateWithYear() and getOverallTime() to get a number XXXXXX.YYYY where the X represent the day number, and the Y represents the time. This is used to find the overall order of when workouts occur.
            - Returns: number representation XXXXXX.YYYY for the date and time of the workout */
    
    func getDateTimeVal() -> Double {
        let date = self.getOverallDateWithYear()
        let time = self.getOverallTime()
        
        return Double(date) + (0.0001 * Double(time))
    }
    
    
    /** Generates a completion text for exercises that have already been completed. If completed within the last week, the completed text could be anything like:
            - "Completed Now"
            - "Completed 10 mins ago"
            - "Completed 5 hours ago"
            - "Completed Yesterday"
            - "Completed Saturday"
        Otherwise, the completion text will simply display the date which the workout was completed.
            - Returns: the completion text */
    
    func genCompleteTextFromDateComp() -> String {
            let currentComponents = DateTime.getUpdatedTime()
            
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
            let workoutOverall = self.getOverallDate()
            let currentOverall = self.getOverallDate()
        
            if year && (currentOverall - workoutOverall == 1) {
                return "Completed Yesterday"
            } else if year && currentOverall - workoutOverall < 7 {
                return "Completed \(Constants.weekdays[self.weekday! - 1])"
            }
            
            return "Comleted \(Constants.months[self.month! - 1]) \(String(self.day!)), \(self.year!)"
    }
    
    /** Generates the common date text for the workout in the format MMMM.. DD, YYYY. An example would be March 15th, 2020.
            - Returns: the common date text */
    
    func genDateTextFromDateComp() -> String {
        if self.year ?? 0 == 0 || self.month ?? 0 == 0 || self.day ?? 0 == 0 {
            return ""
        }
        return "\(Constants.months[self.month! - 1]) \(String(self.day!)), \(self.year!)"
    }
        
    
    /** Gets the array of specExercises, but as a 1D array in order
            Returns: the 1D specExercises array */
    
    func getSpecExercises1D() -> [SpecExercise] {
        var specExercises1D: [SpecExercise] = []
        for exercise in self.specExercises {
            for set in exercise {
                specExercises1D.append(set)
            }
        }
        return specExercises1D
    }
    
    
    /** Gets whether or not the workout is taking place within the next 7 days
            - Returns: true if the workout is happening within the next 7 days, false otherwise */
    
    func isThisWeek() -> Bool {
        let cur = DateTime.getUpdatedTime()
        let currentVal = DateTime.getDateTimeVal(comp: cur)
        let dateVal = self.getDateTimeVal()
        
        if dateVal - currentVal < 7 {
            return true
        }
        
        return false
    }
    
    
    

}

