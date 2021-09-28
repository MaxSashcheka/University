//
//  ViewController.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/27/21.
//

import UIKit

class GroupsViewController: UIViewController {

    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var gradePickerSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        groups = DataManager.fetchGroups()
        
        setupNavigationBar()
    }

    @IBAction func saveHandler(_ sender: Any) {
        guard let groupName = groupNameTextField.text else {
            print("groupNameTextField error")
            return
        }
        let groupGrade = gradePickerSegmentedControl.selectedSegmentIndex
        
        groupNameTextField.resignFirstResponder()
        
        groupNameTextField.text = ""
        gradePickerSegmentedControl.selectedSegmentIndex = 0
        
        let newGroup = DataManager.createGroup(name: groupName, grade: groupGrade)
        groups.append(newGroup)
        let indexPath = IndexPath(row: groups.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        DataManager.shared.saveContext()
        
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Groups"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward")!
        navigationController?.navigationBar.tintColor = .black
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if groups.count != 0 {
            return "Click on cell to open students screen"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentsViewController = UIStoryboard(name: "DataBase", bundle: nil).instantiateViewController(identifier: "StudentsViewController") as! StudentsViewController
        
        let group = groups[indexPath.row]
        studentsViewController.group = group
            
        self.navigationController?.pushViewController(studentsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        
        
        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = "Grade: \(group.grade + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            let groupToDelete = self.groups[indexPath.row]
            DataManager.shared.persistentContainer.viewContext.delete(groupToDelete)
            self.groups.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
            DataManager.shared.saveContext()
            
        }

        
//        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, _) in
//
//            let alert = UIAlertController(title: "Do you want to edit ?", message: "You coild do so when we implement this functionality", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self?.present(alert, animated: true)
//        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
