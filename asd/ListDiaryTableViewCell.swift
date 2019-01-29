//
//  ListDiaryTableViewCell.swift
//  asd
//
//  Created by Alpaslan on 28.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import Foundation
import UIKit

class ListDiaryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var textL: UILabel!
    @IBOutlet var imageV: UIImageView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listDiaryTableViewCell", for: indexPath)
        cell.textLabel!.text = "Cell Row: \(indexPath.row) Section: \(indexPath.section)"
        
        return cell
    }
    
    
    
    
}
