//
//  CreateProtocol.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/25/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

/** CreateScreen is used to provide consistent fields and functions for both the CreateRoutine and CreateExercise ScreenViews.
 
    Fields:
        - name: the string variable which binds to the name TextField and determines the routine/exercise name
        - desc: the string variable which binds to the description TextField and determines the routine/exercise description
        - subText: the text displayed in the subtext view
        - emptyPress: tracks whether the user pressed "create" when a certain condition wasn't met
 
    Functions:
        - checkEmpty(): a function which returns true if the name and description text fields are empty and false otherwise.
        - checkValid(): a function which returns true if the current information added to the ScreenView is valid to create a new exercise/routine and false otherwise.
 */

public protocol CreateScreen {
    var name: String { get set }
    var desc: String { get set }
    var subText: String { get set }
    var emptyPress: Bool { get set }
    
    func checkEmpty() -> Int
    func checkValid() -> Bool
}
