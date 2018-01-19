//  See LICENSE folder for this project’s licensing information.

import Foundation

class CalendarLogic: Hashable {
    
    var hashValue: Int {
        return baseDate.hashValue
    }
    
    var baseDate: Foundation.Date {
        didSet {
            calculateVisibleDays()
        }
    }
    
    fileprivate lazy var dateFormatter = DateFormatter()
    
    var currentMonthAndYear: NSString {
        dateFormatter.dateFormat = "LLLL yyyy"
        return dateFormatter.string(from: baseDate) as NSString
    }

    var currentMonthDays: [Date]?
    var previousMonthVisibleDays: [Date]?
    var nextMonthVisibleDays: [Date]?
    
    init(date: Foundation.Date) {
        baseDate = date.firstDayOfTheMonth as Date
        calculateVisibleDays()
    }
    
    func retreatToPreviousMonth() {
        baseDate = baseDate.firstDayOfPreviousMonth
    }
    
    func advanceToNextMonth() {
        baseDate = baseDate.firstDayOfFollowingMonth
    }
    
    func moveToMonth(_ date: Foundation.Date) {
        baseDate = date
    }
    
    func isVisible(_ date: Foundation.Date) -> Bool {
        let internalDate = Date(date: date)
        if (currentMonthDays!).contains(internalDate) {
            return true
        } else if (previousMonthVisibleDays!).contains(internalDate) {
            return true
        } else if (nextMonthVisibleDays!).contains(internalDate) {
            return true
        }
        return false
    }
    
    func containsDate(_ date: Foundation.Date) -> Bool {
        let date = Date(date: date)
        let logicBaseDate = Date(date: baseDate)
        if (date.month == logicBaseDate.month) &&
            (date.year == logicBaseDate.year) {
            return true
        }        
        return false
    }
    
    fileprivate var numberOfDaysInPreviousPartialWeek: Int {
        return baseDate.weekDay - 1
    }
    
    fileprivate var numberOfVisibleDaysforFollowingMonth: Int {
        // Traverse to last day of month
        var parts = baseDate.monthDayAndYearComponents
        parts.day = baseDate.numberOfDaysInMonth
        // 7 * 6 = 42 :- 7 columns (7 days in a week) and 6 rows (max 6 weeks in a month)
        return 42 - (numberOfDaysInPreviousPartialWeek + baseDate.numberOfDaysInMonth)
    }
    
    fileprivate var calculateCurrentMonthVisibleDays: [Date] {
        var dates               = [Date]()
        let numberOfDaysInMonth = baseDate.numberOfDaysInMonth
        let component           = baseDate.monthDayAndYearComponents
        for i in 1 ... numberOfDaysInMonth {
            dates.append(Date(day: i, month: component.month!, year: component.year!))
        }
        return dates
    }
    
    fileprivate var calculatePreviousMonthVisibleDays: [Date] {
        var dates               = [Date]()
        let date                = baseDate.firstDayOfPreviousMonth
        let numberOfDaysInMonth = date.numberOfDaysInMonth
        let numberOfVisibleDays = numberOfDaysInPreviousPartialWeek
        let parts               = date.monthDayAndYearComponents
        if (numberOfDaysInMonth - (numberOfVisibleDays - 1)) < numberOfDaysInMonth {
            for i in (numberOfDaysInMonth - (numberOfVisibleDays - 1)) ... numberOfDaysInMonth {
                dates.append(Date(day: i, month: parts.month!, year: parts.year!))
            }
        }
        return dates
    }

    fileprivate var calculateFollowingMonthVisibleDays: [Date] {
        var dates        = [Date]()
        let date         = baseDate.firstDayOfFollowingMonth
        let numberOfDays = numberOfVisibleDaysforFollowingMonth
        let parts        = date.monthDayAndYearComponents
        for i in 1 ... numberOfDays {
            dates.append(Date(day: i, month: parts.month!, year: parts.year!))
        }
        return dates
    }
    
    fileprivate func calculateVisibleDays() {
        currentMonthDays         = calculateCurrentMonthVisibleDays
        previousMonthVisibleDays = calculatePreviousMonthVisibleDays
        nextMonthVisibleDays     = calculateFollowingMonthVisibleDays
    }
}

func ==(lhs: CalendarLogic, rhs: CalendarLogic) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

func <(lhs: CalendarLogic, rhs: CalendarLogic) -> Bool {
    return (lhs.baseDate.compare(rhs.baseDate) == .orderedAscending)
}

func >(lhs: CalendarLogic, rhs: CalendarLogic) -> Bool {
    return (lhs.baseDate.compare(rhs.baseDate) == .orderedDescending)
}
