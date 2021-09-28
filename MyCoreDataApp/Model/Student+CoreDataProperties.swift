//
//  Student+CoreDataProperties.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/28/21.
//
//

import Foundation
import CoreData
import UIKit

extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var enterDate: Date?
    @NSManaged public var identifier: Int16
    @NSManaged public var image: UIImage?
    @NSManaged public var isExcellentStudent: Bool
    @NSManaged public var name: String?
    @NSManaged public var group: Group?

}

extension Student : Identifiable {

}
