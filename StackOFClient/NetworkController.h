//
//  NetworkController.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface NetworkController : NSObject


+ (id)networkController;

- (void) searchForQuestionsWithTag: (NSString *) tag withCompletionHandler: (void (^)(NSString *, NSMutableArray *))completionHandler;

@end
