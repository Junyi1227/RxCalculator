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
    private var relay = BehaviorRelay<String>(value: "")
    private var lastLabel: String = ""
    private var lastNumber: NSNumber = 0
    private var lastOperator: OperatorButton? = nil
    private var currentNumber: NSNumber = 0

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
                    }
                    break
                default:
                    break
                }
                return self.lastLabel
            }
            .startWith("0")
            
        return Output(text: text)
    }
}

extension ViewModel {
    private func inputNum(num: String) {
        let dot = self.lastLabel.hasSuffix(".") ? "." : ""
        self.currentNumber = NSNumber(value: Double("\(self.currentNumber)" + dot + num) ?? 0)
        self.lastLabel = "\(self.currentNumber)"
    }
    
    private func inputDot() {
        if (!self.lastLabel.contains(".")) {
            self.lastLabel = self.lastLabel + "."
        }
    }
    
    private func inputClear() {
        self.currentNumber = 0
        self.lastNumber = 0
        self.lastOperator = nil
        self.lastLabel = "\(self.currentNumber)"
    }
    
    private func inputOperator(_ inputOperator: OperatorButton) {
        let result: NSNumber
        if let lastOperator = self.lastOperator {
            result = lastOperator.execute(self.lastNumber, self.currentNumber)
            self.lastLabel = "\(result)"
        }else {
            result = self.currentNumber
        }
        
        self.lastOperator = inputOperator
        self.lastNumber = result
        self.currentNumber = 0
    }
}
