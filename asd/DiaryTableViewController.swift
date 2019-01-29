//
//  DiaryTableViewController.swift
//  asd
//
//  Created by Alpaslan on 28.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import UIKit
import os.log

class DiaryTableViewController: UITableViewController {

    // MARK: Properties
    
    var diaries = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved diaries, otherwise load sample data.
        if let savedDiaries = loadDiaries() {
            diaries += savedDiaries
        }
        else {
            // Load the sample data.
            loadSampleDiary()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diaries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DiaryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DiaryTableViewCell else {
            fatalError("The dequeued cell is not an instance of DiaryTableViewCell")
        }
        
        // Fetches the appripriates diary for the data source layout.
        let diary = diaries[indexPath.row]
        
        cell.titleLabel.text = diary.title
        cell.photoImageView.image = diary.photo
        //cell.dateLabel.text = diary.date
        cell.diaryTextLabel.text = diary.detail

        // Configure the cell...

        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            diaries.remove(at: indexPath.row)
            saveDiaries()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let DetailDiaryViewController = segue.destination as? DiaryViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedDiaryCell = sender as? DiaryTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedDiaryCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedDiary = diaries[indexPath.row]
            DetailDiaryViewController.diary = selectedDiary
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    // MARK: Actions
    @IBAction func unwindToDiaryList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DiaryViewController, let diary = sourceViewController.diary {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                diaries[selectedIndexPath.row] = diary
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new diary.
                let newIndexPath = IndexPath(row: diaries.count, section: 0)
                
                diaries.append(diary)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the diaries.
            saveDiaries()
        }
        // Use data from the view controller which initiated the unwind segue
    }
    
    
    
    //MARK: Private Methods
    
    private func loadSampleDiary() {
        let photo = UIImage(named: "backButton")
        let photo2 = UIImage(named: "write")
        let photo3 = UIImage(named: "default")
        
        guard let diary1 = Diary(title: "İlk Gün", detail: "laşjşlsdkşa", photo: photo, date: Date.init() as NSDate) else {
            fatalError("Unable to instantiate diary1")
        }
        guard let diary2 = Diary(title: "İkinci Gün", detail: "Merhaba", photo: photo2, date: Date.init() as NSDate) else {
            fatalError("Unable to instantiate diary2")
        }
        guard let diary3 = Diary(title: "Üçüncü Gün", detail: "kemalkemal", photo: photo3, date: Date.init() as NSDate) else {
            fatalError("Unable to instantiate diary3")
        }
        
        diaries += [diary1, diary2, diary3]
    }
    
    private func saveDiaries() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(diaries, toFile: Diary.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadDiaries() -> [Diary]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Diary.ArchiveURL.path) as? [Diary]
    }

}
