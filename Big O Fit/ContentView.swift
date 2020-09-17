//
//  ContentView.swift
//  Big O Fit
//
//  Created by Home on 7/11/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI


/** ContentView provides the main view for the entire app.  It provides the traditional
    5-tabbed layout in which each MotherView is generated according to which tab is pressed.
    
    Fields:
        - @ObservedObject viewRouter: object controls which screen is currently shown through the use of mother views
        - @Environment user: the object which contains all the information for the current user using the application
        - @State selection: Int that tracks which tab is open -> 0 is the leftmost tab, 4 is the rightmost tab
 */

struct TabbedView: View {
    @ObservedObject var viewRouter = ViewRouter()
    @EnvironmentObject var user: BigOFitUser
    @State private var selection = 0

 
    var body: some View {
        VStack(spacing: 0) {
            
            /// The custom NavBar
            CustomNavBar(selection: $selection, viewRouter: self.viewRouter)
            
            /// MotherView which handles scheduling workouts and quick starts
            TabView(selection: $selection){
                WorkoutsMotherView(viewRouter: self.viewRouter, scheduledWorkouts: user.getScheduledWorkouts2D())
                    .font(.title)
                    .tabItem {
                        Image(systemName: "bolt")
                            .font(.system(size: 20))
                        Text("Workouts")
                    }
                    .tag(0)
                
                
                /// View which will contain the groups a user has currently joined.
                Text("View still in progress.")
                    .font(.title)
                    .tabItem {
                        Image(systemName: "person.3")
                            .font(.system(size: 22))
                        Text("Groups")
                    }
                    .tag(1)
                
                
                /// View which a user can search other users and groups.
                Text("View still in progress.")
                    .font(.title)
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle")
                            .font(.system(size: 26))
                        Text("Search")
                    }
                    .tag(2)
                
                
                /// MotherView which contains the create screen information
                CreateMotherView(viewRouter: self.viewRouter)
                    .font(.title)
                    .tabItem {
                        Image(systemName: "goforward.plus")
                            .font(.system(size: 22))
                        Text("Create")
                    }
                    .tag(3)
                
                
                /// MotherView which displays the user's profile
                ProfileMotherView(viewRouter: self.viewRouter)
                    .font(.title)
                    .tabItem {
                        Image(systemName: "house")
                            .font(.system(size: 22))
                        Text("Home")
                    }
                    .tag(4)
                }.accentColor(.black).onAppear() {
                
                UITabBar.appearance().backgroundColor = UIColor.white
            }
        }
        .edgesIgnoringSafeArea(.top)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView(viewRouter: ViewRouter())
            .environmentObject(ExerciseList.getTestUser())
    }
}
