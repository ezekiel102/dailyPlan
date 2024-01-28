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
        calendar.timeZone = TimeZone(identifier: "Europe/Moscow")!
        return calendar
    }()
    var year: Int? {
        return Date.calendar.dateComponents([.year], from: self).year
    }
    var month: Int? {
        return Date.calendar.dateComponents([.month], from: self).month
    }
    var day: Int? {
        return Date.calendar.dateComponents([.day], from: self).day
    }
    var hour: Int? {
        return Date.calendar.dateComponents([.hour], from: self).hour
    }
    var minute: Int? {
        return Date.calendar.dateComponents([.minute], from: self).minute
    }
    func dayHours(from data: Date) -> [HourInterval] {
        var hours: [HourInterval] = []
        var date = DateComponents()
        date.year = data.year
        date.month = data.month
        date.day = data.day
        date.hour = 0
        date.minute = 0
        date.second = 0
        let dayBegin = Date.calendar.date(from: date)!.timeIntervalSince1970.rounded()
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
