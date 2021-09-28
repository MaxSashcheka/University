//
//  HeaderViewButton.swift
//  Contacts
//
//  Created by Max Sashcheka on 9/17/21.
//

import UIKit

class CustomButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemTeal
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 1.0
        layer.shadowOffset = .zero
        layer.cornerRadius = 15
    
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.transition(with: self, duration: 0.2, options: [.transitionCrossDissolve]) { [self] in
                if isHighlighted {
                    layer.shadowRadius = 4.0
                    layer.shadowColor = UIColor.systemBlue.cgColor
                } else {
                    layer.shadowRadius = 3.0
                    layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                }
            }
        }
    }
    
}
