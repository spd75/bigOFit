//
//  CreateRoutine.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/21/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CreateRoutine: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var routineName: String = ""
    @State var routineDescription: String = ""
    
    
    var body: some View {
        return VStack (spacing: 0) {
            ScrollView (.vertical, showsIndicators: false) {
                VStack (spacing: 16) {
                    VStack (spacing: 0) {
                            TextField("Routine Name", text: $routineName)
                                .padding(10)
                                .font(.custom("Nunito-Regular", size: 20))
                                .background(Color.white)
                            
                            Divider()
                                .background(Color.gray)
                            
                            /// Input text field for the workout description
                            MultilineTextView(text: $routineDescription, fillerText: "Routine Description", fontSize: 20)
                                .padding(10)
                                .background(Color.white)
                                .frame(height: 115)
                        
                        
                            Divider()
                                .background(Color.gray)
                                .padding(0)
                    }
                    /// Input text field for the workout name

                    VStack (spacing: 6) {
                        Text("Exercises")
                            .font(.custom("Nunito-SemiBold", size: 30))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 14)
                    }

                    
                    VStack (spacing: 14) {
                        Button(action: {
                            
                        }) {
                            Text("Add Exercise")
                                .padding()
                                .background(CustomColors.darkishred)
                                .foregroundColor(.white)
                                .font(.custom("Nunito-SemiBold", size: 18))
                        }
                    }
                    
                    
                }
                    

            }
            

        }
            

    }
}

struct CreateRoutine_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoutine(viewRouter: ViewRouter())
            .background(CustomColors.grayBackground)
    }
}
