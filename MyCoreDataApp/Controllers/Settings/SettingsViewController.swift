//
//  SettingsViewController.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/28/21.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 45, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        title = "Settings"
    }
    
    
    @IBAction func removeAllRecordsHandler(_ sender: Any) {
        let groups = DataManager.shared.fetchGroups()
        for group in groups {
            DataManager.shared.persistentContainer.viewContext.delete(group)
        }
        
        let lessons = DataManager.shared.fetchLessons(withLessonType: LessonType.all)
        for lesson in lessons {
            DataManager.shared.persistentContainer.viewContext.delete(lesson)
        }
        
        DataManager.shared.saveContext()

    }
    
    @IBAction func fillRandomData(_ sender: Any) {
        var model = RandomStudentsModel()
        
        for _ in 0..<Int.random(in: 3..<model.groupsNames.count) {
            let groupName = model.groupsNames.removeFirst()
            var group = DataManager.shared.createGroup(name: groupName, grade: Int.random(in: 1...4))
            
            for _ in 0..<Int.random(in: 3..<model.names.count) {
                let studentName = model.names.randomElement()!
                var student = DataManager.shared.createStudent(name: studentName, identifier: Int.random(in: 0...30000), group: group)
            }
        }
        
        DataManager.shared.saveContext()
    }
    
}

struct RandomStudentsModel {
    
    var names = [
        "Max Sashcheka",
        "Artem Martsev",
        "Nikita Gurski",
        "Roman Pinchuk",
        "Angelina Rin",
        "Naruto",
        "Saske Uchiha",
        "Denis Skurat",
        "Artem Van"
    ]
    
    var groupsNames = [
        "913802",
        "913801",
        "914806",
        "909620",
        "910201",
        "910601",
        "913806",
        "913809"
    ]
    
    
}
