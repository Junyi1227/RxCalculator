//
//  RxCalculatorTests.swift
//  RxCalculatorTests
//
//  Created by Junyi Wang on 2023/2/8.
//

import XCTest
import RxSwift
import RxTest

@testable import RxCalculator
class RxCalculatorTests: XCTestCase {


    func testTenAddOne() throws {
        //模擬label
        let observer = scheduler.createObserver(String.self)
               
        //模擬button
        let click:TestableObservable<CalculatorButton> = scheduler.createColdObservable([
            .next(100, NumberButton.one) ,
            .next(100, NumberButton.zero) ,
            .next(100, OperatorButton.plus),
            .next(100, NumberButton.one),
            .next(100, OperatorButton.equals)
        ])
            
        let input = ViewModel.Input(numButtonClick: click.asObservable())
        let output = viewModel.transform(input: input)
        output.text.bind(to: observer).disposed(by: self.disposeBag)
        scheduler.start()

        XCTAssertEqual(observer.events, [.next(0, "0"),
                                         .next(100, "1"),
                                         .next(100, "10"),
                                         .next(100, "10"),
                                         .next(100, "1"),
                                         .next(100, "11")])

        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    var viewModel : ViewModel!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUpWithError() throws {
        viewModel = ViewModel()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        disposeBag = nil
        scheduler = nil
        super.tearDown()
    }
}
