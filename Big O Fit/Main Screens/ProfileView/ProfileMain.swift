//
//  ProfileMain.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/25/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ProfileMain: View {
    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var user: BigOFitUser
    
    @Binding var currentWorkout: Workout
    @Binding var currentExercise: GenExercise
    @Binding var tabTracker: Int
    
    @State var searchWords: String = ""
    @ObservedObject var search = Search(inputText: "", searchOptions: [])
    
    @State var vStackOffset: CGFloat = 0
    @State var scrollOffset: CGFloat = 0
    @State var keyboardHeight: CGFloat = 0
    
    @Binding var screenFrame: CGRect
    @State var textFieldFrame = CGRect()
        
    var body: some View {
        let title = self.tabTracker == 0 ? "Workout History" : self.tabTracker == 1 ? "Personal Records" : "Exercise Data"
        let text = self.tabTracker == 0 ? "To delete a workout from your history, double tap on its history tab." : self.tabTracker == 1 ? "The most weight achieved on each exercise you've performed are listed below." : "The history of all exercises performed.  Tracks weights and reps so you can see progress over time."
        
        
        return ScrollView(.vertical, showsIndicators: false) {
                VStack (spacing: 0) {
                    VStack (spacing: 22) {
                            HStack (alignment: .top) {
                                    VStack {
                                        Image(user.profilePicName)
                                        .resizable()
                                        .frame(width: Constants.screenWidth * 0.33, height: Constants.screenWidth * 0.33)
                                        .cornerRadius(Constants.screenWidth * 0.33)
                                        .shadow(color: .black, radius: 4)
                                    }

                                    Spacer()
                                    
                                VStack (spacing: 10) {
                                    HStack (spacing: 0) {
                                            VStack {
                                                Text("Workouts")
                                                    .font(.custom("Nunito-Regular", size: 13))
                                                    .padding(0)
                                                Text(String(user.completedWorkouts.count))
                                                    .font(.custom("Nunito-Regular", size: 21))
                                                    .padding(0)
                                            }
                                            .padding(8)
                                            .frame(width: Constants.screenWidth * 0.25)
                                            
                                            Divider()
                                                .frame(height: 50)
                                                .padding(0)
                                            
                                            VStack {
                                                Text("Friends")
                                                    .font(.custom("Nunito-Regular", size: 13))
                                                    .padding(0)
                                                Text(String(user.friends.count))
                                                    .font(.custom("Nunito-Regular", size: 21))
                                                    .padding(0)
                                            }
                                            .padding(8)
                                            .frame(width: Constants.screenWidth * 0.25)
                                            
                                        }
                                        .background(Color.white)
                                        .border(Color.gray)
                                        .clipped()
                                        .shadow(radius: 1, y: 1)
                                        
                                    ActionButton(text: "Profile Settings", widthRatio: 0.5, fontName: "Nunito-Regular", fontSize: 13, buttonColor: .white, buttonPadding: 10, textColor: .black, shadow: 0, action: {
                                            
                                    }).border(Color.gray)
                                    }
                                    
                                    
                                }
                            
                            VStack {
                                HStack {
                                    Text(user.name)
                                        .font(.custom("Nunito-SemiBold", size: 25))
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(user.bio)
                                        .font(.custom("Nunito-Regular", size: 15))
                                    Spacer()
                                }
                                
                            }


                            

                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 20)
                            .background(Color.white)
                            .clipped()
                            .shadow(radius: 1, y: 1)
                            .edgesIgnoringSafeArea(.top)
                        
                        
                        TabSwitcher(textArr: ["Workouts", "PRs", "Data"], currentTab: self.$tabTracker, fontSize: 14)
                            .border(Color.gray)
                            .clipped()
                            .shadow(radius: 2, y: 1)
                            .padding(.top, 22)
                            .padding(.bottom, 30)
                        
                        
                        
                        Text(title)
                            .font(.custom("Nunito-SemiBold", size: 23))
                        Text(text)
                            .font(.custom("Nunito-Regular", size: 14))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 25)
                        
                        
                        if self.tabTracker == 0 {
                            WorkoutLogSubscreen(viewRouter: self.viewRouter, currentWorkout: self.$currentWorkout)
                        } else if self.tabTracker == 1 {
                            VStack (spacing: 20) {
                                AllPRBoxes(allPRCategories: self.user.personalRecords)
                            }
                        } else {
                            ExerciseSearchSection(viewRouter: self.viewRouter, currentExercise: $currentExercise, text: self.$search.inputText, remainingOptions: self.$search.remainingOptions, textFieldFrame: self.$textFieldFrame)
                        }
                        
                        Spacer()

                    
                
                }
                .offset(y: self.vStackOffset)
                .padding(.bottom, keyboardHeight * 1.5 + 15)
                
            
            }
            .offset(y: self.scrollOffset)
            .onAppear {
                self.search.switchSearchOptions(arr: self.user.getExerciseArrString())
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { app in
                    let value = app.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.keyboardHeight = height

                    self.vStackOffset = self.getOffset(screenFrame: self.screenFrame, textFieldFrame: self.textFieldFrame, keyboardHeight: height)
                }

                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { app in
                    self.vStackOffset = 0
                    self.keyboardHeight = 0
            }
        }
            
        
    }
    
    
    func getOffset(screenFrame: CGRect, textFieldFrame: CGRect, keyboardHeight: CGFloat) -> CGFloat {
        let maxLimit = textFieldFrame.minY
        let minLimit = maxLimit - (screenFrame.height - keyboardHeight)
        let finalPosition = (maxLimit * 0.8) + (minLimit * 0.2)
        
        return screenFrame.minY - finalPosition
    }
}

struct ProfileMain_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMain(viewRouter: ViewRouter(), currentWorkout: Binding.constant(ExerciseList.sampleWorkout), currentExercise: Binding.constant(ExerciseList.allExercisesArray[0][0]), tabTracker: Binding.constant(0), screenFrame: Binding.constant(CGRect()))
            .environmentObject(ExerciseList.getTestUser())
    }
}
