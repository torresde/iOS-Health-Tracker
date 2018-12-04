//
//  SetsLogTableViewCell.swift
//  Health Tracker
//
//  Created by David Torres on 11/30/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class SetsLogTableViewCell: UITableViewCell {

    @IBOutlet weak var setsNumberLabel: UILabel!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var lastTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
