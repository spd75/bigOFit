//
//  CreateRoutine.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/21/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CreateRoutine: View, CreateScreen {
    @EnvironmentObject var user: BigOFitUser
    
    @ObservedObject var viewRouter: ViewRouter
    @Binding var exerciseStringArray: [String]
    @Binding var exerciseInfo: [[[Int]]]
    var conversionDict: Dictionary<String, GenExercise>

    @Binding var subText: String
    @Binding var name: String
    @Binding var desc: String
    
    @State var emptyPress = false
    
    
    var body: some View {
        var exerciseObj = convertStringsToExercises(stringArr: self.exerciseStringArray, dictConversion: conversionDict)
        var emptyVal = self.checkEmpty()
        var isValid = self.checkValid()

        return VStack (spacing: 0) {
            ScrollView (.vertical, showsIndicators: false) {
                VStack (spacing: 0) {
                    VStack (spacing: 0) {
                            TextField("Routine Name", text: $name)
                                .padding(10)
                                .font(.custom("Nunito-Regular", size: 20))
                                .background(Color.white)
                            
                            Divider()
                                .background(Color.gray)
                            
                            /// Input text field for the workout description
                            MultilineTextView(text: $desc, fillerText: "Routine Description", fontSize: 20)
                                .padding(10)
                                .background(Color.white)
                                .frame(height: 115)
                        
                        
                            Divider()
                                .background(Color.gray)
                                .padding(0)
                    }
                    .clipped()
                    .shadow(radius: 1, y: 1)
                    /// Input text field for the workout name

                    Text("Exercises")
                        .font(.custom("Nunito-SemiBold", size: 30))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 25)
                        .padding(.bottom, 1)
                    Text(self.subText)
                        .font(.custom("Nunito-Regular", size: 14))
                        .multilineTextAlignment(.center)
                        .lineLimit(5)
                        .padding(.horizontal, Constants.screenWidth * 0.04)
                        .padding(.bottom, 22)

                    
                    VStack (spacing: 0) {
                        ForEach(0..<exerciseObj.count, id: \.self) { i in
                            AddingExerciseTab(exercise: exerciseObj[i], setsNum: self.$exerciseInfo[i][0][0], timeNum: self.$exerciseInfo[i][1])
                                .padding(.bottom, 10)
                                .onTapGesture (count: 2) {
                                    self.exerciseStringArray.remove(at: i)
                                    exerciseObj.remove(at: i)
                                }
                        }
                    }.padding(.bottom, 10)

                    
                    VStack (spacing: 14) {
                        ActionButton(text: "Add Exercise", widthRatio: 0.46, fontSize: 18, action: {
                            self.subText = "Add as many exercises as you want.  Double tap on an exercise to delete it."
                            self.viewRouter.currentFivePage[3] = .createSearchExercise
                        })
                        
                        ActionButton(text: "Create Routine", action: {
                            emptyVal = self.checkEmpty()
                            isValid = self.checkValid()
                            
                            print(self.exerciseInfo)
                            
                            if (emptyVal == 0) && isValid {
                                let newRoutine = Routine(name: self.name, description: self.desc, exercises: self.createExerciseArray(), restArr: self.getTimeArray(info: self.exerciseInfo))
                                self.user.allRoutines.append(newRoutine)
                                self.viewRouter.currentFivePage[3] = .createMain
                            } else if emptyVal == 1 {
                                self.emptyPress = true
                                self.subText = "Please add an exercise to create a routine."
                            } else if emptyVal == 2 {
                                self.emptyPress = true
                                self.subText = "Please fill out all fields above. All routines must have a name and description."
                            } else if !isValid {
                                self.emptyPress = true
                                self.subText = "Routine name already exists. Change current name or delete duplicate routine."
                            }
                        })
                        
                            
                        }
                        .padding(0)
                        .padding(.bottom, Constants.screenHeight * 0.04)
                        
                    }
    
            }
                

        }
        

    }
    
    
    func checkEmpty() -> Int {
        let rName = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let rDesc = self.desc.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if exerciseStringArray.count == 0 {
            return 1
        } else if (rName == "" || rDesc == "") {
            return 2
        }
        
        return 0
    }
            
    
    func checkValid() -> Bool {
        var isRepeated = true
        var i = 0
        while i < self.user.allRoutines.count && isRepeated == true {
            if self.user.allRoutines[i].name == self.name {
                isRepeated = false
            }
            i += 1
        }
        return isRepeated
    }
    
    
    func getTimeArray(info: [[[Int]]]) -> [[Int]] {
        var infoArr: [[Int]] = []
        for i in 0..<info.count {
            infoArr.append(info[i][1])
        }
        return infoArr
    }

    
    func convertStringsToExercises(stringArr: [String], dictConversion: Dictionary<String, GenExercise>) -> [GenExercise] {
        var exerciseArr: [GenExercise] = []
        for string in self.exerciseStringArray {
            let exercise = dictConversion[string]
            exerciseArr.append(exercise!)
        }
        return exerciseArr
    }
    
    
    func createExerciseArray() -> [[GenExercise]] {
        let genExercises = convertStringsToExercises(stringArr:
            exerciseStringArray, dictConversion: conversionDict)
        var allExercises: [[GenExercise]] = []
        
        for i in 0..<genExercises.count {
            var genExercisesArr: [GenExercise] = []
            for j in 0..<self.exerciseInfo[i][0][0] {
                genExercisesArr.append(genExercises[i])
            }
            allExercises.append(genExercisesArr)
        }
        
        return allExercises
    }

}


struct CreateRoutine_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoutine(viewRouter: ViewRouter(), exerciseStringArray: Binding.constant(["Push"]), exerciseInfo: Binding.constant([[[1], [1, 0]]]), conversionDict: ["Push": GenExercise(name: "Push", description: "Pushing", bodyParts: [.triceps])], subText: Binding.constant(""), name: Binding.constant("No exercises added to routine yet."), desc: Binding.constant(""))
            .background(CustomColors.grayBackground)
            .environmentObject(ExerciseList.getTestUser())
    }
}
