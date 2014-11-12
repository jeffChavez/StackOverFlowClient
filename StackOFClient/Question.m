//
//  Question.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "Question.h"

@interface Question ()

@end

@implementation Question

- (instancetype) initWithDictionary: (NSDictionary *) questionDictionary {
    self = [super init];
    
    if (self) {
        self.title = questionDictionary[@"title"];
        self.questionID = [questionDictionary[@"question_id"] integerValue];
        self.link = (NSString *) questionDictionary[@"link"];
        self.answerCount = [questionDictionary[@"answer_count"] integerValue];
        self.viewCount = [(NSString *) questionDictionary[@"view_count"] integerValue];
        self.score = [(NSString *) questionDictionary[@"score"] integerValue];
        self.timeSincePost = [questionDictionary[@"creation_date"] doubleValue];
        self.owner = (NSDictionary *) questionDictionary[@"owner"];
        self.profileImageURLString = (NSString *) self.owner[@"profile_image"];
        self.username = (NSString *) self.owner[@"display_name"];
    }
    return self;
}

@end