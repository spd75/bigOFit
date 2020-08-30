//
//  Search.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class Search: ObservableObject {
    
    @Published var inputText: String {
        didSet {
            self.remainingOptions = self.updateRemainingOptions(allWords: self.searchOptions, compareTo: self.inputText)
        }
    }
    
    var searchOptions: [String] = []
    @Published var remainingOptions: [String] = []
    
    init(inputText: String, searchOptions: [String]) {
        self.inputText = inputText
        self.searchOptions = searchOptions.sorted()
        self.remainingOptions = searchOptions.sorted()
    }
    
    
    func switchSearchOptions(arr: [String]) {
        self.searchOptions = arr.sorted()
        self.remainingOptions = arr.sorted()
    }

    
    func updateRemainingOptions(allWords: [String], compareTo: String) -> [String] {
        var distanceToWords: Dictionary<Int, [String]> = [:]
        var organizedDistances: [Int] = []
        var organizedWords: [String] = []

        for word in allWords {
            let ld = word.searchDistance(compare: compareTo)
            if !organizedDistances.contains(ld) {
                organizedDistances.append(ld)
            }

            if !(distanceToWords.keys.contains(ld)) {
                distanceToWords[ld] = [word]
            } else {
                distanceToWords[ld]?.append(word)
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

        return organizedWords
    }
    
    
}




