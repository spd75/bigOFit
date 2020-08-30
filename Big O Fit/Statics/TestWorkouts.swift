//
//  TestWorkouts.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


/// A class that contains static variables used to test the app
class TestWorkouts {
    static var cal = Calendar.current
    
    
    static let workoutList: [[Workout]] = [
        [
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 7, day: 20, weekday: 1)),
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 7, day: 25, weekday: 3)),
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 7, day: 29, weekday: 5)),
        ],
        [
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 8, day: 5, weekday: 5)),
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 8, day: 10, weekday: 2)),
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 8, day: 29, weekday: 5)),
        ],
        [
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 9, day: 19, weekday: 6)),
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 9, day: 20, weekday: 3)),
        ],
        [
        Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(calendar: cal, timeZone: nil, era: nil, year: 2020, month: 10, day: 30, weekday: 3))
        ]
    ]
        

}
