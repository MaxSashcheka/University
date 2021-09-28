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
    @IBOutlet weak var lessonTypeName: UILabel!
    
    static let reuseIdentifier = "S"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(withLesson lesson: Lesson) {
        leftSideIndicatorView.layer.cornerRadius = leftSideIndicatorView.frame.width / 2
        self.layer.cornerRadius = self.frame.height / 8
        self.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        
        var lessonTypeColor = UIColor()
        switch lesson.lessonTypeStatus {
        case .lecture:
            lessonTypeColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        case .practice:
            lessonTypeColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        case .lab:
            lessonTypeColor = #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        default:
            lessonTypeColor = .clear
        }
        
        leftSideIndicatorView.backgroundColor = lessonTypeColor
        titleLabel.textColor = lessonTypeColor
        lessonTypeName.textColor = lessonTypeColor
        
        titleLabel.text = lesson.title
        locationLabel.text = lesson.location
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "LessonCell", bundle: nil)
    }
    
    

}
