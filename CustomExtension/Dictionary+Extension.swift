//
//  Dictionary+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/7.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import Foundation

extension Dictionary {
    /// 词典解密
    public var base64Dic: [String: Any] {
        var resultDic = [String: Any]()
        for (key, value) in self {
            if value is NSNull { resultDic[key as! String] = "" }
            if value is Dictionary {
                dicData(key: key as! String, value: value, resultDic: &resultDic)
            } else if value is Array<Any> {
                arrayData(key: key as! String, value: value, resultDic: &resultDic)
            } else {
                resultDic[key as! String] = (value as! String).FromBase64
            }
        }
        return resultDic
    }
    
    /// 词典类型数据
    private func dicData(key: String, value: Any, resultDic:inout [String: Any]) {
        resultDic[key] = (value as! Dictionary).base64Dic
    }
    
    /// 数组类型数据
    private func arrayData(key: String, value: Any, resultDic:inout [String: Any]) {
        var resultArray = [[String: Any]]()
        for dic in value as! Array<Any> {
            resultArray.append((dic as! Dictionary).base64Dic)
        }
        resultDic[key] = resultArray
    }
}
