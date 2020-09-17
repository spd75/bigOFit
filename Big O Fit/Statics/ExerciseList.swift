//
//  Exercise.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation

class ExerciseList {
    
    public static func getCompletedWorkout(workout: Workout) -> Workout {
        for exercise in workout.specExercises {
            for set in exercise {
                let reps = Int.random(in: 0..<15)
                let weight = Int.random(in: 0..<250)
                set.setResults(weight: weight, reps: reps)
            }
        }
        workout.started = true
        workout.completed = true
        
        return workout
    }
    
    
    public static func getTestUser() -> BigOFitUser {
        let user = BigOFitUser(name: "Sergio Diaz", bio: "This is my bio", profilePicName: "beaver")
        user.completedWorkouts = [ExerciseList.getCompletedWorkout(workout: ExerciseList.sampleWorkout), ExerciseList.getCompletedWorkout(workout: ExerciseList.sampleWorkout1), ExerciseList.getCompletedWorkout(workout: ExerciseList.sampleWorkout2)]
        
        return user
    }
    
    
    
    public static let sampleRoutineEx = [
                                        [
                                            ExerciseList.allExercisesArray[0][0],
                                            ExerciseList.allExercisesArray[0][0]
                                        ],
                                        [
                                            ExerciseList.allExercisesArray[0][1],
                                            ExerciseList.allExercisesArray[0][1],
                                            ExerciseList.allExercisesArray[0][1],
                                            ExerciseList.allExercisesArray[0][1],
                                            ExerciseList.allExercisesArray[0][1]
                                        ],
                                        [
                                            ExerciseList.allExercisesArray[1][0],
                                            ExerciseList.allExercisesArray[1][0],
                                            ExerciseList.allExercisesArray[1][0],
                                            ExerciseList.allExercisesArray[1][0],
                                            ExerciseList.allExercisesArray[1][0]
                                        ]
                                        
                                    ]
    
    public static let sampleRoutineEx1 = [
                                        [
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0]
                                        ]
                                        
                                    ]
    
    public static let sampleRoutineEx2 = [
                                        [
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0]
                                        ],
                                        [
                                            ExerciseList.allExercisesArray[2][1],
                                            ExerciseList.allExercisesArray[2][1],
                                            ExerciseList.allExercisesArray[2][1]
                                        ],
                                        [
                                            ExerciseList.allExercisesArray[2][0],
                                            ExerciseList.allExercisesArray[2][0],
                                            ExerciseList.allExercisesArray[2][0]
                                        ],
                                        [
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0],
                                            ExerciseList.allExercisesArray[3][0]
                                        ]
                                        
                                    ]
    
    public static let sampleRoutineEx3 = [
                                        [
                                            ExerciseList.allExercisesArray[4][0],
                                            ExerciseList.allExercisesArray[4][0],
                                            ExerciseList.allExercisesArray[4][0]
                                        ],
                                        [
                                            ExerciseList.allExercisesArray[4][1],
                                            ExerciseList.allExercisesArray[4][1],
                                            ExerciseList.allExercisesArray[4][1]
                                        ]
                                        
                                    ]
    
    public static let sampleRoutineRest = [[1, 0], [0, 30], [0, 45]]
    public static let sampleRoutine1Rest = [[0, 30]]
    public static let sampleRoutine2Rest = [[0, 45], [1, 0], [0, 30], [0, 45]]
    public static let sampleRoutine3Rest = [[1, 0], [1, 15]]
    
    
    public static var sampleRoutine = Routine(name: "Sample Routine", description: "This is a really short random description that is supposed to fill in a certain sample space for the purpose of testing this app.", exercises: ExerciseList.sampleRoutineEx, restArr: ExerciseList.sampleRoutineRest)
    public static var sampleRoutine1 = Routine(name: "Quick Abs", description: "Great workout to really get those abs pumping.", exercises: ExerciseList.sampleRoutineEx1, restArr: ExerciseList.sampleRoutine1Rest)
    public static var sampleRoutine2 = Routine(name: "Pull Day", description: "Work your back and biceps in this pull workout which will give you great posture aside from great arms and back.", exercises: ExerciseList.sampleRoutineEx2, restArr: ExerciseList.sampleRoutine2Rest)
    public static var sampleRoutine3 = Routine(name: "Leg Workout", description: "Leg day is easily the most important day of the week, make sure not to skip it.", exercises: ExerciseList.sampleRoutineEx3, restArr: ExerciseList.sampleRoutine3Rest)
    
    
    public static var sampleWorkout = Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(year: 2020, month: 5, day: 7, hour: 10, minute: 5, weekday: 3))
    public static var sampleWorkout1 = Workout(routine: ExerciseList.sampleRoutine2, dateComp: DateComponents(year: 2020, month: 6, day: 15, hour: 20, minute: 5, weekday: 5))
    public static var sampleWorkout2 = Workout(routine: ExerciseList.sampleRoutine3, dateComp: DateComponents(year: 2020, month: 8, day: 1, hour: 10, minute: 5, weekday: 1))
    
    
    
    public static var routines: [Routine] = [
                                            ExerciseList.sampleRoutine,
                                            ExerciseList.sampleRoutine1,
                                            ExerciseList.sampleRoutine2,
                                            ExerciseList.sampleRoutine3
                                        ]
    
    public static func getRoutineArrString() -> [String] {
        var stringArray: [String] = []
        for routine in routines {
            stringArray.append(routine.name)
        }
        return stringArray
    }
    
    public static func getRoutineFromName(name: String) -> Routine {
        for routine in routines {
            if routine.name == name {
                return routine
            }
        }
        return Routine(name: "", description: "", exercises: [], restArr: [])
    }
    
    
    public static func completeWorkouts1And2() {
        for exercise in ExerciseList.sampleWorkout1.specExercises {
            for set in exercise {
                let weight = Int.random(in: 50...150)
                let reps = Int.random(in: 0...10)
                set.setResults(weight: weight, reps: reps)
            }
        }
            
        for exercise in ExerciseList.sampleWorkout2.specExercises {
            for set in exercise {
                let weight = Int.random(in: 50...150)
                let reps = Int.random(in: 0...10)
                set.setResults(weight: weight, reps: reps)
            }
        }
        
        for i in 0..<ExerciseList.sampleWorkout1.specExercises.count {
            ExerciseList.sampleWorkout1.exercisesPerformed[i].addToWorkoutsIn(workout: ExerciseList.sampleWorkout1)
            
        }
        
        for i in 0..<ExerciseList.sampleWorkout2.specExercises.count {
            ExerciseList.sampleWorkout2.exercisesPerformed[i].addToWorkoutsIn(workout: ExerciseList.sampleWorkout2)
        }
            
            
    }

    
    
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
    
    
    public static func getAllExerciseNames() -> [String] {
        var allExercises: [String] = []
        for exerciseGroup in ExerciseList.allExercisesArray {
            for exercise in exerciseGroup {
                allExercises.append(exercise.name)
            }
        }
        
        return allExercises
    }
    
    public static func genStringExerciseDict() -> Dictionary<String, GenExercise> {
        var stringExerciseDict: Dictionary<String, GenExercise> = [:]
        
        for exerciseGroup in ExerciseList.allExercisesArray {
            for exercise in exerciseGroup {
                stringExerciseDict[exercise.name] = exercise
            }
        }
        
        return stringExerciseDict
    }
    
    

    
    
    

}
