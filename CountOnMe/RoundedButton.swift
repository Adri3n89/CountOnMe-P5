//
//  RoundedButton.swift
//  CountOnMe
//
//  Created by Adrien PEREA on 02/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = self.frame.height / 2
    }

}
