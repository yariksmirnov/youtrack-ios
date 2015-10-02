//
//  HexColors.swift
//  Youtack
//
//  Created by Yarik Smirnov on 02/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexRGB: Int, alpha: CGFloat = 1) {
        let rgb = (
            CGFloat((hexRGB & 0xFF0000) >> 16) / 255,
            CGFloat((hexRGB & 0xFF00) >> 8) / 255,
            CGFloat(hexRGB & 0xFF) / 255
        )
        self.init(red: rgb.0, green: rgb.1, blue: rgb.2, alpha: alpha)
    }
}