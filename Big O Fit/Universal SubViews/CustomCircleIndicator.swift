//
//  CustomCircleIndicator.swift
//  Big O Fit
//
//  Created by Home on 8/9/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CustomCircleIndicator: View {
    var totalScreenNum: Int
    @Binding var currentScreen: Int
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<totalScreenNum) { i in
                    Image(systemName: self.getImageName(index: i))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            Spacer()
        }

    }
    
    private func getImageName(index: Int) -> String {
        if index == currentScreen {
            return "circle.fill"
        }
        
        return "circle"
    }
}

struct CustomCircleIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CustomCircleIndicator(totalScreenNum: 5, currentScreen: Binding.constant(2))
    }
}
