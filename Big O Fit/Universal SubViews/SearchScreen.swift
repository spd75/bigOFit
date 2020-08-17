//
//  SearchScreen.swift
//  Big O Fit
//
//  Created by Home on 7/27/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchScreen: View {
    @ObservedObject var viewRouter: ViewRouter
    var searchTitle: String
    let pageIndex: Int? = 3
    let returnPage: PageTrack
    @State var searchOptions: [String]
    @Binding var selectedOptions: [String]
    @State var currentText: String = ""
    @State var currentLevenshtein = 0

    
    
    var body: some View {
        let searchOptionsLeft = organizeWordSimilarity(allWords: searchOptions, compareTo: self.currentText)
        
        return VStack {
            
            // The field for the search bar
            TextField(searchTitle, text: $currentText)
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
                ForEach(searchOptionsLeft, id: \.self) { option in
                    Button(action: {
                        self.selectedOptions.append(option)
                        self.viewRouter.currentFivePage[self.pageIndex!] = self.returnPage
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



struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen(viewRouter: ViewRouter(), searchTitle: "Search muscle groups", returnPage: PageTrack.createAddExercise , searchOptions: Array(GenExercise.bodyPartsToName.values.sorted()), selectedOptions: Binding.constant([""]))
    }
}
