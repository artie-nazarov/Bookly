//
//  SetLimitsViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 3/24/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit

var buttonSetLimitsIsVisible = true


class SetLimitsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var brain = LimitsBrain()
    
    var numsArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if purchasedLibraryArray[libararyId].pageAmount > 500 {
            for i in 1...500 {
                numsArray.append(i)
            }
        }
        else{
            for i in 1...purchasedLibraryArray[libararyId].pageAmount{
                numsArray.append(i)
            }
        }
        bookTitle.text = purchasedLibraryArray[libararyId].title
        totalPageNum.text = "Total number of pages: \(purchasedLibraryArray[libararyId].pageAmount)"
        pageNum.text = "1 page"
        
        tutorialAlert()
        
    }
    
    
   var allowGoing = false
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numsArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        allowGoing = true
        let val = numsArray[row]
        choosenNumber = numsArray[row]
        switch val {
        case 1 : pageNum.text = "\(val) page"
        case let x where x % 100 == 11 : pageNum.text = "\(val) pages"
        case let x where x % 10 == 1 : pageNum.text = "\(val) pages"
        case  2...4 : pageNum.text = "\(val) pages"
        default : pageNum.text = "\(val) pages"
        }
    }
    
    func tutorialAlert() {
        
        let alert = UIAlertController(title: "Setting schedule", message: "Choose the number of pages to read every day.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func boolChanger () {
        
        if buttonSetLimitsIsVisible == true {
            buttonSetLimitsIsVisible = false
        }
        else {buttonSetLimitsIsVisible = true}
    }
    
    var choosenNumber = 0
    
    @IBOutlet weak var pagePickerView: UIPickerView!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var totalPageNum: UILabel!
    
    @IBOutlet weak var pageNum: UILabel!
    
    let library = DetailLibraryViewController()
    
    @IBAction func setAction(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Warning!", message: "After pressing Continue, you will not be able to change the number of pages anymore.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {(action: UIAlertAction) in
            if self.allowGoing{
            if searchActive
            {
                let ind = purchasedLibraryArray.index(where: { $0.title == searchedTitle})!

                self.brain.setValues(total: purchasedLibraryArray[ind].pageAmount, choosen: self.choosenNumber,id:ind)
                self.boolChanger()
                purchasedLibraryArray[ind].inTheMiddleOfReading = true
                purchasedLibraryArray[ind].finishedReading = false
                purchasedLibraryArray[ind].curentPage = 1
            }
            else{
                self.brain.setValues(total: purchasedLibraryArray[libararyId].pageAmount, choosen: self.choosenNumber,id:libararyId)
                self.boolChanger()
                purchasedLibraryArray[libararyId].inTheMiddleOfReading = true
                purchasedLibraryArray[libararyId].finishedReading = false
                purchasedLibraryArray[libararyId].curentPage = 1
               }
            pagesReadGenerally = 1
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: purchasedLibraryArray)
            userDefaults.set(pagesReadGenerally, forKey: "pagesReadGenerally")
            userDefaults.set(encodedData, forKey: "purchasedArray")
            userDefaults.set(self.choosenNumber - 1, forKey: "pagesLeft")
            userDefaults.synchronize()
            self.dismiss(animated: true, completion: nil)
        }
            else
            {
            let alert = UIAlertController(title: "Whops!", message: "Looks like you need to change the number of pages!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem)
        
    {
        self.dismiss(animated: true, completion: nil)
    }
}
