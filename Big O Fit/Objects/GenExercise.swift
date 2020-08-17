//
//  GenExercise.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class GenExercise: Hashable {
    static func == (lhs: GenExercise, rhs: GenExercise) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.description)
    }
    
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
    
    var name: String                    /// The name of the exercise
    var description: String             /// The description of the exercise
    var bodyParts: [BodyPart]           /// An array of BodyPart enums that tracks which bodyparts the exercise uses
    
    
    /// Only constructor for body part
    init(name: String, description: String, bodyParts: [BodyPart]) {
        self.name = name
        self.description = description
        self.bodyParts = bodyParts
    }
    
     
    /// Uses self.bodyParts to generate an array of strings of the exercises
    func bodyPartsToString() -> [String] {
        var bodyPartsString: [String] = []
        
        for i in 0..<self.bodyParts.count {
            let nameComma = i == (self.bodyParts.count - 1) ? "\(GenExercise.bodyPartsToName[self.bodyParts[i]]!)"
                                    : "\(GenExercise.bodyPartsToName[self.bodyParts[i]]!), "
            bodyPartsString.append(nameComma)
        }
        
        return bodyPartsString
    }
    
}

