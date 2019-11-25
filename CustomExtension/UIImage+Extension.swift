//
//  UIImage+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/23.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

extension UIImage {
    /// 水印位置
    public enum WaterMarkCorner{
        case TopLeft
        case TopRight
        case BottomLeft
        case BottomRight
    }
    
    /// 颜色生成图片
    ///
    /// - Parameter color: 颜色值
    /// - Returns: 返回图片
    public class func creatImg(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize.init(width: 1, height: 1))
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect.init(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image;
    }
    
    /// 图片设置圆角
    ///
    /// - Parameters:
    ///   - corners: 圆角位置
    ///   - radius: 圆角尺寸
    /// - Returns: 处理后图片
    public func roundImage(corners: UIRectCorner = UIRectCorner.allCorners, radius: CGSize) -> UIImage? {
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        let bezierPath = UIBezierPath(roundedRect: imageRect,
                                      byRoundingCorners: corners,
                                      cornerRadii: radius)
        bezierPath.close()
        bezierPath.addClip()
        self.draw(in: imageRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 将图片按比例调整
    ///
    /// - Parameter targetSize: 新的尺寸
    /// - Returns: 处理后图片
    public func scaleTo(targetSize: CGSize) -> UIImage? {
        let srcSize = self.size
        if __CGSizeEqualToSize(srcSize, targetSize) {
            return self
        }
        
        let scaleRatio = targetSize.width / srcSize.width
        var dstSize = CGSize(width: targetSize.width, height: targetSize.height)
        let orientation = self.imageOrientation
        var transform = CGAffineTransform.identity
        switch orientation {
        case .up:
            transform = CGAffineTransform.identity
        case .upMirrored:
            transform = CGAffineTransform(translationX: srcSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        case .down:
            transform = CGAffineTransform(translationX: srcSize.width, y: srcSize.height)
            transform = transform.scaledBy(x: 1.0, y: CGFloat(M_PI))
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0.0, y: srcSize.height)
            transform = transform.scaledBy(x: 1.0, y: -1.0)
        case .leftMirrored:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: srcSize.height, y: srcSize.width)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            transform = transform.rotated(by: CGFloat(3.0) * CGFloat(M_PI_2))
        case .left:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: 0.0, y: srcSize.width)
            transform = transform.rotated(by: CGFloat(3.0) * CGFloat(M_PI_2))
        case .rightMirrored:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            transform = transform.rotated(by:  CGFloat(M_PI_2))
        default:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: srcSize.height, y: 0.0)
            transform = transform.rotated(by:  CGFloat(M_PI_2))
        }
        
        UIGraphicsBeginImageContextWithOptions(dstSize, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        if orientation == UIImage.Orientation.right || orientation == UIImage.Orientation.left {
            context?.scaleBy(x: -scaleRatio, y: scaleRatio)
            context?.translateBy(x: -srcSize.height, y: 0)
        }
        else {
            context?.scaleBy(x: scaleRatio, y: -scaleRatio)
            context?.translateBy(x: 0, y: -srcSize.height)
        }
        context?.concatenate(transform)
        guard let cgImage = self.cgImage else {
            return nil
        }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: srcSize.width, height: srcSize.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 图片压缩
    ///
    /// - Parameter originalImg: 原始图片
    /// - Returns: 处理后图片
    public class func resizeImage(originalImg:UIImage) -> UIImage? {
        let width = originalImg.size.width
        let height = originalImg.size.height
        let scale = width / height
        var sizeChange = CGSize()
        
        if width <= 1280 && height <= 1280 {
            //a,图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
            return originalImg
        } else if width > 1280 || height > 1280 { //b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
            if scale <= 2 && scale >= 1 {
                let changedWidth:CGFloat = 1280
                let changedheight:CGFloat = changedWidth / scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            } else if scale >= 0.5 && scale <= 1 {
                let changedheight:CGFloat = 1280
                let changedWidth:CGFloat = changedheight * scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
            } else if width > 1280 && height > 1280 {
                //c,宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280
                if scale > 2 {
                    //高的值比较小
                    let changedheight:CGFloat = 1280
                    let changedWidth:CGFloat = changedheight * scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                } else if scale < 0.5 {
                    //宽的值比较小
                    let changedWidth:CGFloat = 1280
                    let changedheight:CGFloat = changedWidth / scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                }
            } else {
                //d,宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
                return originalImg
            }
        }
        
        UIGraphicsBeginImageContext(sizeChange)
        originalImg.draw(in: CGRect.init(x: 0, y: 0, width: sizeChange.width, height: sizeChange.height))
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImg
    }
    
    /// 字符串创建二维码
    ///
    /// - Parameters:
    ///   - QRCodeString: 字符串
    ///   - logo: Logo
    ///   - size: 尺寸
    /// - Returns: 二维码图片
    public static func generateQRImage(QRCodeString: String, logo: UIImage?, size: CGSize = CGSize(width: 50, height: 50)) -> UIImage? {
        guard let data = QRCodeString.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        let imageFilter = CIFilter(name: "CIQRCodeGenerator")
        imageFilter?.setValue(data, forKey: "inputMessage")
        imageFilter?.setValue("H", forKey: "inputCorrectionLevel")
        let ciImage = imageFilter?.outputImage
        
        // 创建颜色滤镜
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        
        // 返回二维码图片
        let qrImage = UIImage(ciImage: (colorFilter?.outputImage)!)
        let imageRect = size.width > size.height ?
            CGRect(x: (size.width - size.height) / 2, y: 0, width: size.height, height: size.height) :
            CGRect(x: 0, y: (size.height - size.width) / 2, width: size.width, height: size.width)
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        qrImage.draw(in: imageRect)
        if logo != nil {
            let logoSize = size.width > size.height ?
                CGSize(width: size.height * 0.25, height: size.height * 0.25) :
                CGSize(width: size.width * 0.25, height: size.width * 0.25)
            logo?.draw(in: CGRect(x: (imageRect.size.width - logoSize.width) / 2, y: (imageRect.size.height - logoSize.height) / 2, width: logoSize.width, height: logoSize.height))
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 图片压缩
    ///
    /// - Parameter maxCount: 压缩后最大尺寸
    /// - Returns: 图片数据
    public func imageZip(maxCount: NSInteger) -> Data {
        var data = jpegData(compressionQuality: 1)!
        
        if data.count <= maxCount {
            return data
        } else {
            data = jpegData(compressionQuality: CGFloat(maxCount) / CGFloat(data.count))!
            return data
        }
    }
    
    /// 给图片添加水印
    ///
    /// - Parameters:
    ///   - waterMarkText: 水印内容
    ///   - corner: 水印位置
    ///   - margin: 水印位置
    ///   - waterMarkTextColor: 水印字体颜色
    ///   - waterMarkTextFont: 水印字体大小
    ///   - backgroundColor: 水印背景色
    /// - Returns: 结果图片
    public func waterMarkedImage(waterMarkText: String, corner: WaterMarkCorner = .BottomRight, margin: CGPoint = CGPoint(x: 20, y: 20), waterMarkTextColor: UIColor = .white, waterMarkTextFont: UIFont, backgroundColor:UIColor = .clear) -> UIImage {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:waterMarkTextColor,
                              NSAttributedString.Key.font:waterMarkTextFont]
        let textSize = NSString(string: waterMarkText).size(withAttributes: textAttributes)
        var textFrame = CGRect.init(x: 0, y: 0, width: textSize.width, height: textSize.height)
        
        let imageSize = self.size
        switch corner{
        case .TopLeft:
            textFrame.origin = margin
        case .TopRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin.x, y: margin.y)
        case .BottomLeft:
            textFrame.origin = CGPoint(x: margin.x, y: imageSize.height - textSize.height - margin.y)
        case .BottomRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin.x,
                                       y: imageSize.height - textSize.height - margin.y)
        }
        
        UIGraphicsBeginImageContext(imageSize)
        self.draw(in: CGRect.init(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        NSString(string: waterMarkText).draw(in: textFrame, withAttributes: textAttributes)
        
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkedImage!
    }
}
