//
//  DateExtension.swift
//  Bookly
//
//  Created by Artem Nazarov on 3/27/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import Foundation

//Examples:
//var date: NSDate
//date = 10.seconds.fromNow
//date = 30.minutes.ago
//date = 2.days.from(someDate)
//date = NSDate() + 3.days
//if dateOne < dateTwo {
//    // dateOne is older than dateTwo
//}
//if dateOne > dateTwo {
//    // dateOne is more recent than dateTwo
//}
//if dateOne <= dateTwo {
//    // dateOne is older than or equal to dateTwo
//}
//if dateOne >= dateTwo {
//    // dateOne is more recent or equal to dateTwo
//}
//if dateOne == dateTwo {
//    // dateOne is equal to dateTwo
//}

extension NSDate: Comparable {
    
}

func + (date: NSDate, timeInterval: TimeInterval) -> NSDate {
    return date.addingTimeInterval(timeInterval)
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    if lhs.compare(rhs as Date) == .orderedSame {
        return true
    }
    return false
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    if lhs.compare(rhs as Date) == .orderedAscending {
        return true
    }
    return false
}

extension TimeInterval {
    var second: TimeInterval {
        return self.seconds
    }
    
    var seconds: TimeInterval {
        return self
    }
    
    var minute: TimeInterval {
        return self.minutes
    }
    
    var minutes: TimeInterval {
        let secondsInAMinute = 60 as TimeInterval
        return self / secondsInAMinute
    }
    
    var day: TimeInterval {
        return self.days
    }
    
    var days: TimeInterval {
        let secondsInADay = 86_400 as TimeInterval
        return self * secondsInADay
    }
    
    var fromNow: NSDate {
        let timeInterval = self
        return NSDate().addingTimeInterval(timeInterval)
    }
    
    func from(date: NSDate) -> NSDate {
        let timeInterval = self
        return date.addingTimeInterval(timeInterval)
    }
    
    var ago: NSDate {
        let timeInterval = self
        return NSDate().addingTimeInterval(-timeInterval)
    }
}
