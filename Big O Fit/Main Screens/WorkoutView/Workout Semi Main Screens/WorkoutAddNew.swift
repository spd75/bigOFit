//
//  AddNewWorkout.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI


struct WorkoutAddNew: View {
    @EnvironmentObject var activeHolder: ActiveHolder
    @EnvironmentObject var user: BigOFitUser
    @ObservedObject var viewRouter: ViewRouter
    @Binding var scheduledWorkouts: [[Workout]]
    @Binding var selectedRoutineString: [String]
    
    @State var chosenDate = Date() {
        didSet {
            self.chosenDateComps = self.calendar.dateComponents([.year, .month, .day, .weekday, .minute, .hour], from: self.chosenDate)
        }
    }
    @Binding var chosenDateComps: DateComponents
    @State var selectingDate: Bool = false
    @State var invalidClicks = 0
    
    let calendar = Calendar.current
    
    var body: some View {
        var hasRoutines = false
        var validRoutine: Routine = Routine(name: "", description: "", exercises: [], restArr: [])
        if selectedRoutineString.count > 0 {
            hasRoutines = true
            let i = selectedRoutineString.count - 1
            validRoutine = user.getRoutineFromName(name: self.selectedRoutineString[i])
        }
        let validWorkout = Workout(routine: validRoutine, dateComp: self.chosenDateComps)
        
        return VStack (spacing: 25) {
                    VStack {
                        Text("Schedule Workout")
                            .font(.custom("Nunito-Bold", size:30))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 0)
                        Text("Select a routine and date below.")
                            .lineLimit(10)
                            .font(.custom("Nunito-Regular", size: 18))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .padding(.top, 13)
                    .frame(width: Constants.screenWidth)
                    .background(Color.white)
                    .clipped()
                    .shadow(radius: 2, y: 2)

                    VStack {
                        if !hasRoutines {
                            Rectangle()
                                .foregroundColor(Color.white)
                                .border(Color(red: 210/255, green: 210/255, blue: 210/255))
                                .frame(width: Constants.screenWidth * 0.88, height: 85)
                                .overlay(
                                    Text("Click here to select a routine.")
                                        .font(.custom("Nunito-Regular", size: 16))
                                )
                                .onTapGesture {
                                    self.viewRouter.currentFivePage[0] = PageTrack.workoutAddNewRoutineSearch
                                }
                                .clipped()
                                .shadow(radius: 2, y: 1)
                        } else {
                            RoutineTab(viewRouter: self.viewRouter, currentSpecRoutine: Binding.constant(Routine(name: "", description: "", exercises: [], restArr: [])), routine: validRoutine, routineSize: 19, imageRad: 28, descriptionSize: 12)
                                .frame(width: Constants.screenWidth * 0.88, height: 85)
                                .contentShape(Rectangle())
                                .onLongPressGesture {
                                    self.viewRouter.currentFivePage[0] = PageTrack.workoutAddNewRoutineSearch
                                }
                                .clipped()
                                .shadow(radius: 2, y: 1)
                        }
                        
                        

                        Rectangle()
                            .foregroundColor(Color.white)
                            .border(Color(red: 210/255, green: 210/255, blue: 210/255))
                            .frame(width: Constants.screenWidth * 0.88, height: 50)
                            .overlay(
                                Text(self.dateText())
                                    .font(.custom("Nunito-Regular", size: 15))
                                    .multilineTextAlignment(.center)
                                    .padding(2)
                            )
                            .onTapGesture {
                                self.selectingDate.toggle()
                                self.chosenDateComps = self.calendar.dateComponents([.year, .month, .day, .weekday, .minute, .hour], from: self.chosenDate)
                            }
                            .clipped()
                            .shadow(radius: 2, y: 1)
                        
                        Spacer()

                        if self.selectingDate {
                            DatePicker("", selection: self.$chosenDate, displayedComponents: [.date, .hourAndMinute])
                                .frame(width: Constants.screenWidth * 0.9, alignment: .center)
                                .animation(.spring())
                        } else {
                            ActionButton(text: "Create Workout", action: {
                                if validRoutine.name != "" && DateTime.dateCompIsValid(comp: self.chosenDateComps) {
                                    self.selectedRoutineString = []
                                    self.user.addToScheduledWorkoutsArr(workout: validWorkout)
                                    self.scheduledWorkouts = self.user.getScheduledWorkouts2D()
                                    self.viewRouter.currentFivePage[0] = .workoutMain
                                    self.chosenDateComps = DateComponents()
                                } else {
                                    self.invalidClicks += 1
                                }

                            }).padding(.bottom, 15)
                            
                        }
                        
                    }

            }

    }
    
    func dateText() -> String {
        let current = DateTime.getUpdatedTime()
        let currentVal = DateTime.getDateTimeVal(comp: current)
        let chosenVal = DateTime.getDateTimeVal(comp: self.chosenDateComps)
        
        if chosenVal <= 1 {
            return "Click here to select a date."
        }
        if chosenVal < currentVal {
            return "Invalid date selected. Please choose a future date."
        }
        
        return DateTime.getDateTimeText(comp: self.chosenDateComps)
    }
        
}


struct AddNewWorkout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutAddNew(viewRouter: ViewRouter(), scheduledWorkouts: Binding.constant([]), selectedRoutineString: Binding.constant([]), chosenDateComps: Binding.constant(DateComponents()))
    }
}
