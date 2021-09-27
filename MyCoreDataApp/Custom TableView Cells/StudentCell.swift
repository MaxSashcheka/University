//
//  StudentCell.swift
//  MyCoreDataApp
//
//  Created by Max Sashcheka on 9/27/21.
//

import UIKit

class StudentCell: UITableViewCell {
    
    static let reuseIdentifier = "StudentCell"
    
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentIdentifierLabel: UILabel!
    @IBOutlet weak var studentEnterDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        studentImageView.layer.cornerRadius = studentImageView.frame.height / 2
        
        let image = UIImage(systemName: "heart")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        
        self.accessoryView = imageView
        
    }
    
    func setup(withStudent student: Student) {
        studentNameLabel.text = student.name
        studentIdentifierLabel.text = "Identifier: \(student.identifier)"
        studentEnterDateLabel.text = "temp"
        
        let randomIndex = Int.random(in: 0...26)
        studentImageView.image = UIImage(named: "image\(randomIndex)")!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        studentEnterDateLabel.text = dateFormatter.string(from: student.enterDate!)
    }

    static func nib() -> UINib {
        return UINib(nibName: "StudentCell", bundle: nil)
    }
    
}
