//
//  Lesson+CoreDataProperties.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/28/21.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var lessonType: String?
    @NSManaged public var groups: NSSet?
    
    var lessonTypeStatus: LessonType {
        get {
            return LessonType(rawValue: lessonType!) ?? LessonType.all
        }
        set {
            lessonType = newValue.rawValue
        }
    }

}

// MARK: Generated accessors for groups
extension Lesson {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: Group)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: Group)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}

extension Lesson : Identifiable {

}
