//  See LICENSE folder for this project’s licensing information.

import Foundation

extension Foundation.Date {
    
    var startOfTheDay: Foundation.Date {
        var components    = self.components
        components.hour   = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)!
    }
    
    var endOfTheDay: Foundation.Date {
        var components    = self.components
        components.hour   = 23
        components.minute = 59
        components.second = 59
        return Calendar.current.date(from: components)!
    }
    
    var firstDayOfTheMonth: Foundation.Date {
        var date: Date?
        var startOfMonth: Date
        var lengthOfMonth: TimeInterval = 0
        Calendar.current.dateInterval(of: .month, start: startOfMonth, interval: &lengthOfMonth, for: self)
        return date!
    }
    
    var firstDayOfPreviousMonth: Foundation.Date {
        return firstDay(false)
    }
    
    var firstDayOfFollowingMonth: Foundation.Date {
        return firstDay(true)
    }
    
    var monthDayAndYearComponents: DateComponents {
        let components: NSCalendar.Unit = [.year, .month, .day]
        return (Calendar.current as NSCalendar).components(components, from: self)
    }
    
    var weekDay: Int {
        return components.weekday!
    }
    
    var numberOfDaysInMonth: Int {
        return (Calendar.current as NSCalendar).range(of: .day, in: .month, for: self).length
    }
    
    var day: Int {
        return components.day!
    }
    
    var month: Int {
        return components.month!
    }
    
    var year: Int {
        return components.year!
    }
    
    var minute: Int {
        return components.minute!
    }
    
    var second: Int {
        return components.second!
    }
    
    var hour: Int {
        return components.hour!
    }
    
    fileprivate var components: DateComponents {
        let calendarUnit = NSCalendar.Unit(rawValue: UInt.max)
        let components   = (Calendar.current as NSCalendar).components(calendarUnit, from: self)
        return components
    }
    
    fileprivate func firstDay(_ followingMonth: Bool) -> Foundation.Date {
        var dateComponent   = DateComponents()
        dateComponent.month = followingMonth ? 1 : -1
        let date            = (Calendar.current as NSCalendar).date(byAdding: dateComponent, to: self, options: NSCalendar.Options(rawValue: 0))
        return date!.firstDayOfTheMonth as Date
    }
    
    static func date(_ day: Int, month: Int, year: Int) -> Foundation.Date {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dayString            = String(format: "%02d", day)
        let monthString          = String(format: "%02d", month)
        let yearString           = String(format: "%04d", year)
        return dateFormatter.date(from: dayString + "/" + monthString + "/" + yearString)!
    }
}
