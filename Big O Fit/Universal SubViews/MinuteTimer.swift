//
//  Timer.swift
//  Big O Fit
//
//  Created by Home on 8/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct MinuteTimer: View {
    @ObservedObject var timer: FlexTimer
    
    var fontName: String?
    var fontSize: CGFloat?
    var fontColor: Color?
    
    
    var body: some View {
        return Text("\(self.timer.minutesVis):\(self.timer.secondsVis)")
                    .font(.custom(fontName ?? "Nunito-Regular", size: fontSize ?? 20))
                    .foregroundColor(fontColor ?? Color.black)
        }

    
}

struct MinuteTimer_Previews: PreviewProvider {
    static var previews: some View {
        MinuteTimer(timer: FlexTimer(hours: 0, minutes: 0, seconds: 30))
    }
}
