//
//  DSDynamicOptionsTests.m
//  DSDynamicOptionsTests
//
//  Created by Andrew Podkovyrin on 10/25/2019.
//  Copyright (c) 2019 Andrew Podkovyrin. All rights reserved.
//

@import XCTest;

#import "DSDynamicOptions.h"

#pragma mark - TestDSDynamicOptions

@interface TestDSDynamicOptions: DSDynamicOptions

@property (nonatomic, copy) NSString *nsStringValue;
@property (nonatomic, strong) NSNumber *nsNumberValue;
@property (nonatomic, assign) NSInteger integerValue;
@property (nonatomic, assign) BOOL boolValue;
@property (nonatomic, assign) float floatValue;

@end

@implementation TestDSDynamicOptions

@dynamic nsStringValue;
@dynamic nsNumberValue;
@dynamic integerValue;
@dynamic boolValue;
@dynamic floatValue;

+ (instancetype)sharedInstance {
    static TestDSDynamicOptions *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithUserDefaults:nil defaults:@{
            @"nsStringValue": @"default-string",
            @"nsNumberValue": @1,
            @"integerValue": @123,
            @"boolValue": @YES,
            @"floatValue": @12.3,
        }];
    });
    return _sharedInstance;
}

- (NSString *)defaultsKeyForPropertyName:(NSString *)propertyName {
    return [NSString stringWithFormat:@"test_%@", propertyName];
}

@end

#pragma mark - Test

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];

    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

- (void)tearDown {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [super tearDown];
}

- (void)testDefaults {
    XCTAssertEqualObjects([TestDSDynamicOptions sharedInstance].nsStringValue, @"default-string");
    XCTAssertEqualObjects([TestDSDynamicOptions sharedInstance].nsNumberValue, @1);
    XCTAssertEqual([TestDSDynamicOptions sharedInstance].integerValue, 123);
    XCTAssertEqual([TestDSDynamicOptions sharedInstance].boolValue, YES);
}

- (void)testSetters {
    [TestDSDynamicOptions sharedInstance].nsStringValue = @"changed-string";
    [TestDSDynamicOptions sharedInstance].nsNumberValue = @2;
    [TestDSDynamicOptions sharedInstance].integerValue = 456;

    XCTAssertEqualObjects([TestDSDynamicOptions sharedInstance].nsStringValue, @"changed-string");
    XCTAssertEqualObjects([TestDSDynamicOptions sharedInstance].nsNumberValue, @2);
    XCTAssertEqual([TestDSDynamicOptions sharedInstance].integerValue, 456);
}

- (void)testGetters {
    XCTAssertEqualObjects([TestDSDynamicOptions sharedInstance].nsStringValue, [[NSUserDefaults standardUserDefaults] objectForKey:@"test_nsStringValue"]);
    XCTAssertEqualObjects([TestDSDynamicOptions sharedInstance].nsNumberValue, [[NSUserDefaults standardUserDefaults] objectForKey:@"test_nsNumberValue"]);
    XCTAssertEqual([TestDSDynamicOptions sharedInstance].integerValue, [[NSUserDefaults standardUserDefaults] integerForKey:@"test_integerValue"]);
}

@end

