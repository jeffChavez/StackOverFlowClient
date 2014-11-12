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
        self.title = (NSString *) questionDictionary[@"title"];
        self.questionID = (NSInteger) questionDictionary[@"question_id"];
        self.link = (NSString *) questionDictionary[@"link"];
        self.answerCount = [questionDictionary[@"answer_count"] integerValue];
        self.viewCount = [(NSString *) questionDictionary[@"view_count"] integerValue];
        self.score = [(NSString *) questionDictionary[@"score"] integerValue];
    }
    return self;
}

@end