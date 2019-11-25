//
//  UIImageView+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/5.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

//MARK: ----------创建方法-----------
extension UIImageView {
    /// 图片视图
    ///
    /// - Parameter imgName: 图片名称
    /// - Returns: 图片视图
    public class func creatImgView(imgName: String) -> UIImageView {
        let imgView = UIImageView.init(image: UIImage.init(named: imgName))
        return imgView
    }
}
