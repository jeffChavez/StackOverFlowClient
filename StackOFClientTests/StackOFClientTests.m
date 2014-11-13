//
//  StackOFClientTests.m
//  StackOFClientTests
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NetworkController.h"

@interface StackOFClientTests : XCTestCase

@end

@implementation StackOFClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void) testJSONParsing {
    //check if json isnt nill, run parse, check if count is equal to sample json, check if a property in the first object in that array is equal to the sample json
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSMutableArray *sampleArray = [[Question alloc] parseJSONDataIntoQuestions:jsonData];
    XCTAssertEqual(sampleArray.count, 10);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
