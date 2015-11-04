//
//  Extensions.swift
//  Youtack
//
//  Created by Yarik Smirnov on 04/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0, green: gray/255.0, blue: gray/255.0, alpha: 1.0)
    }
}