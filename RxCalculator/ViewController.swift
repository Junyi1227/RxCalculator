//
//  ViewController.swift
//  RxCalculator
//
//  Created by Junyi Wang on 2023/2/8.
//

import UIKit
import Then
import SnapKit
import RxSwift

class ViewController: UIViewController {
    let button0: Button = Button(type: NumberButton.zero)
    let button1: Button = Button(type: NumberButton.one)
    let button2: Button = Button(type: NumberButton.two)
    let button3: Button = Button(type: NumberButton.three)
    let button4: Button = Button(type: NumberButton.four)
    let button5: Button = Button(type: NumberButton.five)
    let button6: Button = Button(type: NumberButton.six)
    let button7: Button = Button(type: NumberButton.seven)
    let button8: Button = Button(type: NumberButton.eight)
    let button9: Button = Button(type: NumberButton.nine)
    let buttonDot: Button = Button(type: FunctionalButton.dot)
    
    let optionPlus: Button = Button(type: OperatorButton.plus)
    let optionSubtract: Button = Button(type: OperatorButton.subtract)
    let optionMultiply: Button = Button(type: OperatorButton.multiply)
    let optionDivision: Button = Button(type: OperatorButton.divide)
    let optionEqual: Button = Button(type: OperatorButton.equals)
    let optionClear: Button = Button(type: FunctionalButton.clear)
    let optionRemainder: Button = Button(type: FunctionalButton.empty)
    let optionMinus: Button = Button(type: FunctionalButton.minus)
    
    let calculatorView: UIView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let numberLabel: UILabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: 64)
    }
    
    let vm = ViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .brown
        setupUI()
        bind()
    }
    
    private func bind() {
        let taps = calculatorView.subviews.map { view -> Observable<CalculatorButton> in
            let button = view as! Button
            return button.rx.tap.map{button.type!}.asObservable()
        }
                
        let input = ViewModel.Input(numButtonClick: Observable.merge(taps))
        let output = vm.transform(input: input)
        
        output.text.subscribe(onNext: { str in
            self.numberLabel.text = str

        })
        .disposed(by: disposeBag)

    }
    private func setupUI() {
        self.view.addSubview(numberLabel)
        self.view.addSubview(calculatorView)
        numberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.calculatorView.snp.top).offset(-16)
            make.right.equalTo(self.calculatorView.snp.right)
            make.left.equalTo(self.calculatorView.snp.left)
        }
        
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
                        make.width.equalTo(buttonHeight * 2 + padding)
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

        calculatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
    }

}

