//
//  UserViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 2/12/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit

var balance = 5000
class UserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

}
    override func viewWillAppear(_ animated: Bool) {
        yourBalance.text = "Your balance: \(balance)"
        purchasedBooks.text = String(format: "Books purchased: %d", purchasedLibraryArray.count)
    }


  
    @IBOutlet weak var purchasedBooks: UILabel!

    @IBOutlet weak var yourBalance: UILabel!
   
    
}
