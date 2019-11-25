//
//  UILable+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/5.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

//MARK: ----------创建方法-----------
extension UILabel {
    /// 文本
    ///
    /// - Parameters:
    ///   - title: 名称
    ///   - textColor: 字体颜色
    ///   - textFont: 字体大小
    ///   - align: 对齐方式
    ///   - bgColor: 背景色
    /// - Returns: 文本
    public class func creatLab(title: String, textColor: UIColor = .black, textFont: UIFont, align: NSTextAlignment, bgColor: UIColor = .clear) -> UILabel {
        let lab = UILabel()
        lab.text = title
        lab.textColor = textColor
        lab.font = textFont
        lab.textAlignment = align
        lab.backgroundColor = bgColor
        return lab
    }
    
    /// 创建富文本
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - subTitle: 副标题
    ///   - font: 标题文本大小
    ///   - subFont: 副标题文本大小
    ///   - color: 标题字体颜色
    ///   - subColor: 副标题字体颜色
    ///   - align: 对齐方式
    ///   - bgColor: 背景色
    /// - Returns: 富文本
    public class func creatLab(title: String, subTitle: String?, font: UIFont, subFont: UIFont?, color: UIColor, subColor: UIColor?, align: NSTextAlignment, bgColor: UIColor = .clear) -> UILabel {
        let lab = UILabel()
        lab.backgroundColor = bgColor
        lab.textAlignment = align
        lab.attributedText = NSAttributedString.creatAttStr(title: title, subTitle: subTitle, font: font, subFont: subFont, color: color, subColor: subColor)
        return lab
    }
    
    /// Lab高度
    ///
    /// - Parameters:
    ///   - title: 文本内容
    ///   - font: 文本大小
    ///   - width: 文本宽度
    /// - Returns: Lab高度
    public class func labHeight(_ title: String, font: UIFont, width: CGFloat) -> CGFloat {
        return (title as NSString).boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).height
    }
    
    /// Lab宽度
    ///
    /// - Parameters:
    ///   - title: 文本内容
    ///   - font: 文本大小
    /// - Returns: 文本宽度
    public class func labWidth(_ title: String, font: UIFont, height: CGFloat) -> CGFloat {
        return (title as NSString).boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).width
    }
}

