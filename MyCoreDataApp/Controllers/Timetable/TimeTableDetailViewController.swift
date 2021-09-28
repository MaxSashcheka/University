//
//  TimeTableDetailViewController.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/29/21.
//

import UIKit

class TimeTableDetailViewController: UIViewController {
    
    
    @IBOutlet weak var lessonNameTextField: UITextField!
    @IBOutlet weak var lessonLocationTextFIeld: UITextField!
    
    @IBOutlet weak var lessonTypeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create lesson"
    }
    
    @IBAction func saveLessonHandler(_ sender: Any) {
        
        guard let lessonName = lessonNameTextField.text else {
            print("lessonName error")
            return
        }
        
        guard let lessonLocation = lessonLocationTextFIeld.text else {
            print("lessonLocation error")
            return
        }
        
        var lessonType = LessonType.lecture
        switch lessonTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            lessonType = .lecture
        case 1:
            lessonType = .practice
        case 2:
            lessonType = .lab
        default:
            lessonType = .practice
        }
        
        lessonNameTextField.text = ""
        lessonLocationTextFIeld.text = ""
        lessonNameTextField.resignFirstResponder()
        lessonLocationTextFIeld.resignFirstResponder()
        
        DataManager.shared.createLesson(title: lessonName, location: lessonLocation, lessonType: lessonType)
        DataManager.shared.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
