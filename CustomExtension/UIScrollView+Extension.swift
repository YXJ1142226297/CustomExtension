//
//  UIScrollView+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/10/28.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

//MARK: ----------创建方法-----------
extension UIScrollView {
    public class func creatScrView(pageEnable: Bool = true, bgColor: UIColor = .clear, delegate: AnyObject?) -> UIScrollView {
        let scrView = UIScrollView()
        scrView.isPagingEnabled = pageEnable
        scrView.backgroundColor = bgColor
        scrView.delegate = delegate as? UIScrollViewDelegate
        return scrView
    }
}
