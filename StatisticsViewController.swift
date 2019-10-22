//
//  StatisticsViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 4/4/17.
//  Copyright © 2017 APPSkill. All rights reserved.


import UIKit

class StatisticsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var numBR = 0

        if let o = UserDefaults.standard.object(forKey: "daysOnSchedule") as? Int{
            daysOnSchedule.text = "Days on schedule: \(o)"
        }
        
        if let o = UserDefaults.standard.object(forKey: "daysOfSchedule") as? Int{
            daysOfSchedule.text = "Days off schedule: \(o)"
        }
        
        if let o = UserDefaults.standard.object(forKey: "scheduleStreak") as? Int{
            onSchedStreak.text = "On schedule streak: \(o)"
        }
        
        if let o = UserDefaults.standard.object(forKey: "daysLeft") as? Int{
            daysToReadTheCurrentBook.text = "Days to read curent book: \(o)"
        }
        
        for i in 0..<purchasedLibraryArray.count {
            if purchasedLibraryArray[i].finishedReading {
                numBR += 1
            }
        }
        
        booksRead.text = "Books read: \(numBR)"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var booksRead: UILabel!  //done
    
    @IBOutlet weak var daysOnSchedule: UILabel! //done
    
    @IBOutlet weak var daysOfSchedule: UILabel! //done
    
    @IBOutlet weak var onSchedStreak: UILabel! //done
    
    @IBOutlet weak var daysToReadTheCurrentBook: UILabel!
    
    
}
