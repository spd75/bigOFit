//
//  CreateProtocol.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/25/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


public protocol CreateScreen {
    var name: String { get set }
    var desc: String { get set }
    var subText: String { get set }
    var emptyPress: Bool { get set }
    
    func checkEmpty() -> Int
    func checkValid() -> Bool
}
