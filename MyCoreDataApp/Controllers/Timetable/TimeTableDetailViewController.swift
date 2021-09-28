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
        
    }
    
}
