//
//  Array+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/8.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import Foundation

private let historyFilePath = "/historyFilePath".doc()

extension Array {
    /// 读写历史数据
    public static var historyArray: Array<String> {
        get {
            return NSArray(contentsOfFile: historyFilePath) as? [String] ?? [String]()
        }
        set (newArray) {
            (newArray as NSArray).write(toFile: historyFilePath, atomically: true)
        }
    }
    
    /// 写入数据
    public func frontOrInserObj(item: String) -> [String] {
        var sourceArray = (self as! [String])
        
        if sourceArray.contains(item) {
            sourceArray.remove(at: sourceArray.firstIndex(of: item)!)
            sourceArray.insert(item, at: 0)
        } else {
            sourceArray.append(item)
        }
        return sourceArray
    }
}
