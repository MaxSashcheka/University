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
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let groupsSectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let maximumGroupsNumberPerLesson = 4
    
    var selectedItemsIndexes = Set<Int>()
    
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        studentGroupCollectionView.delegate = self
        studentGroupCollectionView.dataSource = self
        studentGroupCollectionView.register(GroupCollectionViewCell.nib(), forCellWithReuseIdentifier: GroupCollectionViewCell.reuseIdentifier)
        studentGroupCollectionView.backgroundColor = .secondarySystemBackground
        
        errorLabel.isHidden = true
        
        title = "Create lesson"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groups = DataManager.shared.fetchGroups()
        studentGroupCollectionView.reloadData()
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
        
        let lesson = DataManager.shared.createLesson(title: lessonName, location: lessonLocation, lessonType: lessonType)
        
        let groupsIndexes = Array(selectedItemsIndexes)
        for index in groupsIndexes {
            let group = groups[index]
            lesson.addToGroups(group)
        }
        
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
        let isSelected = selectedItemsIndexes.contains(indexPath.item)
        cell.setup(withGroup: group, isSelected: isSelected)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedItemsIndexes.contains(indexPath.item) {
            selectedItemsIndexes.remove(indexPath.item)
        } else {
            
            if selectedItemsIndexes.count == maximumGroupsNumberPerLesson {
                errorLabel.isHidden = false
            } else {
                errorLabel.isHidden = true
                selectedItemsIndexes.insert(indexPath.item)
            }
            
        }
        
        studentGroupCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        studentGroupCollectionView.reloadData()
    }
    
    
    
}

extension TimeTableDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let groupName = groups[indexPath.item].name
        let fontSize: CGFloat = 20
        
        let itemWidth = (groupName?.widthOfString(usingFont: UIFont.systemFont(ofSize: fontSize, weight: .medium)))! + fontSize * 2
        let itemHeight = fontSize + CGFloat(20)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return groupsSectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return groupsSectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return groupsSectionInsets.left
    }
}
