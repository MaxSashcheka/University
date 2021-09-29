//
//  GroupCollectionViewCell.swift
//  University
//
//  Created by Max Sashcheka on 9/29/21.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GroupCollectionViewCell"

    @IBOutlet weak var groupNameLabel: UILabel!
    var isChoosed = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        layer.cornerRadius = frame.height / 9
    }
    
    func setup(withGroup group: Group) {
        groupNameLabel.text = group.name
    }
    
    func cellDidTapped() {
        isChoosed = !isChoosed
        if isChoosed {
            
        }
    }
    

    static func nib() -> UINib {
        return UINib(nibName: "GroupCollectionViewCell", bundle: nil)
    }
}
