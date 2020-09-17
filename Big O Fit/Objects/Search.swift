//
//  Search.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

/** Class used to be combined with a SearchView in order to be able to search for a certain element within an array of elements. The search class assists in providing all the options for a specific search and updating the order in which those options are displayed everytime a user types/deletes a letter in the search bar.
 
    Fields:
        - inputText: the text which a user types in what he/she wants to search for -- is usually binded to the TextField used for the search bar
        - searchOptions: the names of the original array of options to search for
        - remainingOptions: the updated list of options based off what the text becomes
 */


class Search: ObservableObject {
    
    
    /// Check lines 13-16 for field documentation.
    @Published var inputText: String {
        didSet {
            self.updateRemainingOptions()
        }
    }
    
    var searchOptions: [String] = []
    @Published var remainingOptions: [String] = []
    
    
    /** The only constructor for Search.
            - Parameter inputText: assigned to inputText
            - Parameter searchOptions: assigned to searchOptions
     */
    
    init(inputText: String, searchOptions: [String]) {
        self.inputText = inputText
        self.searchOptions = searchOptions.sorted()
        self.remainingOptions = searchOptions.sorted()
    }
    
    
    /** Changes the search options of the Search from a previous array, to a new array.
            - Parameter arr: the new array to change the current searchOptions to. */
    
    func switchSearchOptions(arr: [String]) {
        self.searchOptions = arr.sorted()
        self.remainingOptions = arr.sorted()
    }

    
    /** Updates the remainingOptions for a search based off the inputText by the user. This method orders the remainingOptions by using the Levenshtein Distance, which is a number that represents the number of changes needed to be made to make two strings the same.
     */
    
    func updateRemainingOptions() {
        var distanceToWords: Dictionary<Int, [String]> = [:]
        var organizedDistances: [Int] = []
        var organizedWords: [String] = []

        for word in self.searchOptions {
            let levDistance = word.searchDistance(compare: self.inputText)
            if !organizedDistances.contains(levDistance) {
                organizedDistances.append(levDistance)
            }

            if !(distanceToWords.keys.contains(levDistance)) {
                distanceToWords[levDistance] = [word]
            } else {
                distanceToWords[levDistance]?.append(word)
            }
        }

        organizedDistances.sort()
        organizedDistances.reverse()
        
        let primaryDistance = organizedDistances[0]

        for distance in organizedDistances {
            if distance > primaryDistance - 10 {
                organizedWords += distanceToWords[distance]!
            }
            
        }

        self.remainingOptions = organizedWords
    }
    
    
}




