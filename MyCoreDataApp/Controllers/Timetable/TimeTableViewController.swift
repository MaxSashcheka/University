//
//  LessonsViewController.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/28/21.
//

import UIKit

class TimeTableViewController: UIViewController {

    @IBOutlet weak var lessonTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timetableCollectionView: UICollectionView!
    
    var lessons = [Lesson]()
    
    var edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    var displayingLessonType = LessonType.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timetableCollectionView.delegate = self
        timetableCollectionView.dataSource = self
        timetableCollectionView.register(LessonCell.nib(), forCellWithReuseIdentifier: LessonCell.reuseIdentifier)
        timetableCollectionView.backgroundColor = .secondarySystemBackground
        
        lessonTypeSegmentedControl.addTarget(self, action: #selector(changeLessonTypeHandler(_:)), for: .valueChanged)

        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLessonsCollectionView()
        
    }
    
    @objc private func changeLessonTypeHandler(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            displayingLessonType = .all
        case 1:
            displayingLessonType = .lecture

        case 2:
            displayingLessonType = .practice

        case 3:
            displayingLessonType = .lab

        default:
            print("Eror")
        }
        
        updateLessonsCollectionView()
    }
    
    private func updateLessonsCollectionView() {
        self.lessons = DataManager.shared.fetchLessons(withLessonType: displayingLessonType)
        timetableCollectionView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 45, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        title = "Timetable"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward")!
        navigationController?.navigationBar.tintColor = .black
        
        let newLessonButton = CustomButton()
        newLessonButton.frame = CGRect(x: 0, y: 0, width: 118, height: 34)
        newLessonButton.setTitle("Add lesson", for: .normal)
        newLessonButton.addTarget(self, action: #selector(addNewLesson), for: .touchUpInside)
        
        let newTeacherButton = CustomButton()
        newLessonButton.frame = CGRect(x: 0, y: 0, width: 118, height: 34)
        newLessonButton.setTitle("Add lesson", for: .normal)
        newLessonButton.addTarget(self, action: #selector(addNewLesson), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newLessonButton)
    }
    
    @objc func addNewLesson() {
        let detailViewController = UIStoryboard(name: "Timetable", bundle: nil).instantiateViewController(identifier: "TimeTableDetailViewController") as! TimeTableDetailViewController
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}

extension TimeTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCell.reuseIdentifier, for: indexPath) as! LessonCell
        
        let lesson = lessons[indexPath.row]
        cell.setup(withLesson: lesson)
        
        return cell
    }
    
}

extension TimeTableViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width - edgeInsets.left * 2
        let itemHeight = itemWidth / 2.7
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return edgeInsets.bottom
    }
    
}
