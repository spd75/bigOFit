//
//  ExerciseSearchScreen.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/22/20.
//  Copyright © 2020 Home. All rights reserved.
//

//
//  SearchScreen.swift
//  Big O Fit
//
//  Created by Home on 7/27/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import SwiftUI

struct ExerciseSearchScreen: View {
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var search: Search
    var searchTitle: String
    let pageIndex: Int? = 3
    let returnPage: PageTrack
    @Binding var selectedOptions: [String]
    @Binding var exerciseInfo: [[[Int]]]

    
    
    var body: some View {
        return VStack {
            
            // The field for the search bar
            TextField(searchTitle, text: $search.inputText)
                .padding(.top, 15)
                .padding(.horizontal, 15)
                .font(.custom("Nunito-Regular", size: 20))
                .background(Color.white)
            
            // The underline below the title
            Divider()
                .padding(.top, 1)
                .background(Color.black)
            
            // The container for the search results
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(self.search.remainingOptions, id: \.self) { option in
                    Button(action: {
                        self.selectedOptions.append(option)
                        self.viewRouter.currentFivePage[self.pageIndex!] = self.returnPage
                        self.exerciseInfo.append([[1], [1, 0]])
                    }) {
                        
                        VStack (spacing: 0) {
                            Text(option)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 15)
                                .frame(width: Constants.screenWidth, alignment: .leading)
                                .font(.custom("Nunito-Regular", size: 18))
                                .foregroundColor(Color.black)
                            Divider()
                               
                        }

                    }
                }
            }
            
            Spacer()
        
        }
        .background(Color.white)
        .padding(0)
        
    }
}



struct ExerciseSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSearchScreen(viewRouter: ViewRouter(), search: Search(inputText: "", searchOptions: Array(GenExercise.bodyPartsToName.values.sorted())), searchTitle: "Search muscle groups", returnPage: PageTrack.createAddExercise,  selectedOptions: Binding.constant([""]), exerciseInfo: Binding.constant([]))
    }
}

