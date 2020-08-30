//
//  UserInitialProperties.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/29/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation



class UserInitProps {
    public static var defaultExer: [[GenExercise]] = [
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
            GenExercise(name: "Back Squats",
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
    
    public static let sampleRoutineEx = [
                                        [
                                            UserInitProps.defaultExer[0][0],
                                            UserInitProps.defaultExer[0][0]
                                        ],
                                        [
                                            UserInitProps.defaultExer[0][1],
                                            UserInitProps.defaultExer[0][1],
                                            UserInitProps.defaultExer[0][1],
                                            UserInitProps.defaultExer[0][1],
                                            UserInitProps.defaultExer[0][1]
                                        ],
                                        [
                                            UserInitProps.defaultExer[1][0],
                                            UserInitProps.defaultExer[1][0],
                                            UserInitProps.defaultExer[1][0],
                                            UserInitProps.defaultExer[1][0],
                                            UserInitProps.defaultExer[1][0]
                                        ]
                                        
                                    ]
    
    public static let sampleRoutineEx1 = [
                                        [
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0]
                                        ]
                                        
                                    ]
    
    public static let sampleRoutineEx2 = [
                                        [
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0]
                                        ],
                                        [
                                            UserInitProps.defaultExer[2][1],
                                            UserInitProps.defaultExer[2][1],
                                            UserInitProps.defaultExer[2][1]
                                        ],
                                        [
                                            UserInitProps.defaultExer[2][0],
                                            UserInitProps.defaultExer[2][0],
                                            UserInitProps.defaultExer[2][0]
                                        ],
                                        [
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0],
                                            UserInitProps.defaultExer[3][0]
                                        ]
                                        
                                    ]
    
    public static let sampleRoutineEx3 = [
                                        [
                                            UserInitProps.defaultExer[4][0],
                                            UserInitProps.defaultExer[4][0],
                                            UserInitProps.defaultExer[4][0]
                                        ],
                                        [
                                            UserInitProps.defaultExer[4][1],
                                            UserInitProps.defaultExer[4][1],
                                            UserInitProps.defaultExer[4][1]
                                        ]
                                        
                                    ]
    
    public static let sampleRoutineRest = [[1, 0], [0, 30], [0, 45]]
    public static let sampleRoutine1Rest = [[0, 30]]
    public static let sampleRoutine2Rest = [[0, 45], [1, 0], [0, 30], [0, 45]]
    public static let sampleRoutine3Rest = [[1, 0], [1, 15]]
    
    
    public static var sampleRoutine = Routine(name: "Sample Routine", description: "This is a really short random description that is supposed to fill in a certain sample space for the purpose of testing this app.", exercises: UserInitProps.sampleRoutineEx, restArr: UserInitProps.sampleRoutineRest)
    public static var sampleRoutine1 = Routine(name: "Quick Abs", description: "Great workout to really get those abs pumping.", exercises: UserInitProps.sampleRoutineEx1, restArr: UserInitProps.sampleRoutine1Rest)
    public static var sampleRoutine2 = Routine(name: "Pull Day", description: "Work your back and biceps in this pull workout which will give you great posture aside from great arms and back.", exercises: UserInitProps.sampleRoutineEx2, restArr: UserInitProps.sampleRoutine2Rest)
    public static var sampleRoutine3 = Routine(name: "Leg Workout", description: "Leg day is easily the most important day of the week, make sure not to skip it.", exercises: UserInitProps.sampleRoutineEx3, restArr: UserInitProps.sampleRoutine3Rest)
    
    
    public static var sampleWorkout = Workout(routine: UserInitProps.sampleRoutine, dateComp: DateComponents(year: 2020, month: 5, day: 7, hour: 10, minute: 5, weekday: 3))
    public static var sampleWorkout1 = Workout(routine: UserInitProps.sampleRoutine2, dateComp: DateComponents(year: 2020, month: 6, day: 15, hour: 20, minute: 5, weekday: 5))
    public static var sampleWorkout2 = Workout(routine: UserInitProps.sampleRoutine3, dateComp: DateComponents(year: 2020, month: 8, day: 1, hour: 10, minute: 5, weekday: 1))
    
    
    
    public static var routines: [Routine] = [
                                            UserInitProps.sampleRoutine,
                                            UserInitProps.sampleRoutine1,
                                            UserInitProps.sampleRoutine2,
                                            UserInitProps.sampleRoutine3
                                        ]
    
}
