//
//  Button.swift
//  RxCalculator
//
//  Created by Junyi Wang on 2023/2/9.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class Button: UIButton {
    var type: CalculatorButton?

    init(type: CalculatorButton) {
        super.init(frame: .zero)

        self.type = type
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.setTitle(type!.text(), for: .normal)

        if self.type is FunctionalButton {
            self.backgroundColor = .darkGray
        }else if self.type is NumberButton {
            self.backgroundColor = .lightGray
        }else if self.type is OperatorButton {
            self.backgroundColor = .orange
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.height / 2
        tintColor = UIColor.white
        setTitleColor(UIColor.white, for: .normal)
    }
}
