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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timetableCollectionView.delegate = self
        timetableCollectionView.dataSource = self

        setupNavigationBar()
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
        return UICollectionViewCell()
    }
    
    
}
