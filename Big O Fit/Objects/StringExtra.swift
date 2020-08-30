//
//  Levenshtein.swift
//  Big O Fit
//
//  Created by Home on 7/28/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


extension String {
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

extension String {
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
        
        let primaryDist = organizedDistances[0]

        for dist in organizedDistances {
            if dist > primaryDist - 10 {
                organizedWords += distanceToWords[dist]!
            }
            
        }

        return organizedWords
    }

}
