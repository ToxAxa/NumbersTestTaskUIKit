//
//  UIColor+Extension.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit

extension UIColor {
    
    @nonobjc static var blueButtonBackgroundColor = UIColor.rgb(0, 122, 255)
    
    static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0
        )
    }
}

//extension String {
//
//    func strstr(needle: String, beforeNeedle: Bool = false) -> String? {
//        guard let range = self.range(of: needle) else { return nil }
//
//        if beforeNeedle {
//            return self.substring(to: range.lowerBound)
//        }
//
//        return self.substring(from: range.upperBound)
//    }
//
//}
