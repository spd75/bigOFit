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
 */
struct ContentView: View {
    @State private var selection = 0
    @ObservedObject var viewRouter = ViewRouter()
 
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(selection: $selection, viewRouter: self.viewRouter)
                
            TabView(selection: $selection){
                WorkoutsMotherView(viewRouter: self.viewRouter)
                    .font(.title)
                    .tabItem {
                        Image(systemName: "bolt")
                            .font(.system(size: 20))
                        Text("Workouts")
                    }
                    .tag(0)
                
                Text("First View")
                    .font(.title)
                    .tabItem {
                        Image(systemName: "person.3")
                            .font(.system(size: 22))
                        Text("Groups")
                    }
                    .tag(1)
                
                Text("Second View")
                    .font(.title)
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle")
                            .font(.system(size: 26))
                        Text("Search")
                    }
                    .tag(2)
                
                CreateMotherView(viewRouter: self.viewRouter)
                    .font(.title)
                    .tabItem {
                        Image(systemName: "goforward.plus")
                            .font(.system(size: 22))
                        Text("Create")
                    }
                    .tag(3)
                
                Text("Fourth View")
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
        ContentView(viewRouter: ViewRouter())
    }
}
