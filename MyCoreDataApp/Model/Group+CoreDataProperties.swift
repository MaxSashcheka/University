//
//  Group+CoreDataProperties.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/27/21.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var grade: Int16
    @NSManaged public var name: String?
    @NSManaged public var students: NSSet?

}

// MARK: Generated accessors for students
extension Group {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Student)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Student)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}

extension Group : Identifiable {

}
