//
//  TimePicker.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/22/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

//
//  HorizontalPicker.swift
//  Big O Fit
//
//  Created by Home on 7/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct TimePickerH: View {
    @Binding var timeValue: [Int]
    let numIncrement: Int
    var fontName: String?
    var fontSize: CGFloat?
    var fontColor: Color?
    var minLimit: Int?
    
    static let increment = 10
    @State var checkAddX = NumPickerH.increment
    @State var checkSubX = -NumPickerH.increment
    
    var body: some View {
        let minString = String(timeValue[0])
        let secString = timeValue[1] < 10 ? "0\(timeValue[1])" : String(timeValue[1])
        
        return Text("\(minString):\(secString)")
            .font(.custom(self.fontName ?? "Nunito-Regular", size: self.fontSize ?? 20))
            .foregroundColor(self.fontColor ?? Color.black)
        .gesture(
            DragGesture()
                .onChanged({ gest in
                    let currentX = Int(gest.location.x - gest.startLocation.x)
                    
                    if currentX > self.checkAddX {
                        self.checkAddX += NumPickerH.increment
                        self.checkSubX += NumPickerH.increment
                        self.timeValue = self.incrementTimeArr(timeArr: self.timeValue, numIncrement: self.numIncrement)
                    } else if currentX < self.checkSubX && (self.timeValue[0] > 0 || self.timeValue[1] > (self.minLimit ?? 0)) {
                        self.checkAddX -= NumPickerH.increment
                        self.checkSubX -= NumPickerH.increment
                        self.timeValue = self.decrementTimeArr(timeArr: self.timeValue, numDecrement: self.numIncrement)
                    }
                })
                .onEnded({ gest in
                    self.checkAddX = NumPickerH.increment
                    self.checkSubX = -NumPickerH.increment
                })
        )
    }
    
    
    func incrementTimeArr(timeArr: [Int], numIncrement: Int) -> [Int] {
        if timeArr[1] + numIncrement >= 60 {
            return [timeArr[0] + 1, (timeArr[1] + numIncrement) % 60]
        }
        return [timeArr[0], timeArr[1] + numIncrement]
    }
    
    func decrementTimeArr(timeArr: [Int], numDecrement: Int) -> [Int] {
        if timeArr[1] - numIncrement < 0 {
            return [timeArr[0] - 1, (timeArr[1] - numIncrement) + 60]
        }
        return [timeArr[0], timeArr[1] - numIncrement]
    }
}

struct TimePickerH_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerH(timeValue: Binding.constant([5, 0]), numIncrement: 5)
    }
}

