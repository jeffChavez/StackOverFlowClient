//
//  Question.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Question : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) NSInteger questionID;
@property (nonatomic, assign) NSInteger viewCount;
@property (nonatomic, assign) NSInteger answerCount;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, strong) NSString *profileImageURLString;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) NSTimeInterval timeSincePost;

- (instancetype) initWithDictionary: (NSDictionary *) itemDictionary;

- (NSMutableArray *) parseJSONDataIntoQuestions: (NSData *) data;

@end
