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
    
    @IBOutlet weak var studentGroupCollectionView: UICollectionView!
    let groupsSectionInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        studentGroupCollectionView.delegate = self
        studentGroupCollectionView.dataSource = self
        studentGroupCollectionView.register(GroupCollectionViewCell.nib(), forCellWithReuseIdentifier: GroupCollectionViewCell.reuseIdentifier)
        studentGroupCollectionView.backgroundColor = .secondarySystemBackground
        
        
        title = "Create lesson"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groups = DataManager.shared.fetchGroups()

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
        
        if lessonName.isEmpty || lessonLocation.isEmpty {
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

extension TimeTableDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.reuseIdentifier, for: indexPath) as! GroupCollectionViewCell
        
        let group = groups[indexPath.item]
        cell.setup(withGroup: group)
        
        
        return cell
    }
    
}

extension TimeTableDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemHeight = studentGroupCollectionView.frame.height - groupsSectionInsets.top * 2
        let itemWidth = itemHeight / 1.3
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return groupsSectionInsets
    }
}
