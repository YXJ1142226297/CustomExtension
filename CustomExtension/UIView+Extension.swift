//
//  UIView+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/5.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

private var CornerRadiusKey = "CornerRadiusKey"

//MARK: ----------创建方法-----------
extension UIView {
    /// 视图
    ///
    /// - Parameter bgColor: 背景色
    /// - Returns: 视图
    public class func creatView(bgColor: UIColor = .clear) -> UIView {
        let view = UIView()
        view.backgroundColor = bgColor
        return view
    }
}
//MARK: ----------视图处理-----------
extension UIView {
    /// 设置圆角
    public var cornerRadius: CGFloat {
        set(value) {
            layer.masksToBounds = true
            layer.cornerRadius = value
            
            objc_setAssociatedObject(self, &CornerRadiusKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &CornerRadiusKey) as! CGFloat
        }
    }
    
    /// 设置边框
    ///
    /// - Parameters:
    ///   - width: 边框尺寸
    ///   - color: 边框颜色
    public func border(width: CGFloat, color: UIColor = .white) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    /// 添加子视图
    ///
    /// - Parameter viewArray: 子视图数组
    public func addChildView(_ viewArray: [UIView]) {
        for view in viewArray {
            if !subviews.contains(view) {
                addSubview(view)
            }
        }
    }
}
//MARK: ----------坐标尺寸-----------
extension UIView {
    public var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    public var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    public var right: CGFloat {
        get {
            return self.left + self.width
        }
    }
    public var bottom: CGFloat {
        get {
            return self.top + self.height
        }
    }
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
}
