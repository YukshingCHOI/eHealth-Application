//
//  Calculation_TableViewCell.swift
//  eHealth-App
//
//  Created by Yukshing CHOI on 8/6/2017.
//  Copyright © 2017 Yukshing CHOI. All rights reserved.
//

import UIKit

class Calculation_TableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet var title_label: [UILabel]!
    
    @IBOutlet var input_label: [UILabel]!
    
    @IBOutlet var total_label: [UILabel]!
    
    @IBOutlet weak var input_text_field: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
