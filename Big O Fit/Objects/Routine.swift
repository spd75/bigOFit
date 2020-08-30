//
//  Routine.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation




class Routine: ObservableObject, Hashable {
    
    static func == (lhs: Routine, rhs: Routine) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description && lhs.exercises == rhs.exercises
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.description)
    }
    
    var name: String
    var description: String
    var exercises: [[GenExercise]]
    var restArr: [[Int]]
    
    
    init(name: String, description: String, exercises: [[GenExercise]], restArr: [[Int]]) {
        self.name = name
        self.description = description
        self.exercises = exercises
        self.restArr = restArr
    }
    
    
}
