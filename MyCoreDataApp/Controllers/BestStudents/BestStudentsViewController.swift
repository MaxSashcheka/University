//
//  StudentsScreenViewController.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/28/21.
//

import UIKit

class BestStudentsViewController: UIViewController {
    
    @IBOutlet weak var predicatePickerSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var sortType: SortType = .none
    
    var excellentStudents = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(StudentCell.nib(), forCellReuseIdentifier: StudentCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        predicatePickerSegmentedControl.addTarget(self, action: #selector(changeSortTypeHandler(_:)), for: .valueChanged)
        
        setupNavigationBar()
    }
    
    @objc private func changeSortTypeHandler(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sortType = .none
        case 1:
            sortType = .identifier
        case 2:
            sortType = .name
        case 3:
            sortType = .date
        default:
            print("Out of index range")
        }
        updateUI()
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func updateUI() {
        excellentStudents = DataManager.shared.fetchBestStudents(withSortType: sortType)
        var indexPathArray = [IndexPath]()
        for i in 0..<excellentStudents.count {
            indexPathArray.append(IndexPath(row: i, section: 0))
        }
        tableView.reloadRows(at: indexPathArray, with: .fade)
        
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 45, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        title = "Best students"
    }
    
    

}

extension BestStudentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excellentStudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.reuseIdentifier, for: indexPath) as! StudentCell
        
        let student = excellentStudents[indexPath.row]
        cell.setup(withStudent: student)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = excellentStudents[indexPath.row]
        student.isExcellentStudent = !student.isExcellentStudent
        DataManager.shared.saveContext()
        
        tableView.reloadData()
    }
    
    
}
