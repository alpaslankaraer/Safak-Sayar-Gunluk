//
//  ProfileTableViewController.swift
//  asd
//
//  Created by Alpaslan on 27.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import Foundation
import UIKit

class ProfileTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // 1
//        guard let identifier = segue.identifier else { return }
//        
//        // 2
//        if identifier == "displaySettings" {
//            print("Transitioning to the Display Note View Controller")
//        }
//        if identifier == "displayPreview" {
//            print("Transitioning to the Display Note View Controller")
//        }
//        if identifier == "displayContact" {
//            print("Transitioning to the Display Note View Controller")
//        }
//    }
    
}
