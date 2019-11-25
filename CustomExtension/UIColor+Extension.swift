//
//  UIColor+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/4/30.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

extension UIColor {
    /// 随机色
    ///
    /// - Returns: 色值
    public class func randomColor() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 1)
    }
    
    /// 色值字符
    ///
    /// - Parameter colorStr: 色值字符串
    /// - Returns: 色值
    public class func colorWithHexString(_ colorStr: String!) -> UIColor {
        var color = colorStr.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if color.length < 6 {return .clear}
        if color.hasPrefix("0X") {
            color = color.substring(from: 2) as NSString
        }
        if color.hasPrefix("#") {
            color = color.substring(from: 1) as NSString
        }
        if color.length != 6 {
            return UIColor.clear
        }
        
        var range = NSRange()
        range.length = 2
        
        range.location = 0
        let rStr = color.substring(with: range)
        range.location = 2
        let gStr = color.substring(with: range)
        range.location = 4
        let bStr = color.substring(with: range)
        
        var r :UInt32 = 0x0
        var g :UInt32 = 0x0
        var b :UInt32 = 0x0
        Scanner.init(string: rStr).scanHexInt32(&r)
        Scanner.init(string: gStr).scanHexInt32(&g)
        Scanner.init(string: bStr).scanHexInt32(&b)
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
}
