//
//  Levenshtein.swift
//  Big O Fit
//
//  Created by Home on 7/28/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


/// String extension implemented to add search characteristics to strings
extension String {
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    
    
    /** Returns the Levenshtein Distance between the specific string and a comparison string.  The Levenshtein Distance is an integer value which represents the number of changes needed to convert one string to another.
            - Parameter compare; the string to compare this string to
            - Returns: the Levenshtein Distance of the two strings
     */
    
    public func searchDistance(compare: String) -> Int {
        var letterSum = 0
        var exactnessSum = 0
        var currentLetters: [String] = []
        let currentCount = self.count
        var compareLetters: [String] = []
        let compareCount = compare.count
        
        let greaterCount = compareCount > currentCount ? compareCount : currentCount
        
        for i in 0..<greaterCount {
            if i < currentCount && !currentLetters.contains(self[i].lowercased()) {
                currentLetters.append(self[i].lowercased())
            }
            
            if i < compareCount && !compareLetters.contains(compare[i].lowercased()) {
                compareLetters.append(compare[i].lowercased())
            }
            
            if i < compareCount && i < currentCount && compare[i].lowercased() == self[i].lowercased() {
                exactnessSum += 4
            }
        }
        
        let greaterLetters = greaterCount == compareCount ? compareLetters : currentLetters
        let lesserLetters = greaterLetters == compareLetters ? currentLetters : compareLetters
        
        for letter in greaterLetters {
            if lesserLetters.contains(letter) {
                letterSum += 1
            }
        }
        
        return letterSum + exactnessSum
        
    }
    

}
