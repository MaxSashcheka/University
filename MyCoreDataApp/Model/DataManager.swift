//
//  DataManager.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/27/21.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyCoreDataApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Static methods to create Managed objects
    func createGroup(name: String, grade: Int) -> Group {
        let group = Group(context: persistentContainer.viewContext)
        group.name = name
        group.grade = Int16(grade)
        
        return group
    }
    
    func createStudent(name: String, identifier: Int, group: Group) -> Student {
        let student = Student(context: persistentContainer.viewContext)
        student.name = name
        student.identifier = Int16(identifier)
        student.enterDate = Date()
        
        let randomImageIndex = Int.random(in: 0...26)
        let randomImage = UIImage(named: "image\(randomImageIndex)")
        student.image = randomImage
        
        group.addToStudents(student)
        
        return student
    }
    
    func createLesson(title: String, location: String, lessonType: LessonType) -> Lesson {
        let lesson = Lesson(context: persistentContainer.viewContext)
        lesson.title = title
        lesson.location = location
        lesson.lessonTypeStatus = lessonType
        
        return lesson
    }
    
    
    //MARK: - Fetching data
    
    func fetchLessons(withLessonType lessonType: LessonType) -> [Lesson] {
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        
        switch lessonType {
        case .lab:
            fetchRequest.predicate = NSPredicate(format: "lessonType == %@", "lab")

        case .practice:
            fetchRequest.predicate = NSPredicate(format: "lessonType == %@", "practice")
            
        case .lecture:
            fetchRequest.predicate = NSPredicate(format: "lessonType == %@", "lecture")
        default:
            print("Last case is all, but it should not be handled")
        }
        
        var lessons = [Lesson]()
        
        do {
            try lessons = persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return lessons
    }
    
    func fetchGroups(forLesson lesson: Lesson) -> [Group] {

        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(ANY lessons == %@)", lesson)
        var groups = [Group]()
        
        do {
            try groups = persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return groups
        
    }
    
    func fetchGroups() -> [Group] {
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        var groups = [Group]()
        
        do {
            try groups = persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return groups
    }
    
    func fetchStudents(forGroup group: Group) -> [Student] {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        var fetchingStudents = [Student]()
        
        fetchRequest.predicate = NSPredicate(format: "group == %@", group)
        
        do {
            try fetchingStudents = persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return fetchingStudents
    }
    
    func fetchBestStudents(withSortType sortType: SortType) -> [Student] {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        var fetchingStudents = [Student]()
        
        fetchRequest.predicate = NSPredicate(format: "isExcellentStudent == true")
        switch sortType {
        case .date:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "enterDate", ascending: true)]
        case .identifier:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: true)]
        case .name:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        case .none:
            print("no sorting")
        }
        
        do {
            try fetchingStudents = persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return fetchingStudents
    }
    
}

enum SortType {
    case none
    case identifier
    case name
    case date
}

enum LessonType: String {
    case lecture
    case practice
    case lab
    case all
}
