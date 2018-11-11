//
//  ExerciseLogTableViewCell.swift
//  Health Tracker
//
//  Created by David Torres on 11/7/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class ExerciseLogTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseSetsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
