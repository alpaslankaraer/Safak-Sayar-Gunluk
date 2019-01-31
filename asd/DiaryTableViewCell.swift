//
//  DiaryTableViewCell.swift
//  asd
//
//  Created by Alpaslan on 28.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {

    
    // MARK Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diaryTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
