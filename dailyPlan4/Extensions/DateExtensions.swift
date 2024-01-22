//
//  DateExtensions.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import Foundation

extension Date {
    static var calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        return calendar
    }()
    
    var currentTimestamp: TimeInterval {
        return Date().timeIntervalSince1970.rounded()
    }
    
    var year: Int? {
        return Date.calendar.dateComponents([.year], from: self).year
    }
    
    var month: Int?  {
        return Date.calendar.dateComponents([.month], from: self).month
    }
    
    var day: Int?  {
        return Date.calendar.dateComponents([.day], from: self).day
    }
    
    var hour: Int?  {
        return Date.calendar.dateComponents([.hour], from: self).hour
    }
    
    var minute: Int?  {
        return Date.calendar.dateComponents([.minute], from: self).minute
    }
    
    func toTimestamp(year: Int, month: Int, day: Int, hour: Int, minutes: Int, seconds: Int) -> TimeInterval {
        var date = DateComponents()
        date.year = year
        date.month = month
        date.day = day
        date.hour = hour
        date.minute = minutes
        date.second = seconds
        date.timeZone = TimeZone(identifier: "Europe/Moscow")!
        
        let data = Date.calendar.date(from: date)!
        return data.timeIntervalSince1970.rounded()
    }
    
    func dayTo(to days: Int) -> [Date] {
        var someDays: [Date] = []
        for i in -days...days {
            someDays.append(Date.calendar.date(byAdding: .day, value: i, to: self) ?? self)
        }
        return someDays
    }
    

    func dayHours(from date: Date) -> [HourInterval] {
        var hours: [HourInterval] = []
        let dayBegin = date.toTimestamp(year: date.year!, month: date.month!, day: date.day!, hour: 0, minutes: 0, seconds: 0)
        for i in 0...23 {
            let addHour = HourInterval(
                startHour: dayBegin + 3600 * Double(i),
                endHour: dayBegin + 3600 * Double(i) + 3599
            )
            hours.append(addHour)
        }
        return hours
    }
   
}

struct HourInterval {
    let startHour: TimeInterval
    let endHour: TimeInterval
}
