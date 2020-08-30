//
//  PR Box.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct PR_Box: View {
    var category: String
    var prDict: Dictionary<String, Int>
    @State var exerciseNames: [String] = []
    @State var exerciseWeights: [String] = []
    
    var body: some View {
        VStack (spacing: 2) {
            Text(self.category)
                .font(.custom("Nunito-SemiBold", size: 20))
                .padding(.bottom, 6)
            
            ForEach(0..<self.exerciseNames.count, id: \.self) { i in
                    VStack {
                        HStack {
                            Text(self.exerciseNames[i])
                                .font(.custom("Nunito-Regular", size: 17))
                            Spacer()
                            Text(self.exerciseWeights[i])
                                .font(.custom("Nunito-Regular", size: 17))
                        }

                }

            }
            
            
        }
        .padding(12)
        .frame(width: Constants.screenWidth * 0.78)
        .background(Color.white)
        .clipped()
        .shadow(radius: 2, y: 1)
        .onAppear {
            var arrDict = self.getArrFromPRDict()
            self.exerciseNames = arrDict[0]
            self.exerciseWeights = arrDict[1]
        }
    
    }
    
    func getArrFromPRDict() -> [[String]] {
        var exerciseNames: [String] = []
        var exerciseWeights: [String] = []
        for key in self.prDict.keys.sorted() {
            exerciseNames.append(key)
            if self.prDict[key]! < 0 {
                exerciseWeights.append(String("BW"))
            } else {
                exerciseWeights.append("\(self.prDict[key]!) lbs")
            }
            
        }
        return [exerciseNames, exerciseWeights]
    }
    
    
}

struct PR_Box_Previews: PreviewProvider {
    static var previews: some View {
        PR_Box(category: "Chest", prDict: ["Bench Press": 150, "Flys": 90, "Push Ups": 150])
    }
}
