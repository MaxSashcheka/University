//
//  CollectionViewCell.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/28/21.
//

import UIKit

class LessonCell: UICollectionViewCell {
    
    @IBOutlet weak var leftSideIndicatorView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lessonTypeNameLabel: UILabel!
    
    static let reuseIdentifier = "S"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 1.0
        layer.shadowOffset = .zero
        
        layer.cornerRadius = self.frame.height / 6.5
        backgroundColor = .white
        leftSideIndicatorView.layer.cornerRadius = leftSideIndicatorView.frame.width / 2

    }
    
    func setup(withLesson lesson: Lesson) {
        var lessonTypeColor = UIColor()
        switch lesson.lessonTypeStatus {
        case .lecture:
            lessonTypeColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            lessonTypeNameLabel.text = "Лекция"
            
        case .practice:
            lessonTypeColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            lessonTypeNameLabel.text = "Практическое"

        case .lab:
            lessonTypeColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            lessonTypeNameLabel.text = "Лабораторная"

        default:
            lessonTypeColor = .clear
        }
        
        leftSideIndicatorView.backgroundColor = lessonTypeColor
        titleLabel.textColor = lessonTypeColor
        lessonTypeNameLabel.textColor = lessonTypeColor
        
        titleLabel.text = lesson.title
        locationLabel.text = lesson.location

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "LessonCell", bundle: nil)
    }
    
    

}
