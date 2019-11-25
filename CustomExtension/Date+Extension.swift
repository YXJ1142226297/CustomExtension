//
//  Date+Extension.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/11/22.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

extension Date {
    /// 当前日期
    public func currentDate(format: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: Date())
    }
    
    /// 年
    public func year() -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.year!
    }
    /// 月
    public func month() -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.month!
        
    }
    /// 日
    public func day() -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.day!
        
    }
    /// 周
    public func weekDay() -> Int {
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval / 86400)
        let weekday = ((days + 4) % 7 + 7) % 7
        return weekday == 0 ? 7 : weekday
    }
    
    /// 是否是今天
    public func isToday() -> Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    
    /// 日期转日期字符串
    public static func dateToDateString(date:Date, dateFormat:String) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        
        let date = formatter.string(from: date)
        return date
    }
    
    /// 日期字符串转日期
    public static func dateStringToDate(dateStr: String, dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: dateStr)
        return date!
    }
    
    /// 计算天数差
    public static func dateDifference(dateA: Date, dateB: Date) -> Double {
        let interval = dateA.timeIntervalSince(dateB)
        return interval / 86400
    }
    
    /// 比较时间先后
    public static func compareOneDay(oneDay: Date, anotherDay: Date) -> Int {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let oneDayStr:String = dateFormatter.string(from: oneDay)
        let anotherDayStr:String = dateFormatter.string(from: anotherDay)
        let dateA = dateFormatter.date(from: oneDayStr)
        let dateB = dateFormatter.date(from: anotherDayStr)
        let result:ComparisonResult = (dateA?.compare(dateB!))!
        
        if (result == ComparisonResult.orderedDescending) {
            return 1
        }
        else if (result == ComparisonResult.orderedAscending) {
            return 2
        }
        else {
            return 0
        }
    }
    
    /// 获取当前时间戳
    public static func getStamp() -> Int {
        let date = Date()
        let timeInterval:Int = Int(date.timeIntervalSince1970)
        return timeInterval
    }
    
    /// 刚刚,几分钟前,几小时前,天前,月前,年前
    public func compareCurrentTime(dateStr: String, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = dateFormat
        let timeDate = dateFormatter.date(from: dateStr)!
        let currentDate = NSDate()
        
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        
        var temp:Double = 0
        var result:String = ""
        if timeInterval / 60 < 1 {
            result = "刚刚"
        } else if (timeInterval / 60) < 60 {
            temp = timeInterval / 60
            result = "\(Int(temp))分钟前"
        } else if timeInterval / 60 / 60 < 24 {
            temp = timeInterval / 60 / 60
            result = "\(Int(temp))小时前"
        } else if timeInterval / (24 * 60 * 60) < 30 {
            temp = timeInterval / (24 * 60 * 60)
            result = "\(Int(temp))天前"
        } else if timeInterval / (30 * 24 * 60 * 60)  < 12 {
            temp = timeInterval / (30 * 24 * 60 * 60)
            result = "\(Int(temp))个月前"
        } else{
            temp = timeInterval / (12 * 30 * 24 * 60 * 60)
            result = "\(Int(temp))年前"
        }
        return result
    }
    
    /// 获取日期前后多少天的数据 (年,月,日,周)
    public static func getTotalDate(date: Date, length: NSInteger, reduce: Bool) -> [(String, String, String, String)] {
        var year = date.year()
        var month = date.month()
        var day = date.day()
        var week = date.weekDay()
        
        var resultArray = [(String, String, String, String)]()
        
        reduce ? reduceDateADD(year: &year, month: &month, day: &day, week: &week, length: length, resultArray: &resultArray) : coverDateADD(year: &year, month: &month, day: day, week: &week, length: length, resultArray: &resultArray)
        return resultArray
    }
    
    private static func coverDateADD(year: inout Int, month: inout Int, day: Int, week: inout Int, length: Int, resultArray: inout [(String, String, String, String)]) {
        var monthDayLength = 31
        
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            monthDayLength = 31
            break
        case 4, 6, 9, 11:
            monthDayLength = 30
            break
        case 2:
            if (year % 100 != 0 && year % 4 == 0) || (year % 100 == 0 && year % 400 == 0) {
                monthDayLength = 29
            } else {
                monthDayLength = 28
            }
            break
        default: break
        }
        
        for index in day...monthDayLength {
            resultArray.append(("\(year)", "\(month)", "\(index)", "\(week)"))
            
            week += 1
            week = week == 7 ? 0 : week
            if resultArray.count >= length { return }
        }
        
        month += 1
        if month == 13 {
            month = 1
            year += 1
        }
        
        coverDateADD(year: &year, month: &month, day: 1, week: &week, length: length, resultArray: &resultArray)
    }
    
    private static func reduceDateADD(year: inout Int, month: inout Int, day: inout Int, week: inout Int, length: Int, resultArray: inout [(String, String, String, String)]) {
        for index in (1...day).reversed() {
            resultArray.append(("\(year)", "\(month)", "\(index)", "\(week)"))
            
            week -= 1
            week = week == -1 ? 6 : week
            if resultArray.count >= length { return }
        }
        
        month -= 1
        if month == 0 {
            year -= 1
            month = 12
        }
        
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            day = 31
            break
        case 4, 6, 9, 11:
            day = 30
            break
        case 2:
            if (year % 100 != 0 && year % 4 == 0) || (year % 100 == 0 && year % 400 == 0) {
                day = 29
            } else {
                day = 28
            }
            break
        default: break
        }
        
        reduceDateADD(year: &year, month: &month, day: &day, week: &week, length: length, resultArray: &resultArray)
    }
}


