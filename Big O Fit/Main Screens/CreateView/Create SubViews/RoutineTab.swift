//
//  Routine Tab.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/22/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct RoutineTab: View {
    @ObservedObject var viewRouter: ViewRouter
    @Binding var currentSpecRoutine: Routine
    var routine: Routine
    
    var routineSize: CGFloat?
    var imageRad: CGFloat?
    var descriptionSize: CGFloat?
    
    var body: some View {
        var exerciseNames: [String] = []
        for i in 0..<self.routine.exercises.count {
            if i == self.routine.exercises.count - 1 {
                exerciseNames.append(self.routine.exercises[i][0].name)
            } else {
                exerciseNames.append(self.routine.exercises[i][0].name + ", ")
            }
            
        }
        
        return VStack (spacing: 8) {
                VStack (spacing: 0) {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(routine.name)
                            .multilineTextAlignment(.leading)
                            .font(.custom("Nunito-Bold", size: routineSize ?? 24))
                            .padding(0)
                    }
            
                    
                    Spacer()
                    
                    Image("beaver")
                        .resizable()
                        .frame(width: self.imageRad ?? 40, height: self.imageRad ?? 40)
                        .cornerRadius(45)
                        .shadow(radius: 8)
                    
                    }
                .padding(.horizontal, 10)
                .frame(width: Constants.screenWidth * 0.88)
                }



                Divider()
                    .frame(width: Constants.screenWidth * 0.84, alignment: .center)
                    .padding(.top, 1)
                    .background(CustomColors.darkishred)
                
                VStack (alignment: .leading) {
                    Text(routine.description)
                    .lineSpacing(0)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito-Regular", size: self.descriptionSize ?? 20))
                }
                .padding(.top, 6)
                .padding(.horizontal, 10)
                .frame(width: Constants.screenWidth * 0.88, alignment: .topLeading)
                

            }
            .padding(15)
            .frame(width: Constants.screenWidth * 0.88)
            .background(Color.white)
            .onTapGesture {
                self.currentSpecRoutine = self.routine
                self.viewRouter.currentFivePage[3] = .createSpecificRoutine
            }
            .clipped()
            .shadow(radius: 2, y: 1)
            
            
            
        }

           
        
            
            
}
    


struct RoutineTab_Previews: PreviewProvider {
    static var previews: some View {
        RoutineTab(viewRouter: ViewRouter(), currentSpecRoutine: Binding.constant(Routine(name: "", description: "", exercises: [], restArr: [])), routine: ExerciseList.sampleRoutine)
    }
}
