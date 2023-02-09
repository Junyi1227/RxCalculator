//
//  Button.swift
//  RxCalculator
//
//  Created by Junyi Wang on 2023/2/9.
//

import Foundation
import UIKit

enum CustomButtonType {
    case optional
    case num
    case extraOption
}

class Button: UIButton {
    var type: CustomButtonType = .num
    var height = 80
    init(type: CustomButtonType, height: Int = 80) {
        super.init(frame: .zero)

        self.type = type
        self.height = 80
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        switch self.type {
        case .num: self.backgroundColor = .lightGray
        case .optional: self.backgroundColor = .orange
        case .extraOption: self.backgroundColor = .darkGray
        }
        self.layer.cornerRadius = CGFloat(height/2)
    }
}
