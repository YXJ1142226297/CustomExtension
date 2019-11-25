//
//  String+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/6.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    /// 是否包含中文
    ///
    /// - Returns: 包含中文
    public func contentChineseCharacters() -> Bool {
        let inputString = "[\u{4e00}-\u{9fa5}]+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", inputString)
        return predicate.evaluate(with: self)
    }
    
    /// 是否是数字
    ///
    /// - Returns: 是否是纯数字
    public func isNumber() -> Bool {
        let emailRegex: String = "[a-zA-Z]"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    /// 是否是金额
    ///
    /// - Returns: 是否是金额
    public func isValidateMoney() -> Bool {
        let emailRegex: String = "^[0-9]+(\\.[0-9]{1,6})?$"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    /// 是否是手机号
    ///
    /// - Returns: 是否是手机号
    public func isMobilePhone() -> Bool {
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         * 联通：130,131,132,152,155,156,185,186
         * 电信：133,1349,153,180,189,181(增加)
         */
        let MOBILE = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         */
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
        /**
         * 中国联通：China Unicom
         * 130,131,132,152,155,156,185,186
         */
        let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$";
        /**
         * 中国电信：China Telecom
         * 133,1349,153,180,189,181(增加)
         */
        let CT = "^1((33|53|8[019])[0-9]|349)\\d{7}$";
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
        if regextestmobile.evaluate(with: self) || regextestcm.evaluate(with: self) || regextestcu.evaluate(with: self) || regextestct.evaluate(with: self) {
            return true
        }
        return false
    }
    
    /// 是否是校验码
    ///
    /// - Returns: 是否是校验码
    public func isCheckPSD() -> Bool {
        let pattern = "^([0-9]){6}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch: Bool = pred.evaluate(with: self)
        return isMatch;
    }
    
    /// 是否是身份证
    ///
    /// - Returns: 是否是身份证
    public func isIDCard() -> Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch: Bool = pred.evaluate(with: self)
        return isMatch
    }

    /// 插入字符串
    ///
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入位置
    /// - Returns: 结果字符串
    public func insert(content: String, locat: Int) -> String {
        if !(locat < count) { return "操作超出范围" }
        let str1 = subStringTo(index: locat)
        let str2 = subStringFrom(index: locat + 1)
        return str1 + content + str2
    }
    
    /// 截取字符串
    ///
    /// - Parameters:
    ///   - start: 开始位置
    ///   - length: 长度
    /// - Returns: 结果字符串
    public func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = count - start
        }
        let st = index(startIndex, offsetBy:start)
        let en = index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    /// 截取字符串
    ///
    /// - Parameter index: 结束索引
    /// - Returns: 结果字符串
    public func subStringTo(index: Int) -> String {
        let theIndex = self.index(self.startIndex, offsetBy:min(self.count, index))
        return String(self[startIndex...theIndex])
    }
    
    /// 截取字符串
    ///
    /// - Parameter index: 开始索引
    /// - Returns: 结果字符串
    public func subStringFrom(index: Int) -> String {
        let theIndex = self.index(self.endIndex, offsetBy: index - self.count)
        return String(self[theIndex..<endIndex])
    }
    
    /// 手机号加*
    ///
    /// - Parameter number: 手机号
    /// - Returns: 处理后手机号
    public func numberSuitScanf(number: String) -> String {
        let numberString: String = (number as NSString).replacingCharacters(in: NSRange(location: 3, length: 4), with: "****")
        return numberString
    }
    
    /// 去除Emoji表情
    ///
    /// - Returns: 处理后字符串
    public func clearEmoji() -> String {
        do {
            let expression = try NSRegularExpression.init(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]", options: .caseInsensitive)
            return expression.stringByReplacingMatches(in: self, options: .reportProgress, range: NSRange.init(location: 0, length: self.count), withTemplate: "")
        } catch {
            return error.localizedDescription
        }
    }
    
    /// 生成随机字符串
    ///
    /// - Parameter length: 字符串长度
    /// - Returns: 结果字符串
    public static func creatRandomStr(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var resultStr = ""
        
        for _ in 0..<length {
            resultStr.append(letters[letters.index(letters.startIndex, offsetBy: Int(arc4random()) % letters.count)])
        }
        return resultStr
    }
    
    /// 显示HTML文本
    ///
    /// - Parameters:
    ///   - html: 文本内容
    ///   - width: 图片最大宽度
    /// - Returns: 富文本
    public static func showAttributedToHtml(html: String!, width: CGFloat) -> NSAttributedString? {
        let newString = """
        <html>
            <head>
                <style type=\"text/css\">
                    img {
                        max-width:\(width)
                    }
                    * {
                        margin:0; padding:0
                    }
                    p {
                        color : "#999999";
                        font-size : 13px
                    }
                </style>
            </head>
            <body>\(html!)
            </body>
        </html>
        """
        do {
            return try NSMutableAttributedString.init(data: newString.data(using: .unicode)!, options: [.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    /// 是否包含字符串
    ///
    /// - Parameter str: 字符串
    /// - Returns: 是否包含
    public func contains(str: String) -> Bool {
        return range(of: str) != nil
    }
    
    /// 清除字符串空格
    ///
    /// - Returns: 处理后字符
    public func clearSpace() -> String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    /// 反转字符串
    ///
    /// - Returns: 处理后字符串
    public func reverse() -> String {
        return String(self.reversed())
    }
    
    /// 将字符串拆分数组
    ///
    /// - Returns: 拆分后数组
    public func stringToArr() -> [String] {
        let num = count
        if !(num > 0) { return [""] }
        var array: [String] = []
        for i in 0..<num {
            let tempStr: String = self[self.index(self.startIndex, offsetBy: i)].description
            array.append(tempStr)
        }
        return array
    }
    
    /// 字符串数字加颜色
    ///
    /// - Parameters:
    ///   - font: 普通字体
    ///   - numFont: 数字字体
    ///   - color: 普通字体颜色
    ///   - numColor: 数字字体颜色
    ///   - lineSpace: 行间距
    /// - Returns: 处理后字符串
    public func attributeNumber(font: UIFont, numFont: UIFont, color: UIColor, numColor: UIColor, lineSpace: CGFloat?) -> NSMutableAttributedString {
        let AttributedStr = NSMutableAttributedString(string: self, attributes: [.font: font, .foregroundColor: color])
        for i in 0 ..< self.count {
            let char = self.utf8[self.index(self.startIndex, offsetBy: i)]
            if (char > 47 && char < 58) {
                AttributedStr.addAttribute(.foregroundColor, value: numColor, range: NSRange(location: i, length: 1))
                AttributedStr.addAttribute(.font, value: numFont, range: NSRange(location: i, length: 1))
            }
        }
        if let space = lineSpace {
            let paragraphStyleT = NSMutableParagraphStyle()
            paragraphStyleT.lineSpacing = space
            AttributedStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyleT, range: NSMakeRange(0,self.count))
        }
        return AttributedStr
    }
    
    /**
     将当前字符串拼接到cache目录后面
     */
    public func cache() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    public func doc() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    public func tmp() -> String {
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /// 字符串首字符
    public var first: String {
        get { return String(self[startIndex]) }
    }
    
    /// 字符串尾字符
    public var last: String {
        get { return String(self[index(before: self.endIndex)]) }
    }
    
    /// MD5值
    public var MD5: String {
        let cString = self.cString(using: String.Encoding.utf8)
        let length = CUnsignedInt(
            self.lengthOfBytes(using: String.Encoding.utf8)
        )
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(
            capacity: Int(CC_MD5_DIGEST_LENGTH)
        )
        CC_MD5(cString!, length, result)
        
        return String(format:
            "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15])
    }
    
    /// BASE64编码
    public var ToBase64: String? {
        if let data = data(using: String.Encoding.utf8) {
            return data.base64EncodedString()
        }
        return ""
    }
    
    /// BASE64解码
    public var FromBase64: String? {
        if let data = Data(base64Encoded: self.clearSpace()) {
            return String(data: data, encoding: String.Encoding.utf8)
        }
        return ""
    }
    
    /// GB2312编码
    public var ToGB2312: String? {
        let enc = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0632))
        return (self as NSString).addingPercentEscapes(using: enc.rawValue)
    }
    
    /// GB2312解码
    public var FromGB2313: String? {
        let enc = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0632))
        return (self as NSString).replacingPercentEscapes(using: enc.rawValue)
    }
}
