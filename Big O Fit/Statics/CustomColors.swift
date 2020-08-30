//
//  CustomColors.swift
//  Big O Fit
//
//  Created by Home on 7/12/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation
import SwiftUI

/// Custom colors provides a series of static Color constants that are used all across the application.
class CustomColors {
    public static let darkishred: Color = Color(red: 217/255, green: 94/255, blue: 106/255, opacity: 1.0)
    public static let brightishGreen: Color = Color(red: 89/255, green: 201/255, blue: 165/255, opacity: 1)
    public static let grayBackground: Color = Color(red: 115/255, green: 115/255, blue: 115/255, opacity: 0.07)
    public static let darkGrayBackground: Color = Color(red: 115/255, green: 100/255, blue: 100/255, opacity: 1.0)
    public static let darkishredUI: UIColor = UIColor.init(displayP3Red: 200/255, green: 15/255, blue: 40/255, alpha: 0.7)
    public static let textViewGray: UIColor = UIColor.init(displayP3Red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0)
    public static let transparentWhite: Color = Color(red: 1, green: 1, blue: 1, opacity: 0.75)

}


struct CustomColors_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
