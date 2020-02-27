//
//  DetailLibraryViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 2/15/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit

var libararyId = 0

class DetailLibraryViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if searchActive{
            bookTitle.text = filteredArrays[libararyId].title
            bookImage.image = filteredArrays[libararyId].image
            
            
        }
        else{
        
        bookTitle.text = purchasedLibraryArray[libararyId].title
        bookImage.image = purchasedLibraryArray[libararyId].image
        
       
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if buttonSetLimitsIsVisible == false {
            limitButtonLayer.isHidden = true
            pagesLeftLabel.isHidden = false}
        else {pagesLeftLabel.isHidden = true}
        if let x = UserDefaults.standard.object(forKey: "didStartProcess") as? Bool{
            if x == true {
                if let x = UserDefaults.standard.object(forKey: "pagesLeft") as? Int {
                    if purchasedLibraryArray[libararyId].inTheMiddleOfReading == true {
                        if x > 0 {
                            pagesLeftLabel.text = "Today left to read: \(x) pages"
                        }
                        else if x == 0 {
                            pagesLeftLabel.text = "You are done for today"
                        }
                        else
                        {
                            pagesLeftLabel.text = "You are \(x * -1) pages ahead of schedule"
                        }
                    }
                    else {pagesLeftLabel.isHidden = true}
                    
                }
            }
            
            
        }
    }
    
  
    @IBAction func backButton(_ sender: Any)
    {
        
        self.dismiss(animated: true, completion: nil)
        searchActive = false

    }
    
    var didSatartProcess = false
    
    @IBOutlet weak var pagesLeftLabel: UILabel!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var limitButtonLayer: UIButton!
    
    @IBOutlet weak var readButtonLayer: UIButton!
    
    @IBAction func setLimitsButton(_ sender: Any)
    {
        
        
    }
    
    let brain = LimitsBrain()
    
    @IBAction func readButton(_ sender: Any)
        
    {
        if let x = UserDefaults.standard.object(forKey: "pagesLeft") as? Int {
            if purchasedLibraryArray[libararyId].inTheMiddleOfReading == true {
                if x > 0 {
                    pagesLeftLabel.text = "Today left to read: \(x) pages"
                }
                else if x < 0
                {
                    pagesLeftLabel.text = "You are \(x * -1) pages ahead of schedule"
                }
            }
            else {pagesLeftLabel.isHidden = true}
            
            didSatartProcess = true
            UserDefaults.standard.set(didSatartProcess, forKey: "didStartProcess")
        }
        
        if UserDefaults.standard.object(forKey: "bookId") as? Int == -1 && purchasedLibraryArray[libararyId].finishedReading == true {
            
            
            pagesReadGenerally = purchasedLibraryArray[libararyId].curentPage
            
            
            let pdfVC = self.storyboard?.instantiateViewController(withIdentifier: "PDVViewController") as! PDFViewController
            
            let prep = UINavigationController(rootViewController: pdfVC)
            self.present(prep, animated: true, completion: nil)
            //self.navigationController?.pushViewController(pdfVC, animated: true)
            
        }
        else if purchasedLibraryArray[libararyId].inTheMiddleOfReading == true{
            pagesReadGenerally = purchasedLibraryArray[libararyId].curentPage
            
            
            let pdfVC = self.storyboard?.instantiateViewController(withIdentifier: "PDVViewController") as! PDFViewController
           
            let prep = UINavigationController(rootViewController: pdfVC)
            self.present(prep, animated: true, completion: nil)
        }
            
            
        else {
            let alert = UIAlertController(title: "Whops!", message: "Set schedule for this book first, or finish reading a pending book.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
            self.present(alert,animated: true,completion: nil)
            
        }
    }
    
    
}
