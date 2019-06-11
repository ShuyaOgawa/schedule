//
//  SelectClassTableViewCell.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/05/29.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit

class SelectClassTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var selectClassName: UILabel!
    @IBOutlet weak var classRoomLabel: UILabel!
    @IBOutlet weak var profNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
