//
//  Exchange_TableViewCell.swift
//  eHealth2
//
//  Created by Yukshing CHOI on 10/6/2017.
//  Copyright © 2017 Yukshing CHOI. All rights reserved.
//

import UIKit

class Exchange_TableViewCell: UITableViewCell, UITextFieldDelegate{ 
    
    @IBOutlet weak var topic_label: UILabel!

    @IBOutlet var title_label: [UILabel]!
    
    @IBOutlet var input_label: [UILabel]!
    
    @IBOutlet weak var input_textfield: UITextField!
    
    @IBOutlet var total_label: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
