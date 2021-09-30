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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 12
        
        groupNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
    
    func setup(withGroup group: Group, isSelected: Bool) {
        groupNameLabel.text = group.name
        
        if isSelected {
            layer.borderWidth = 3.6
            layer.borderColor = UIColor.red.cgColor
        } else {
            layer.borderWidth = 2
            layer.borderColor = UIColor.darkGray.cgColor
        }
    }


    static func nib() -> UINib {
        return UINib(nibName: "GroupCollectionViewCell", bundle: nil)
    }
}
