//
//  TestBlackScholes.m
//  TestBlackScholes
//
//  Created by Søren  Hesel on 13/11/2026.
//

#import <XCTest/XCTest.h>
#include "../Quant/Scripting/scriptingModel.h"
#include <memory>

@interface TestBlackScholes : XCTestCase {
    Date _today;
    double _spot;
    double _volatility;
    double _rate;
    Date _maturity;
    double _strike;
    std::unique_ptr<SimpleBlackScholes<double>> bs;
}

@end

@implementation TestBlackScholes

///
///Test setup of black scholes class
///
- (void)setUp {
    [super setUp];

    _today = 0; // Fixed reference day for the test.
    _spot = 100.0;
    _volatility = 0.20;
    _rate = 0.05;
    _maturity = 365;
    _strike = 100.0;
    bs = std::make_unique<SimpleBlackScholes<double>>(_today, _spot, _volatility, _rate);
    //Test spot:
    XCTAssertEqualWithAccuracy(bs->spot(), 100.0, 1e-10);
    //Test volatility:
    XCTAssertEqualWithAccuracy(bs->vol(), 0.2, 1.0e-10);
}

- (void)tearDown {
    bs.reset();
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
    bs->initSimDates(simDates);
    XCTAssertEqual(365/5, bs->dim());
    
    
}

- (void)testScriptingExample
{
    // This is an example of the simpleBsScriptVal method:
    std::map<Date,string> events;
    std::vector<string> varNames;
    std::vector<double> vals;
    varNames.push_back("opt");
    auto paymentString = "opt pays max(0,spot()-"+ std::to_string(_strike)+")";
    events.insert(pair(_maturity,paymentString));
    simpleBsScriptVal(_today, _spot, _volatility, _rate, false, events, 100, 0, false, 0.00001, false, varNames, vals);
    XCTAssertEqualWithAccuracy(vals[0], 8.8128097249618786, 1.0e-8);
}

- (void) testLsmAlgorithm
{
    // This is an example of the Lsm algorithm:
    // This is an example of the simpleBsScriptVal method:
    std::map<Date,string> events;
    std::vector<string> varNames;
    std::vector<double> vals;
    varNames.push_back("opt");
    varNames.push_back("vExercise");
    auto pay = "spot() -"  +std::to_string(_strike);
    auto paymentString = "if(vExercise) = 0 then opt pays max(0," +pay+") EndIf" ;
    
    auto eventString = "if(pv(opt) < " + pay + ") then opt pays "+ pay +" AND vExercise = 1 else vExercise  =0 EndIf" ;
    auto dt = 5;
    while(dt<_maturity){
        events.insert(pair(dt,eventString));
        dt+=5;
    }
    events.insert(pair(_maturity,paymentString));
    simpleBsScriptVal(_today, _spot, _volatility, _rate, false, events, 100, 0, false, 0.00001, false, varNames, vals);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
