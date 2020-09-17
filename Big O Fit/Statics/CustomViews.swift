//
//  CustomViews.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation
import SwiftUI

/** This file provides a series of very minor views used across the app that weren't complex or significant
    enough to be placed in their own files.
 */


enum fontStyle {
    case light, bold, semibold, regular
}


struct NunitoTitle: View {
    var text: String
    var size: CGFloat?
    var style: fontStyle?
    var pHorizontal: CGFloat?
    var pTop: CGFloat?
    var pBottom: CGFloat?
    
    
    var body: some View {
        var fontName = "Nunito-SemiBold"
        
        if style == .light {
            fontName = "Nunito-Light"
        } else if style == .regular {
            fontName = "Nunito-Regular"
        } else if style == .bold {
            fontName = "Nunito-Bold"
        }
        
        return HStack {
            Text(text)
                .font(.custom(fontName, size: size ?? 20))
            Spacer()
        }
        .padding(.horizontal, pHorizontal ?? 24)
        .padding(.top, pTop ?? 12)
        .padding(.bottom, pBottom ?? 5)
            

    }
    
    
}

struct CustomViews_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
