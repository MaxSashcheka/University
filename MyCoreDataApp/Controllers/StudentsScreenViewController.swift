//
//  StudentsScreenViewController.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/28/21.
//

import UIKit

class StudentsScreenViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StudentCell.nib(), forCellReuseIdentifier: StudentCell.reuseIdentifier)
        
        return tableView
    }()
    
    var excellentStudents = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        

        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        excellentStudents = DataManager.fetchExcellentStudents()
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        title = "Excellent students"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    

}

extension StudentsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    
}
