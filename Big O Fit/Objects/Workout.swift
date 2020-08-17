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
class Workout: Hashable {
    
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
    
    var dateComp: DateComponents    /// The DateComponents object that contains all needed info about the date of the workout
    var workoutName: String         /// The name off the workout
    
    var month: Int                  /// An integer value 1-12 which represents the month of the workout, starting with January.
    var day: Int                    /// An integer value 1-31 which represents the day of the workout.
    var weekday: Int                /// An integer value 1-7 which represents the weekday of the workout, starting with Sunday.
    var year: Int                   /// An integer value which represents the year the workout takes place.
    var hour: Int?                  /// The hour of the day in which the workout is set to take place  (OPTIONAL)
    var minute: Int?                /// The minute of the hour in which the workout is set to take place  (OPTIONAL)
    
    var groupName: String           /// Name of the group hosting the workout
    var imageName: String           /// Name of the image used to display for the workout -- usually the user's profile picture or group picture.
    
    
    
    /** Only constructor for a Workout object
        - Parameter dateComp: must contain [.month, .day, .weekday, .year] or else an error will occur due to force unwrap
        - Parameter workoutName: if no value is provided, self.workoutName will default to "Workout" (OPTIONAL)
        - Parameter groupName: if no value is provided, self.groupName will default to "Individual" (OPTIONAL)
        - Parameter imageName: if no value is provided, self.imageName will defaults to "beaver" (OPTIONAL)
     */
    init(dateComp: DateComponents, workoutName: String? = nil, groupName: String? = nil, imageName: String? = nil) {
        self.dateComp = dateComp
        
        self.month = dateComp.month!
        self.day = dateComp.day!
        self.weekday = dateComp.weekday!
        self.year = dateComp.year!
        
        self.hour = dateComp.hour
        self.minute = dateComp.minute
        
        self.workoutName = workoutName ?? "Workout"
        self.groupName = groupName ?? "Individual"
        self.imageName = imageName ?? "beaver"
    }
}
