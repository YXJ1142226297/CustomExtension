//
//  UITextView+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/10/26.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

//MARK: ----------创建方法-----------
extension UITextView {
    /// 文本域
    ///
    /// - Parameters:
    ///   - canEdit: 是否可以编辑
    ///   - canScr: 是否可滚动
    ///   - bgColor: 背景色
    ///   - delegate: 代理
    /// - Returns: 文本域
    public class func creatTextView(canEdit: Bool = false, canScr: Bool = false, bgColor: UIColor = .clear, delegate: AnyObject?) -> UITextView {
        let textView = UITextView()
        textView.isEditable = canEdit
        textView.isScrollEnabled = canScr
        textView.backgroundColor = bgColor
        textView.delegate = delegate as? UITextViewDelegate
        return textView
    }
}
