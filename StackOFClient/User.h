//
//  User.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) NSInteger bronzeBadgeCount;
@property (nonatomic, assign) NSInteger silverBadgeCount;
@property (nonatomic, assign) NSInteger goldBadgeCount;
@property (nonatomic, strong) NSString *profileImageURLString;
@property (nonatomic, strong) UIImage *profileImage;

-(instancetype) initWithDictionary: (NSDictionary *) userDictionary;

- (NSMutableArray *) parseJSONDataIntoUsers: (NSData *) data;

@end
