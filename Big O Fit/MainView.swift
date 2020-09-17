//
//  MainView.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/24/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

/** The MainView is the view that is a parent for every subview in the app. The MainView is oversees the view that is always opened and oversees all other child views in the app.
 
    Fields:
        - @State activeHolder: the class which contains the current routine and workout selected to perform.
        - @State user: the object which contains all the information for the current user using the application
 */

struct MainView: View {
    @State var activeHolder = ActiveHolder()
    @State var user = BigOFitUser(name: "Sergio Diaz", bio: "This is my bio", profilePicName: "beaver")
    
    var body: some View {
        ContentMotherView()
            .environmentObject(self.activeHolder)
            .environmentObject(self.user)
    }
}


/// The preview for the MainView. Can be used to debug the app since the MainView has full functionality of the app.
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
