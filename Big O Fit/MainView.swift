//
//  MainView.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/24/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var activeHolder = ActiveHolder()
    @State var user = BigOFitUser(name: "Sergio Diaz", bio: "this is my bio", profilePicName: "beaver")
    
    var body: some View {
        ContentMotherView()
            .environmentObject(self.activeHolder)
            .environmentObject(self.user)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
