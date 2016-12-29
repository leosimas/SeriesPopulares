//
//  File.swift
//  Series Populares
//
//  Created by SoSucesso on 12/29/16.
//  Copyright © 2016 Leonardo Simas. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        let charCount = cString.characters.count
        if (charCount != 6
            && charCount != 8 ) {
            return UIColor.gray
        }
        
        var argbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&argbValue)
        
        var alphaValue : CGFloat? = nil
        if ( charCount == 8 ) {
            alphaValue = CGFloat((argbValue & 0xFF000000) >> 24) / 255.0
        } else {
            alphaValue = CGFloat(1.0)
        }
        
        return UIColor(
            red: CGFloat((argbValue & 0x00FF0000) >> 16) / 255.0,
            green: CGFloat((argbValue & 0x0000FF00) >> 8) / 255.0,
            blue: CGFloat(argbValue & 0x000000FF) / 255.0,
            alpha: alphaValue!
        )
    }
}
