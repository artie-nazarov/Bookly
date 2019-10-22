//
//  BookDetailViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 2/12/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit
import Firebase

var arrayId = 0



class BookDetailViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if searchActive{
            name.text = filteredArrays[arrayId].title
            bookImage.image = filteredArrays[arrayId].image
            price.text = String(format: "Price: %d", filteredArrays[arrayId].price)
        }
        else{
            name.text = bookLibraryArray[arrayId].title
            bookImage.image = bookLibraryArray[arrayId].image
            price.text = String(format: "Price: %d", bookLibraryArray[arrayId].price)
            
        }
        balanceLabel.text = String(format: "Your balance: %d", balance)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.alpha = 0.0
        darkenedView.alpha = 0.0
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        searchActive = false
    }
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var darkenedView: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBAction func purchaseButton(_ sender: Any)
    {
        if searchActive
        {
            let ind = bookLibraryArray.index(where: {$0.title == searchedTitle})!
            
            let price = bookLibraryArray[ind].price
            if balance >= price {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.darkenedView.alpha = 1.0
                    self.loadingIndicator.alpha = 1.0
                    
                })
                
                loadingIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                let ref = FIRStorage.storage().reference().child("/Books").child(bookLibraryArray[ind].pdfFile)
                
                
                
                let maxSize: Int64 = 10 * 1024 * 1024
                
                ref.data(withMaxSize: maxSize, completion: { (data, error) in
                    
                    if error != nil
                    {
                        print(error!)
                        UIView.animate(withDuration: 0.5, animations: {
                            self.loadingIndicator.stopAnimating()
                            self.loadingIndicator.alpha = 0.0
                            self.darkenedView.alpha = 0.0
                        })
                        let alert = UIAlertController(title: "Download Failed", message: "Check your internet connection or come back later", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                    else
                    {
                        purchasedLibraryArray.insert(bookLibraryArray[ind], at: 0)
                        
                        balance -= bookLibraryArray[ind].price
                        
                        bookLibraryArray.remove(at: ind)
                        
                        let userDefaults = UserDefaults.standard
                        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: purchasedLibraryArray)
                        userDefaults.set(encodedData, forKey: "purchasedArray")
                        UserDefaults.standard.set(balance, forKey: "balance")
                        
                        let encodedData2: Data = NSKeyedArchiver.archivedData(withRootObject: bookLibraryArray)
                        userDefaults.set(encodedData2, forKey: "shopLibrary")
                        
                        userDefaults.synchronize()
                        
                        let encoded = UserDefaults.standard.object(forKey: "purchasedArray") as! Data
                        let array = NSKeyedUnarchiver.unarchiveObject(with: encoded) as! [BookDataStructure]
                        UserDefaults.standard.set(data!, forKey: array.first!.pdfFile)
                        UserDefaults.standard.synchronize()
                        print(array.last!.pdfFile)
                       
                        guard let window = UIApplication.shared.keyWindow else {
                            return
                        }
                        
                        guard let rootViewController = window.rootViewController else {
                            return
                        }
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "tabBar")
                        vc.view.frame = rootViewController.view.frame
                        vc.view.layoutIfNeeded()
                        
                        UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: {
                            window.rootViewController = vc
                        }, completion: { completed in
                            // maybe do something here
                        })
                        
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                    }
                })
                
            }
            else {
                
                let alert = UIAlertController(title: "Whops!", message: "Looks like you don't have enough points", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
            }
            
        }
            
        else if !searchActive
        {
            
            let price = bookLibraryArray[arrayId].price
            if balance >= price {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.darkenedView.alpha = 1.0
                    self.loadingIndicator.alpha = 1.0
                    
                })
                
                loadingIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                let ref = FIRStorage.storage().reference().child("/Books").child(bookLibraryArray[arrayId].pdfFile)
                
                
                let maxSize: Int64 = 10 * 1024 * 1024
                
                ref.data(withMaxSize: maxSize, completion: { (data, error) in
                    
                    if error != nil
                    {
                        print(error!)
                        UIView.animate(withDuration: 0.5, animations: {
                            self.loadingIndicator.stopAnimating()
                            self.loadingIndicator.alpha = 0.0
                            self.darkenedView.alpha = 0.0
                        })
                        let alert = UIAlertController(title: "Download Failed", message: "Check your internet connection or come back later", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                         UIApplication.shared.endIgnoringInteractionEvents()
                    }
                    else
                    {
                        purchasedLibraryArray.insert(bookLibraryArray[arrayId], at: 0)
                        
                        balance -= bookLibraryArray[arrayId].price
                        
                        bookLibraryArray.remove(at: arrayId)
                        
                        let userDefaults = UserDefaults.standard
                        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: purchasedLibraryArray)
                        userDefaults.set(encodedData, forKey: "purchasedArray")
                        UserDefaults.standard.set(balance, forKey: "balance")
                        
                        let encodedData2: Data = NSKeyedArchiver.archivedData(withRootObject: bookLibraryArray)
                        userDefaults.set(encodedData2, forKey: "shopLibrary")
                        
                        userDefaults.synchronize()
                        
                        
                        let encoded = UserDefaults.standard.object(forKey: "purchasedArray") as! Data
                        let array = NSKeyedUnarchiver.unarchiveObject(with: encoded) as! [BookDataStructure]
                        UserDefaults.standard.set(data!, forKey: array.first!.pdfFile)
                        UserDefaults.standard.synchronize()
                        
//                        
//                        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//                        
//                        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabBar")
//                        appDelegate.window?.rootViewController = initialViewController
//                        appDelegate.window?.makeKeyAndVisible()
                        
                        guard let window = UIApplication.shared.keyWindow else {
                            return
                        }
                        
                        guard let rootViewController = window.rootViewController else {
                            return
                        }
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "tabBar")
                        vc.view.frame = rootViewController.view.frame
                        vc.view.layoutIfNeeded()
                        
                        UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: {
                            window.rootViewController = vc
                        }, completion: { completed in
                            // maybe do something here
                        })
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                })
                
            }
            else {
                
                let alert = UIAlertController(title: "Whops!", message: "Looks like you don't have enough points", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}



