//
//  Diary.swift
//  asd
//
//  Created by Alpaslan on 28.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import UIKit
import os.log

class Diary: NSObject, NSCoding {
    
    
    var title: String
    var detail: String
    var photo: UIImage?
    var date: NSDate
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("diaries")
    
    
    // MARK Properties
    struct PropertyKey {
        static let title = "title"
        static let photo = "photo"
        static let detail = "detail"
        static let date = "date"
    }
    
    // MARK: Initialization
    
    init?(title: String, detail: String, photo: UIImage?, date: NSDate) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        guard !title.isEmpty || !detail.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
        self.detail = detail
        self.photo = photo
        self.date = date
    }
    
    func encode(with aCoder: NSCoder) {
        //MARK: NSCoding
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(detail, forKey: PropertyKey.detail)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the title for a Diary object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Diary, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        guard let detail = aDecoder.decodeObject(forKey: PropertyKey.detail) as? String else {
            os_log("Unable to decode the detail for a Diary object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? NSDate
        
        self.init(title: title, detail: detail, photo: photo, date: date!)
        
    }
}
