//
//  ViewModel.swift
//  RxCalculator
//
//  Created by Junyi Wang on 2023/2/9.
//

import Foundation
import RxSwift
import RxRelay

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
class ViewModel {
    private var lastOperator: BehaviorRelay<OperatorButton?> = BehaviorRelay(value: nil)
    private var lastNumber: BehaviorRelay<NSNumber> = BehaviorRelay(value: 0)
    private var currentNumber: BehaviorRelay<NSNumber> = BehaviorRelay(value: 0)
    private var lastLabel: BehaviorRelay<String> = BehaviorRelay(value: "")
}

extension ViewModel: ViewModelType {
    struct Input {
        let numButtonClick: Observable<CalculatorButton>
    }
    
    struct Output {
        let text: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let text = input.numButtonClick
            .map { button -> String in
                switch button {
                case let operatorButton as OperatorButton:
                    self.inputOperator(operatorButton)
                    break
                case let operatorButton as NumberButton:
                    self.inputNum(num: operatorButton.text())
                    break
                case let funcButton as FunctionalButton:
                    switch funcButton {
                        
                    case .clear:
                        self.inputClear()
                        break
                    case .empty:
                        break
                    case .dot:
                        self.inputDot()
                        break
                    case .minus:
                        self.inputMinus()
                        break
                    }
                    break
                default:
                    break
                }
                return self.lastLabel.value
            }
            .startWith("0")
            
        return Output(text: text)
    }
}

extension ViewModel {
    private func inputNum(num: String) {
        let dot = self.lastLabel.value.hasSuffix(".") ? "." : ""
        self.currentNumber.accept(NSDecimalNumber(value: Double("\(self.currentNumber.value)" + dot + num) ?? 0))
        //TODO: 0.01會誤判
        self.lastLabel.accept("\(self.currentNumber.value)")
    }
    
    private func inputDot() {
        if (!self.lastLabel.value.contains(".")) {
            self.lastLabel.accept(self.lastLabel.value + ".")
        }
    }
    private func inputMinus() {
        self.currentNumber.accept(NSDecimalNumber(value: self.currentNumber.value.doubleValue * -1))
        self.lastLabel.accept("\(self.currentNumber.value)")
    }
    private func inputClear() {
        self.currentNumber.accept(0)
        self.lastNumber.accept(0)
        self.lastOperator.accept(nil)
        self.lastLabel.accept("\(self.currentNumber.value)")
    }
    
    private func inputOperator(_ inputOperator: OperatorButton) {
        let result: NSNumber
        if let lastOperator = self.lastOperator.value {
            result = lastOperator.execute(self.lastNumber.value, self.currentNumber.value)
            self.lastLabel.accept("\(result)")
        }else {
            result = self.currentNumber.value
        }
        
        self.lastOperator.accept(inputOperator)
        self.lastNumber.accept(result)
        self.currentNumber.accept(0)
    }
}
