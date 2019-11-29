//
//  CustomUIElements.swift
//  TestStore
//
//  Created by Karl McGeough on 09/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString);   attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    func pinkUnderline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString);   attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
    }
}

