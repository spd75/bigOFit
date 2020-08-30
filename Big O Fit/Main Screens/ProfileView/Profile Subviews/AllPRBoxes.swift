//
//  AllPRBoxes.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/29/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct AllPRBoxes: View {
    var allPRCategories: Dictionary<String, Dictionary<String, Int>>
    @State var allCategories: [String] = []
    @State var allCategoriesExerciseInfo: [Dictionary<String, Int>] = []
    
    var body: some View {
        VStack (spacing: 14) {
            ForEach(0..<allCategories.count, id: \.self) { i in
                PR_Box(category: self.allCategories[i], prDict: self.allCategoriesExerciseInfo[i])
            }
        }.onAppear {
            let arrDict = self.getArrFromDict()
            self.allCategories = arrDict[0] as! [String]
            self.allCategoriesExerciseInfo = arrDict[1] as! [Dictionary<String, Int>]
        }
    }
    
    func getArrFromDict() -> [Any] {
        var categories: [String] = []
        var exerciseInfo: [Dictionary<String, Int>] = []
        for key in self.allPRCategories.keys.sorted() {
            categories.append(key)
            exerciseInfo.append(self.allPRCategories[key]!)
        }
        
        return [categories, exerciseInfo]
    }
}

struct AllPRBoxes_Previews: PreviewProvider {
    static var previews: some View {
        AllPRBoxes(allPRCategories: ["Chest": ["Bench Press": 150, "Incline Press": 120], "Arms": ["Dumbell Curls": 35, "Pull Ups": -1], "Legs": ["Back Squat": 100, "Front Squat": 80, "Goblin Squat": 40]])
    }
}
