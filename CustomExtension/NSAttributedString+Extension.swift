//
//  NSAttributedString.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/23.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

extension NSAttributedString {
    /// 创建富文本
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - subTitle: 副标题
    ///   - font: 标题文本大小
    ///   - subFont: 副标题文本大小
    ///   - color: 标题字体颜色
    ///   - subColor: 副标题字体颜色
    /// - Returns: 富文本
    public class func creatAttStr(title: String, subTitle: String?, font: UIFont, subFont: UIFont?, color: UIColor, subColor: UIColor?) -> NSAttributedString {
        let attStr = NSMutableAttributedString.init(string: title)
        attStr.addAttributes([NSAttributedString.Key.foregroundColor : color], range: NSRange.init(location: 0, length: title.count))
        attStr.addAttributes([NSAttributedString.Key.font : font], range: NSRange.init(location: 0, length: title.count))
        
        if subTitle == nil || subFont == nil || subColor == nil {
            return attStr
        }
        if !title.contains(str: subTitle!) || title == subTitle! {
            return attStr
        }
        let subRange = title.range(of: subTitle!)!
        let subDistance: Int = title.distance(from: title.startIndex, to: subRange.lowerBound)
        
        attStr.addAttributes([NSAttributedString.Key.foregroundColor : subColor!], range: NSRange.init(location: subDistance, length: subTitle!.count))
        attStr.addAttributes([NSAttributedString.Key.font : subFont!], range: NSRange.init(location: subDistance, length: subTitle!.count))
        return attStr
    }
}
