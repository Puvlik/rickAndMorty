//
//  UIColorExtension.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation
import UIKit

extension UIColor {
    func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    var backgroundColor: UIColor {
        return hexStringToUIColor(hex: "#040C1E")
    }

    var cellBackgroundColor: UIColor {
        return hexStringToUIColor(hex: "#262A38")
    }
}
