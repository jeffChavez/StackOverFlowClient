//
//  NetworkController.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "User.h"

@interface NetworkController : NSObject


+ (id)networkController;

- (void) searchForQuestionsWithTag: (NSString *) tag withURL: (NSString *) url withCompletionHandler: (void (^)(NSString *, NSMutableArray *))completionHandler;
- (void) searchForUsersByName: (NSString *) name withCompletionHandler: (void (^)(NSString *, NSMutableArray*)) completionHandler;

- (void) downloadImageFromQuestionSearch: (Question *) question withCompletionHandler: (void (^) (UIImage *)) completionHandler;
- (void) downloadImageFromUserSearch: (User *) user withCompletionHandler: (void (^) (UIImage *)) completionHandler;

@end
