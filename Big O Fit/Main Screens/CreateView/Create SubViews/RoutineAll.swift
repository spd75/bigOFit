//
//  RoutineAll.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/22/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct RoutineAll: View {
    @EnvironmentObject var user: BigOFitUser
    
    @ObservedObject var viewRouter: ViewRouter
    @Binding var currentSpecRoutine: Routine
    
    var body: some View {
        VStack (spacing: 0) {
            NunitoTitle(text: "All Routines", pHorizontal: ExerciseTab.horizPadding + Constants.screenWidth * 0.06)
            VStack (spacing: 20) {
                ForEach(self.user.allRoutines, id: \.self) { routine in
                    RoutineTab(viewRouter: self.viewRouter, currentSpecRoutine: self.$currentSpecRoutine, routine: routine)
                }
            }

        }
        
    }
}

struct RoutineAll_Previews: PreviewProvider {
    static var previews: some View {
        RoutineAll(viewRouter: ViewRouter(), currentSpecRoutine: Binding.constant(Routine(name: "", description: "", exercises: [], restArr: [])))
    }
}
