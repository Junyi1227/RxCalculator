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

    init(type: CustomButtonType) {
        super.init(frame: .zero)

        self.type = type
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.height / 2
        tintColor = UIColor.white
        setTitleColor(UIColor.white, for: .normal)
    }
}
