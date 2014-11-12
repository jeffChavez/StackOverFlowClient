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
@property NSInteger questionID;
@property NSInteger viewCount;
@property NSInteger answerCount;
@property NSInteger score;
@property (nonatomic, strong) NSDictionary *owner;
@property (nonatomic, strong) NSString *profileImageURLString;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, strong) NSString *username;
@property NSTimeInterval timeSincePost;

- (instancetype) initWithDictionary: (NSDictionary *) itemDictionary;


@end
