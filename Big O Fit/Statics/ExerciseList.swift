//
//  Exercise.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation

class ExerciseList {
    public static let allExerciseGroups = ["Chest", "Arms", "Back", "Core", "Legs", "Other"]
    
    public static var allExercisesArray: [[GenExercise]] = [
        [
            GenExercise(name: "Bench Press",
                     description: "A bench press consists of laying on a bench and lowering the bar until it hits your chest and then exploding upwards",
                     bodyParts: [.chest, .shoulders, .triceps]
            ),
            GenExercise(name: "Dips",
                     description: "You need two parrallel bars to do a dip. Jump on the bar and extend outwards, then slowly lower until your elbows are above your shoulders, and explode up.",
                     bodyParts: [.chest, .shoulders, .triceps]
            )
        ],
        [
            GenExercise(name: "Bicep Curls",
                        description: "Press your elbow against your inner thigh.  Start your arm in a completely unflexed position and pull a dumbell all the way up.",
                        bodyParts: [.biceps]
            )
        ],
        [
            GenExercise(name: "Lat Pull Downs",
                        description: "Usually performed with a pulley machine, pull a wide grip bar down below your chin and slowly work your way back up.",
                        bodyParts: [.lats, .shoulders, .forearms]),
            GenExercise(name: "Pull Ups",
                        description: "Hang from a horizontal bar and pull yourself up until your chin is above the bar.",
                        bodyParts: [.lats, .shoulders, .forearms])
        ],
        [
            GenExercise(name: "Sit Up",
                        description: "Rest on the floor with your knees up in the air. Clench your abs and raise your body until you meet your legs. Descend slowly.",
                        bodyParts: [.upperabs, .lowerabs]
                )
        ],
        [
            GenExercise(name: "Back Squat",
                        description: "Rest a barbell on your shoulders and grab it with your arms. Slowly descend until your legs are parralell with the floor and then explode upwards.",
                        bodyParts: [.quads, .glutes, .hamstrings, .upperabs, .lowerabs]
            ),
            GenExercise(name: "Calf Raises",
                        description: "Hold dumbells in your hand as you stand on your tippy toes and slowly descend to a normal stance.",
                        bodyParts: [.calves]
            )
        ],
        [
        ]
        
        
    ]
    
    
    public static var chestExercises: [GenExercise] = [
        GenExercise(name: "Bench Press",
                 description: "A bench press consists of laying on a bench and lowering the bar until it hits your chest and then exploding upwards",
                 bodyParts: [.chest, .shoulders, .triceps]),
        GenExercise(name: "Dips",
                 description: "You need two parrallel bars to do a dip. Jump on the bar and extend outwards, then slowly lower until your elbows are above your shoulders, and explode up.",
                 bodyParts: [.chest, .shoulders, .triceps])
    ]
    
    public static var backExercises: [GenExercise] = [
        GenExercise(name: "Lat Pull Downs", description: "You gotta roll", bodyParts: [.lats, .shoulders, .forearms]),
        GenExercise(name: "Dips", description: "You do a dip", bodyParts: [.chest, .shoulders, .triceps])
    ]
    
    
    public static var legExercises: [GenExercise] = [
        GenExercise(name: "Bench Press", description: "You gotta roll", bodyParts: [.chest, .shoulders, .triceps]),
        GenExercise(name: "Dips", description: "You do a dip", bodyParts: [.chest, .shoulders, .triceps])
    ]
    

}
