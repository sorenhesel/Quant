//
//  TestCEV.m
//  TestBlackScholes
//
//  Created by Søren  Hesel on 16/11/2026.
//

#import <XCTest/XCTest.h>
#include "../Quant/Scripting/scriptingModel.h"
#include <memory>


@interface TestCEV : XCTestCase{
    Date _today;
    double _spot;
    double _volatility;
    double _beta;
    double _rate;
    Date _maturity;
    double _strike;
    std::unique_ptr<CEV<double>> cev;
    std::unique_ptr<SimpleBlackScholes<double>> bs;
}@end

@implementation TestCEV

- (void)setUp {
    [super setUp];
    _today = 0; // Fixed reference day for the test.
    _spot = 100.0;
    _volatility = 0.20;
    _rate = 0.05;
    _beta = 1.5;
    _maturity = 365;
    // Put setup code here. This method is called before the invocation of each test method in the class.
    cev = std::make_unique<CEV<double>>(_today,_spot,_volatility,_rate,_beta);
    bs = std::make_unique<SimpleBlackScholes<double>>(_today, _spot, _volatility, _rate);
    
    XCTAssertEqualWithAccuracy(cev->spot(), _spot, 1.0e-10);
    XCTAssertEqualWithAccuracy(cev->beta(), _beta, 1.0e-10);
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    cev.reset();
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // XCTest Documentation
    // https://developer.apple.com/documentation/xctest
    std::vector<Date> simDates;
    simDates.push_back(_today);
    auto dt = 5;
    while(dt<_maturity){
        simDates.push_back(dt);
        dt+=5;
    }
    simDates.push_back(_maturity);
    cev->initSimDates(simDates);
    XCTAssertEqual(365/5, cev->dim());
    

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
