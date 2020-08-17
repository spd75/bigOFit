//
//  CreateExercise.swift
//  Big O Fit
//
//  Created by Home on 7/23/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CreateExercise: View {
    @ObservedObject var viewRouter: ViewRouter
    @Binding var workoutName: String
    @Binding var description: String
    @Binding var allExercises: [[GenExercise]]
    @Binding var mainList: [String]
    @Binding var includedList: [String]

    
    
    var body: some View {
            return VStack (spacing: 1) {
                // Input text field for the workout name
                TextField("Workout Name", text: $workoutName)
                    .padding(10)
                    .font(.custom("Nunito-Regular", size: 20))
                    .background(Color.white)
                
                Divider()
                    .background(Color.gray)
                
                // Input text field for the workout description
                MultilineTextView(text: $description, fillerText: "Workout Description", fontSize: 20)
                    .padding(10)
                    .background(Color.white)
                    .frame(height: 115)
                
                Divider()
                    .background(Color.gray)
                    
                
                
                // Container for "Main Muslces/Other Muslces" combined display
                HStack(alignment: .top) {
                    Spacer()
                    Spacer()
                    
                    // Container for "Main Muscles" display
                    VStack (spacing: 0) {
                        
                        // Title for "Main Muscles" display
                        Text("Main Muscles")
                            .font(.custom("Nunito-Regular", size: 15))
                            .padding(.bottom, 5)
                        
                        // Container for all muscles that have been added to "Main Muscles"
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(0..<self.mainList.count, id: \.self) { i in
                                Button(action: {
                                    self.mainList.remove(at: i)
                                }) {
                                    MiniMuscleButton(muscleName: self.mainList[i], fontSize: 14)
                                }
                                
                            }
                            Button(action: {
                                self.viewRouter.currentFivePage[3] = PageTrack.createSearchMuscleGroupMain
                            }) {
                                MiniMuscleAddButton(fontSize: 14)
                            }
                        }.padding(.bottom, 20)
                        
                    }
                    
                    Spacer()
                    
                    //Container for "Other Muscles" display
                    VStack (spacing: 0) {
                        
                        // Title for "Other Muscles display"
                        Text("Other Muscles")
                            .font(.custom("Nunito-Regular", size: 15))
                            .padding(.bottom, 5)
                        
                        // Container for all muscles that have been added to "Other Muscles"
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(0..<self.includedList.count, id: \.self) { i in
                                Button(action: {
                                    self.includedList.remove(at: i)
                                }) {
                                    MiniMuscleButton(muscleName: self.includedList[i] , fontSize: 14)
                                }
                                
                            }
                            Button(action: {
                                self.viewRouter.currentFivePage[3] = PageTrack.createSearchMuscleGroupIncluded
                            }) {
                                MiniMuscleAddButton(fontSize: 14)
                            }
                        }.padding(.bottom, 20)
                    }
                    
                    Spacer()
                    Spacer()
                    
                }.padding(.top, 25)
                
                Spacer()
                
                
                // Add Exercise button at buttom of screen that adds the custom exercise to collection of user exercises
                Button(action: {
                    self.createAndAddExercise(name: self.workoutName, description: self.description, primaryMuscles: self.mainList, includedMuscles: self.includedList)
                    self.viewRouter.currentFivePage[3] = .createMain
                    self.mainList = []
                    self.includedList = []
                }) {
                    Section {
                        Text("Add Exercise")
                            .font(.custom("Nunito-SemiBold", size: 24))
                            .foregroundColor(.white)
                        
                    }
                    .frame(width: Constants.screenWidth * 0.78)
                    .padding(.vertical, 15)
                    .background(CustomColors.darkishred)
                }
                
            }
            .padding(0)
            .padding(.bottom, Constants.screenHeight * 0.04)
    }
    
    
    func createAndAddExercise(name: String, description: String, primaryMuscles: [String], includedMuscles: [String]) {
        let arms: [BodyPart] = [.forearms, .biceps, .triceps, .shoulders, .frontShoulders, .outerShoulders, .rearShoulders]
        let chest: [BodyPart] = [.chest]
        let back: [BodyPart] = [.lats, .traps]
        let core: [BodyPart] = [.upperabs, .lowerabs]
        let legs: [BodyPart] = [.glutes, .quads, .calves, .hamstrings]
        
        var bodyParts: [BodyPart] = []
        
        
        for muscle in primaryMuscles {
            bodyParts.append(GenExercise.nameToBodyParts[muscle] ?? .other)
        }
        
        for muscle in includedMuscles {
            bodyParts.append(GenExercise.nameToBodyParts[muscle] ?? .other)
        }
        
        
        let exercise = GenExercise(name: name, description: description, bodyParts: bodyParts)

        let chosenBodyPart: BodyPart
        
        if !bodyParts.isEmpty {
            chosenBodyPart = bodyParts[0]
        } else {
            chosenBodyPart = .other
        }
       

        if arms.contains(chosenBodyPart) {
            self.allExercises[1].append(exercise)
            ExerciseList.allExercisesArray[1].append(exercise)
        } else if chest.contains(chosenBodyPart) {
            self.allExercises[0].append(exercise)
            ExerciseList.allExercisesArray[0].append(exercise)
        } else if back.contains(chosenBodyPart) {
            self.allExercises[2].append(exercise)
            ExerciseList.allExercisesArray[2].append(exercise)
        } else if core.contains(chosenBodyPart) {
            self.allExercises[3].append(exercise)
            ExerciseList.allExercisesArray[3].append(exercise)
        } else if legs.contains(chosenBodyPart) {
            self.allExercises[4].append(exercise)
            ExerciseList.allExercisesArray[4].append(exercise)
        }
    }
    

}

struct CreateExercise_Previews: PreviewProvider {
    static var previews: some View {
        CreateExercise(viewRouter: ViewRouter(), workoutName: Binding.constant(""), description: Binding.constant(""), allExercises: Binding.constant(ExerciseList.allExercisesArray), mainList: Binding.constant([""]), includedList: Binding.constant([""]))
    }
}
