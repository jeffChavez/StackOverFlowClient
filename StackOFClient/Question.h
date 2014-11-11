//
//  Question.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Question : NSObject

@property NSString *title;
@property NSString *link;
@property NSString *questionID;
@property NSInteger viewCount;
@property NSInteger answerCount;
@property NSInteger score;

- (instancetype) initWithDictionary: (NSDictionary *) itemDictionary;


@end
