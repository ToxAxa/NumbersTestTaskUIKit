//
//  UIView+Extension.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit

extension UIView {
    
    typealias TapClosure = (UITapGestureRecognizer) -> Void
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: CGColor {
        get {
            return layer.borderColor ?? UIColor.black.cgColor
        }
        set {
            layer.borderColor = newValue
        }
    }
    
    func addTapGR( taps: Int = 1, touches: Int = 1, completion: @escaping TapClosure) {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        tap.numberOfTapsRequired = taps
        tap.numberOfTouchesRequired = touches
        tap.addTarget(self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tap)
        
        Closures.Taps[tap] = completion
        Swizzler.swizzle()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if let completion = Closures.Taps[sender] {
            completion(sender)
        }
    }
    
    private struct Closures {
        static var Taps: [UITapGestureRecognizer: TapClosure] = [:]
    }
    
    private struct Swizzler {
        private static var swizzled = false
        
        static func swizzle() {
            guard !swizzled else {
                return
            }
            swizzled = true
            let UIViewClass: AnyClass? = NSClassFromString("UIView")
            let originalSelector = #selector(UIView.removeFromSuperview)
            let swizzleSelector = #selector(swizzledRemoveFromSuperview)
            if
                let original = class_getInstanceMethod(UIViewClass, originalSelector),
                let swizzle = class_getInstanceMethod(UIViewClass, swizzleSelector)
            {
                method_exchangeImplementations(original, swizzle)
            }
        }
    }
    
    @objc func swizzledRemoveFromSuperview() {
        removeGRFromStorage()
        // This caled the original implementation of the method "removeFromSuperview"
        swizzledRemoveFromSuperview()
    }
    
    func removeGRFromStorage() {
        gestureRecognizers?.forEach { recognizer in
            if let tap = recognizer as? UITapGestureRecognizer {
                Closures.Taps[tap] = nil
            }
        }
    }
}
