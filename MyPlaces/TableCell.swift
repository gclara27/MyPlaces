//
//  TableCell.swift
//  MyPlaces
//
//  Created by user145617 on 11/14/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var typeLabel: UILabel!    
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
