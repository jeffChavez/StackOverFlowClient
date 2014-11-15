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
        self.link = questionDictionary[@"link"];
        self.answerCount = [questionDictionary[@"answer_count"] integerValue];
        self.viewCount = [questionDictionary[@"view_count"] integerValue];
        self.score = [questionDictionary[@"score"] integerValue];
        self.timeSincePost = [questionDictionary[@"creation_date"] doubleValue];
        self.profileImageURLString = [questionDictionary valueForKeyPath:@"owner.profile_image"];
        self.username = [questionDictionary valueForKeyPath:@"owner.display_name"];
    }
    return self;
}

- (NSMutableArray *) parseJSONDataIntoQuestions: (NSData *) data {
    NSError *error = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSMutableArray *itemArray = jsonDictionary[@"items"];
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    for (NSDictionary *item in itemArray) {
        Question *newQuestion = [[Question alloc] initWithDictionary:item];
        [questions addObject:newQuestion];
    }
    return questions;
}
@end