//
//  LibraryTableViewCell.swift
//  Bookly
//
//  Created by Artem Nazarov on 2/13/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var bookAuthor: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var progressImage: UIImageView!
}
