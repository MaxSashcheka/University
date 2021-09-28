//
//  StudentsViewController.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/27/21.
//

import UIKit

class StudentsViewController: UIViewController {

    @IBOutlet weak var studentsTableView: UITableView!
    
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var studentIdentifierTextField: UITextField!
    
    @IBOutlet weak var groupNumberLabel: UILabel!
    
    var group: Group?
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Students"
        
        studentsTableView.delegate = self
        studentsTableView.dataSource = self
        studentsTableView.register(StudentCell.nib(), forCellReuseIdentifier: StudentCell.reuseIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let group = group {
            groupNumberLabel.text = group.name
            students = DataManager.shared.fetchStudents(forGroup: group)
        }
        studentsTableView.reloadData()
    }
    
    
    
    @IBAction func saveHandler(_ sender: Any) {
        guard let studentName = studentNameTextField.text else {
            print("studentNameTextField error")
            return
        }
        
        guard let studentIdentifierText = studentIdentifierTextField.text else {
            print("studentIdentifierTextField error")
            return
        }
        
        if studentName.isEmpty || studentIdentifierText.isEmpty { return }
        

        studentNameTextField.resignFirstResponder()
        studentIdentifierTextField.resignFirstResponder()
        studentNameTextField.text = ""
        studentIdentifierTextField.text = ""
        
        var studentIdentifier = Int(studentIdentifierText)!
        
        if studentIdentifier > Int16.max {
            studentIdentifier = Int(Int16.max)
        }
        
        if let group = group {
            
            let newStudent = DataManager.shared.createStudent(name: studentName, identifier: studentIdentifier, group: group)
            students.append(newStudent)
            let indexPath = IndexPath(row: students.count - 1, section: 0)
            studentsTableView.insertRows(at: [indexPath], with: .left)
            DataManager.shared.saveContext()
        }
        
        
    }
    
}

extension StudentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.reuseIdentifier, for: indexPath) as! StudentCell
        
        let student = students[indexPath.row]
        cell.setup(withStudent: student)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = students[indexPath.row]
        student.isExcellentStudent = !student.isExcellentStudent
        DataManager.shared.saveContext()

        tableView.reloadData()
    }
    
}


