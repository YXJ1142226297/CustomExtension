//
//  UIButton+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/4/30.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

//MARK: ----------创建方法-----------
extension UIButton {
    public var size: CGSize {
        get {
            self.layoutIfNeeded()
            if self.titleLabel == nil || self.titleLabel!.text == nil {
                return CGSize.zero
            }
            return CGSize.init(width: UILabel.labWidth(self.titleLabel!.text!, font: self.titleLabel!.font, height: height), height: UILabel.labHeight(self.titleLabel!.text!, font: self.titleLabel!.font, width: width))
        }
    }
    
    /// 文字的按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - titleFont: 标题文本尺寸
    ///   - titleColor: 标题颜色
    ///   - bgColor: 背景色
    ///   - obj: 按钮响应对象
    ///   - methord: 按钮事件
    /// - Returns: 按钮
    public class func creatBtn(title: String, titleFont: UIFont, titleColor: UIColor = .black, bgColor: UIColor = .clear, obj: AnyObject?, methord: Selector?) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = titleFont
        btn.backgroundColor = bgColor
        if methord != nil && obj != nil {
            btn.addTarget(obj, action: methord!, for: .touchUpInside)
        }
        return btn
    }
    
    /// 图片按钮
    ///
    /// - Parameters:
    ///   - img: 背景图片
    ///   - selectImg: 选中背景图片
    ///   - obj: 按钮响应对象
    ///   - methord: 按钮事件
    /// - Returns: 按钮
    public class func creatBtn(img: String, selectImg: String?, obj: AnyObject?, methord: Selector?) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: img), for: .normal)
        if selectImg != nil {
            btn.setImage(UIImage.init(named: selectImg!), for: .selected)
        }
        if methord != nil && obj != nil {
            btn.addTarget(obj, action: methord!, for: .touchUpInside)
        }
        return btn
    }
    
    /// 背景图片按钮
    ///
    /// - Parameters:
    ///   - bgImg: 背景图片
    ///   - selectBgImg: 选中背景图片
    ///   - obj: 按钮响应对象
    ///   - methord: 按钮事件
    /// - Returns: 按钮
    public class func creatBtn(bgImg: String, selectBgImg: String?, obj: AnyObject?, methord: Selector?) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setBackgroundImage(UIImage.init(named: bgImg), for: .normal)
        if selectBgImg != nil {
            btn.setBackgroundImage(UIImage.init(named: selectBgImg!), for: .selected)
        }
        if methord != nil && obj != nil {
            btn.addTarget(obj, action: methord!, for: .touchUpInside)
        }
        return btn
    }
    
    /// 倒计时按钮
    ///
    /// - Parameters:
    ///   - title: 重置标题
    ///   - timeOut: 倒计时
    ///   - waitTime: 等待时间
    public func creatBtn(title: String, timeOut: NSInteger, waitTitle: String) {
        let timer = DispatchSource.makeTimerSource()
        timer.setEventHandler {
            if timeOut <= 0 {
                timer.cancel()
                self.setTitle(title, for: .normal)
                self.isUserInteractionEnabled = true
            } else {
                let seconds = timeOut % 60
                self.setTitle("\(seconds)\(waitTitle)", for: .normal)
                self.isUserInteractionEnabled = false
            }
        }
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.resume()
    }
}
