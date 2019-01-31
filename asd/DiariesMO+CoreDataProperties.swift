//
//  DiariesMO+CoreDataProperties.swift
//  asd
//
//  Created by Alpaslan on 30.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import Foundation
import CoreData

extension DiariesMO {
    @NSManaged var text: String?
    @NSManaged var title: String?
    @NSManaged var currentDate: NSDate?
    @NSManaged var image: String?
}
