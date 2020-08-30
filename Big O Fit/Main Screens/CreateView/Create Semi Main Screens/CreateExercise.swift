//
//  CreateExercise.swift
//  Big O Fit
//
//  Created by Home on 7/23/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CreateExercise: View, CreateScreen {
    @EnvironmentObject var user: BigOFitUser
    @ObservedObject var viewRouter: ViewRouter
    @Binding var name: String
    @Binding var desc: String
    @Binding var mainList: [String]
    @Binding var includedList: [String]
    
    @State var subText: String = "Click on the buttoms below to add the muscle groups used in this exercise."
    @State var emptyPress: Bool = false
    
    
    var body: some View {
            return VStack (spacing: 1) {
                // Input text field for the workout name
                TextField("Workout Name", text: $name)
                    .padding(10)
                    .font(.custom("Nunito-Regular", size: 20))
                    .background(Color.white)
                
                Divider()
                    .background(Color.gray)
                
                // Input text field for the workout description
                MultilineTextView(text: $desc, fillerText: "Workout Description", fontSize: 20)
                    .padding(10)
                    .background(Color.white)
                    .frame(height: 115)
                    .clipped()
                    .shadow(radius: 2, y: 1)
                
                Divider()
                    .background(Color.gray)
                    
                
                
                VStack {
                    Text("Muscle Groups")
                        .font(.custom("Nunito-SemiBold", size: 30))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 18)
                        .padding(.bottom, 1)
                    Text(self.subText)
                        .font(.custom("Nunito-Regular", size: 14))
                        .multilineTextAlignment(.center)
                        .lineLimit(5)
                        .padding(.horizontal, Constants.screenWidth * 0.04)
                        .padding(.bottom, 5)
                    
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
                            }
                            .padding(.bottom, 20)
                            .clipped()
                            .shadow(radius: 2, y: 1)
                            
                        }
                        
                        Spacer()
                        
                        // Container for "Other Muscles" display
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
                            }
                            .padding(.bottom, 20)
                            .clipped()
                            .shadow(radius: 2, y: 1)
                        }
                        
                        Spacer()
                        Spacer()
                        
                    }.padding(.top, 25)
                }
                

                
                Spacer()
                
                // Add Exercise button at buttom of screen that adds the custom exercise to collection of user exercises
                
                ActionButton(text: "Add Exercise", action: {
                    let emptyVal = self.checkEmpty()
                    let isValid = self.checkValid()
                    
                    print(emptyVal)
                    print(isValid)
                    
                    if emptyVal == 0 && isValid {
                        self.createAndAddExercise(name: self.name, description: self.desc, primaryMuscles: self.mainList, includedMuscles: self.includedList)
                        self.viewRouter.currentFivePage[3] = .createMain
                    } else if emptyVal == 1 {
                        self.subText = "You must add at least one muscle group before creating an exercise."
                    } else if emptyVal == 2 {
                        self.subText = "Please fill out all fields above. All routines must have a name and description."
                    } else if !isValid {
                        self.subText = "Exercise already exists. Change current name or delete duplicate routine."
                    }

                })
                
            }
            .padding(0)
            .padding(.bottom, Constants.screenHeight * 0.04)
    }
    
    func checkEmpty() -> Int {
        let rName = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let rDesc = self.desc.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if self.mainList.count == 0 && self.includedList.count == 0 {
            return 1
        } else if (rName == "" || rDesc == "") {
            return 2
        }
        
        return 0
    }
    
    func checkValid() -> Bool {
        for type in self.user.allExercises {
            for exercise in type {
                if self.name == exercise.name {
                    return false
                }
            }
        }
        return true
    }
    
    
    func createAndAddExercise(name: String, description: String, primaryMuscles: [String], includedMuscles: [String]) {
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
       

        if exercise.categoryString.lowercased() == "chest" {
            self.user.allExercises[0].append(exercise)
        } else if exercise.categoryString.lowercased() == "arms" {
            self.user.allExercises[1].append(exercise)
        } else if exercise.categoryString.lowercased() == "back" {
            self.user.allExercises[2].append(exercise)
        } else if exercise.categoryString.lowercased() == "core" {
            self.user.allExercises[3].append(exercise)
        } else if exercise.categoryString.lowercased() == "legs" {
            self.user.allExercises[4].append(exercise)
        } else {
            self.user.allExercises[5].append(exercise)
        }
    }
    

}

struct CreateExercise_Previews: PreviewProvider {
    static var previews: some View {
        CreateExercise(viewRouter: ViewRouter(), name: Binding.constant(""), desc: Binding.constant(""), mainList: Binding.constant([""]), includedList: Binding.constant([""]))
    }
}
