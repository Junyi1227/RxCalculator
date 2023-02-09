//
//  ViewController.swift
//  RxCalculator
//
//  Created by Junyi Wang on 2023/2/8.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    let button0: Button = Button(type: .num).then {
        $0.setTitle("0", for: .normal)
    }
    let button1: Button = Button(type: .num).then {
        $0.setTitle("1", for: .normal)
    }
    let button2: Button = Button(type: .num).then {
        $0.setTitle("2", for: .normal)
    }
    let button3: Button = Button(type: .num).then {
        $0.setTitle("3", for: .normal)
    }
    let button4: Button = Button(type: .num).then {
        $0.setTitle("4", for: .normal)
    }
    let button5: Button = Button(type: .num).then {
        $0.setTitle("5", for: .normal)
    }
    let button6: Button = Button(type: .num).then {
        $0.setTitle("6", for: .normal)
    }
    let button7: Button = Button(type: .num).then {
        $0.setTitle("7", for: .normal)
    }
    let button8: Button = Button(type: .num).then {
        $0.setTitle("8", for: .normal)
    }
    let button9: Button = Button(type: .num).then {
        $0.setTitle("9", for: .normal)
    }
    let buttonDot: Button = Button(type: .num).then {
        $0.setTitle(".", for: .normal)
    }
    
    let optionPlus: Button = Button(type: .optional).then {
        $0.setTitle("+", for: .normal)
    }
    let optionSubtract: Button = Button(type: .optional).then {
        $0.setTitle("-", for: .normal)
    }
    let optionMultiply: Button = Button(type: .optional).then {
        $0.setTitle("*", for: .normal)
    }
    let optionDivision: Button = Button(type: .optional).then {
        $0.setTitle("/", for: .normal)
    }
    let optionEqual: Button = Button(type: .optional).then {
        $0.setTitle("=", for: .normal)
    }
    let optionClear: Button = Button(type: .extraOption).then {
        $0.setTitle("C", for: .normal)
    }
    let optionRemainder: Button = Button(type: .extraOption).then {
        $0.setTitle("%", for: .normal)
    }
    let optionMinus: Button = Button(type: .extraOption).then {
        $0.setTitle("+/-", for: .normal)
    }

    let calculatorView: UIView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .brown
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(calculatorView)
        let views = [[optionClear,optionMinus,optionRemainder,optionDivision],
                     [button7,button8,button9,optionMultiply],
                     [button4,button5,button6,optionSubtract],
                     [button1,button2,button3,optionPlus],
                     [button0,buttonDot,optionEqual]]
        let padding = 8
        let buttonHeight = 80
        for (i,viewRow) in views.enumerated() {
            for (j, view) in viewRow.enumerated() {
                self.calculatorView.addSubview(view)
                view.snp.makeConstraints { make in
                    if view == button0 {
                        make.height.equalTo(buttonHeight)
                        make.width.equalTo(buttonHeight*2 + padding)
                    }else{
                        make.height.width.equalTo(buttonHeight)
                    }
                    
                    if i == 0 {
                        make.top.equalToSuperview().offset(padding)
                    }else{
                        make.top.equalTo(views[i-1].first!.snp.bottom).offset(padding)
                    }
                    if j == 0 {
                        make.left.equalToSuperview().offset(padding)
                    }else {
                        make.left.equalTo(viewRow[j-1].snp.right).offset(padding)
                    }
                    if j == viewRow.count - 1 {
                        make.right.equalToSuperview().offset(-padding)
                    }
                    if i == views.count - 1 {
                        make.bottom.equalToSuperview().offset(-padding)
                    }
                }
            }
        }
//        calculatorView.backgroundColor = .purple
        calculatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
    }

}

