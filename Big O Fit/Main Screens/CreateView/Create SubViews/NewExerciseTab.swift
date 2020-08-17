//
//  NewExerciseTab.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct NewExerciseTab: View {
    var body: some View {
        HStack {
            HStack {
                VStack (alignment: .leading) {
                    Text("Bench Press")
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito-Bold", size: 22))
                        .padding(0)
                    HStack (spacing: 3) {
                        Text("Chest,")
                            .font(.custom("Nunito-Regular", size: 14))
                            .lineLimit(1)
                            .padding(0)
                        Text("Triceps")
                            .font(.custom("Nunito-Regular", size: 14))
                            .lineLimit(1)
                            .padding(0)
                    }
                }
                Spacer()
                MuscleDiagram()
            }
            .padding(17)
            .frame(width: Constants.screenWidth * 0.88, alignment: .leading)
            .background(Color.white)

        }
        .frame(width: Constants.screenWidth)
    }
}

struct NewExerciseTab_Previews: PreviewProvider {
    static var previews: some View {
        NewExerciseTab()
    }
}
