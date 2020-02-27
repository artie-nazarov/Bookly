//
//  ShopTableViewCell.swift
//  Bookly
//
//  Created by Artem Nazarov on 1/24/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookName: UILabel!
    
    @IBOutlet weak var bookAuthor: UILabel!
    
    @IBOutlet weak var bookPrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
