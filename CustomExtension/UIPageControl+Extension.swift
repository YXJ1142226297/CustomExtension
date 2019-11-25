//
//  UIPageControl+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/20.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

extension UIPageControl {
    /// 页码控制器
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - selectColor: 选中颜色
    /// - Returns: 页码控制器
    public class func creatPageControl(color: UIColor = .white, selectColor: UIColor = .white) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = color
        pageControl.currentPageIndicatorTintColor = selectColor
        pageControl.hidesForSinglePage = true
        return pageControl
    }
}
