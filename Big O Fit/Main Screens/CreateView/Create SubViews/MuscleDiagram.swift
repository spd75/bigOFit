//
//  MuscleDiagram.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct MuscleDiagram: View {
    var body: some View {
        Image("Chest-3")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 60)
            .padding(15)
            .overlay(
                Circle()
                .stroke(CustomColors.darkishred, lineWidth: 2)
            )
    }
}

struct MuscleDiagram_Previews: PreviewProvider {
    static var previews: some View {
        MuscleDiagram()
    }
}
