//
//  LimitsBrain.swift
//  Bookly
//
//  Created by Artem Nazarov on 3/27/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import Foundation

var pagesReadDaily = 1
var pagesReadGenerally = 1

class LimitsBrain {
    
    var totalNumberOfPages = 0
    
    var pagesChoosen = 0
    
    var daysNeeded = 0
    
    var nextDate: NSDate!
    
    var startingDate: NSDate!
    
    var dailyPoints = 0
    
    var compareNumber = 0
    
    var functionRunning = true
    
    var haveToRead = 0
    
    var bookId = -1
    
    var pagesLeft = 0
    
    var daysOnSchedule = 0
    
    var daysOfSchedule = 0
    
    var scheduleStreak = 0
    
    var daysLeft = 0
    
    var timeMech = Timer()
    
    func setAfterSleep()
    {
        if let w = UserDefaults.standard.object(forKey: "totalNumberOfPages") as? Int{
            totalNumberOfPages = w
        }
        if let w = UserDefaults.standard.object(forKey: "pagesLeft") as? Int{
            pagesLeft = w
        }
        
        if let w = UserDefaults.standard.object(forKey: "bookId") as? Int{
            bookId = w
        }
        
        if let w = UserDefaults.standard.object(forKey: "pagesChoosen") as? Int{
            pagesChoosen = w
        }
        if let e = UserDefaults.standard.object(forKey: "daysNeeded") as? Int{
            daysNeeded = e
        }
        if let r = UserDefaults.standard.object(forKey: "nextDate") as? NSDate{
            nextDate = r
        }
        if let t = UserDefaults.standard.object(forKey: "startingDate") as? NSDate{
            startingDate = t
        }
        if let y = UserDefaults.standard.object(forKey: "dailyPoints") as? Int{
            dailyPoints = y
        }
        if let u = UserDefaults.standard.object(forKey: "compareNumber") as? Int{
            compareNumber = u
        }
        if let i = UserDefaults.standard.object(forKey: "functionRunning") as? Bool{
            functionRunning = i
        }
        if let o = UserDefaults.standard.object(forKey: "haveToRead") as? Int{
            haveToRead = o
        }
        if let o = UserDefaults.standard.object(forKey: "daysOnSchedule") as? Int{
            daysOnSchedule = o
        }
        
        if let o = UserDefaults.standard.object(forKey: "daysOfSchedule") as? Int{
            daysOfSchedule = o
        }
        
        if let o = UserDefaults.standard.object(forKey: "scheduleStreak") as? Int{
            scheduleStreak = o
        }
        
        if let o = UserDefaults.standard.object(forKey: "daysLeft") as? Int{
            daysLeft = o
        }
        
        
        
        
    }
    
    func setValues(total:Int,choosen:Int,id:Int) {
        totalNumberOfPages = total
        pagesChoosen = choosen
        startingDate = NSDate()
        nextDate = startingDate + 1.days
        dailyPoints = pagesChoosen * 2
        haveToRead = pagesChoosen
        bookId = id
        pagesLeft = haveToRead
        UserDefaults.standard.set(pagesLeft, forKey: "pagesLeft")
        UserDefaults.standard.set(haveToRead, forKey: "haveToRead")
        
        
        if totalNumberOfPages == pagesChoosen {daysNeeded = 1}
        else if totalNumberOfPages % pagesChoosen  == 0 {
            daysNeeded = totalNumberOfPages / pagesChoosen
        }
        else {
            daysNeeded = totalNumberOfPages / pagesChoosen + 1
        }
        daysLeft = daysNeeded
        if let o = UserDefaults.standard.object(forKey: "daysOnSchedule") as? Int{
            daysOnSchedule = o
        }
        
        if let o = UserDefaults.standard.object(forKey: "daysOfSchedule") as? Int{
            daysOfSchedule = o
        }
        
        if let o = UserDefaults.standard.object(forKey: "scheduleStreak") as? Int{
            scheduleStreak = o
        }
        
        
        timeMech = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(LimitsBrain.timingFunction), userInfo: nil, repeats: true)
    }
    
    func timerStarter()
    {
        timeMech = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(LimitsBrain.timingFunction), userInfo: nil, repeats: true)
    }
    
    
    @objc func timingFunction() {
        print(totalNumberOfPages)
        if startingDate >= nextDate
        {
            if pagesReadGenerally >= haveToRead {
                balance += dailyPoints
                daysOnSchedule += 1
                scheduleStreak += 1
                print(dailyPoints)
                print("you did it!")
                if haveToRead + pagesChoosen > totalNumberOfPages {
                    dailyPoints = (totalNumberOfPages - haveToRead) * 2
                    haveToRead = totalNumberOfPages
                }
                else{
                    haveToRead += pagesChoosen
                }
            } else {
                daysOfSchedule += 1
                scheduleStreak = 0
                if haveToRead + pagesChoosen > totalNumberOfPages {haveToRead = totalNumberOfPages}
                else{
                    haveToRead += pagesChoosen}
                print("you suck",haveToRead)
            }
            
            nextDate = nextDate + 1.days
            compareNumber += 1
            if compareNumber == daysNeeded {
                functionRunning = false
                timeMech.invalidate()
                purchasedLibraryArray[bookId].inTheMiddleOfReading = false
                buttonSetLimitsIsVisible = true
                purchasedLibraryArray[bookId].finishedReading = true
                bookId = -1
                compareNumber = 0
                
                
                let userDefaults = UserDefaults.standard
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: purchasedLibraryArray)
                userDefaults.set(encodedData, forKey: "purchasedArray")
                UserDefaults.standard.set(bookId, forKey: "bookId")
                userDefaults.synchronize()
                
            }
            daysLeft -= 1
        }
        startingDate = NSDate()
        
        pagesLeft = haveToRead - pagesReadGenerally
        
        
        UserDefaults.standard.set(functionRunning, forKey: "funcRunning")
        UserDefaults.standard.set(compareNumber, forKey: "compareNumber")
        UserDefaults.standard.set(totalNumberOfPages, forKey: "totalNumberOfPages")
        UserDefaults.standard.set(pagesChoosen, forKey: "pagesChoosen")
        UserDefaults.standard.set(pagesLeft, forKey: "pagesLeft")
        UserDefaults.standard.set(daysNeeded, forKey: "daysNeeded")
        UserDefaults.standard.set(nextDate, forKey: "nextDate")
        UserDefaults.standard.set(dailyPoints, forKey: "dailyPoints")
        UserDefaults.standard.set(bookId, forKey: "bookId")
        UserDefaults.standard.set(startingDate, forKey: "startingDate")
        UserDefaults.standard.set(compareNumber, forKey: "compareNumber")
        UserDefaults.standard.set(haveToRead, forKey: "haveToRead")
        UserDefaults.standard.set(balance, forKey: "balance")
        UserDefaults.standard.set(buttonSetLimitsIsVisible, forKey: "buttonSetLimitsIsVisible")
        
        UserDefaults.standard.set(daysOfSchedule, forKey: "daysOfSchedule")
        UserDefaults.standard.set(daysOnSchedule, forKey: "daysOnSchedule")
        UserDefaults.standard.set(scheduleStreak, forKey: "scheduleStreak")
        UserDefaults.standard.set(daysLeft, forKey: "daysLeft")
        
        
        UserDefaults.standard.set(pagesReadGenerally, forKey: "pagesReadGenerally")
        
        UserDefaults.standard.synchronize()
        
        print(pagesLeft)
        print(daysNeeded)
    }
    
}

