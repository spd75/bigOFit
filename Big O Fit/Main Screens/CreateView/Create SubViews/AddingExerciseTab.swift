//
//  AddingExerciseTab.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/21/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct AddingExerciseTab: View {
    var body: some View {
        HStack (alignment: .center) {
            VStack(alignment: .leading) {
                Text("Bench Press")
                    .multilineTextAlignment(.leading)
                    .font(.custom("Nunito-Regular", size: 20))
                    .padding(0)
            }
            
            
            Spacer()
            Divider()
                
            
            VStack (alignment: .leading) {
                Text("Sets: 10")
                    .font(.custom("Nunito-Light", size: 18))
                    .padding(2)
                Text("Rest: 1:40")
                    .font(.custom("Nunito-Light", size: 18))
                    .padding(2)
            }
            

        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .frame(width: Constants.screenWidth * 0.88)
        .background(Color.white)
        

    }
}

struct AddingExerciseTab_Previews: PreviewProvider {
    static var previews: some View {
        AddingExerciseTab()
            .background(CustomColors.darkGrayBackground)
    }
}
