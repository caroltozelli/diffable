//
//  UIColor+Randow.swift
//  DiffableDataSource
//
// 
//

import UIKit

extension CGFloat {
    static func randow() -> CGFloat {
        CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randow() -> UIColor {
        UIColor(red: .randow(),
                green: .randow(),
                blue: .randow(),
                alpha: 1.0)
    }
}
