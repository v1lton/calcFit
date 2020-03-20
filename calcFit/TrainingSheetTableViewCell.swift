//
//  TrainingSheetTableViewCell.swift
//  calcFit
//
//  Created by Wilton Ramos on 20/03/20.
//  Copyright © 2020 Wilton Ramos. All rights reserved.
//

import UIKit

class TrainingSheetTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet var exerciseLabel: UILabel!
    @IBOutlet var repetitionLabel: UILabel!
    @IBOutlet var serieLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
