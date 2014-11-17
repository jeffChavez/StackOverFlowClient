//
//  NetworkController.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "NetworkController.h"
#import "Question.h"
#import "WebViewController.h"
#import "Question.h"
#import "Constants.h"
#import "User.h"

@interface NetworkController ()

@property NSURLSession *authenticatedURLSession;
@property NSOperationQueue *imageDownloadQueue;
@property NSString *clientID;

@end

@implementation NetworkController

+ (id)networkController {
    static NetworkController *networkController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkController = [[self alloc] init];
    });
    return networkController;
}

- (void) searchForQuestionsWithTag: (NSString *) tag withURL: (NSString *) url withCompletionHandler: (void (^)(NSString *, NSMutableArray *))completionHandler; {
    NSString *requestURLString;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"OAuthToken"] isKindOfClass:[NSString class]]) {
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"OAuthToken"];
        requestURLString = [NSString stringWithFormat: @"%@&tagged=%@&access_token=%@&key=%@", url, tag, token, publicKey];
    } else {
        requestURLString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=%@&site=stackoverflow", tag];
    }
    NSLog(@"%@",requestURLString);
    NSURL *requestURL = [NSURL URLWithString: requestURLString];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL: requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ( [response isKindOfClass:[NSHTTPURLResponse class]] ) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if ([httpResponse statusCode] >= 200 && [httpResponse statusCode] <= 204) {
                NSMutableArray *questions = [[Question alloc] parseJSONDataIntoQuestions:data];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(nil, questions);
                }];
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(error.localizedDescription, nil);
                }];

            }
        }
    }];
    [dataTask resume];
}

- (void) searchForUsersByName: (NSString *) name withCompletionHandler: (void (^)(NSString *, NSMutableArray*)) completionHandler; {
    NSString *requestURLString;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"OAuthToken"] isKindOfClass:[NSString class]]) {
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"OAuthToken"];
        requestURLString = [NSString stringWithFormat: @"https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&inname=%@&site=stackoverflow&access_token=%@&key=%@", name, token, publicKey];
    } else {
        requestURLString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&inname=%@&site=stackoverflow", name];
    }
    NSLog(@"%@",requestURLString);
    NSURL *requestURL = [NSURL URLWithString: requestURLString];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL: requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ( [response isKindOfClass:[NSHTTPURLResponse class]] ) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if ([httpResponse statusCode] >= 200 && [httpResponse statusCode] <= 204) {
                NSMutableArray *users = [[User alloc] parseJSONDataIntoUsers:data];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(nil, users);
                }];
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(error.localizedDescription, nil);
                }];
                
            }
        }
    }];
    [dataTask resume];
}

- (void) downloadImageFromQuestionSearch: (Question *) question withCompletionHandler: (void (^) (UIImage *)) completionHandler; {
    self.imageDownloadQueue = [[NSOperationQueue alloc] init];
    [self.imageDownloadQueue addOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString: question.profileImageURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *profilePhoto = [UIImage imageWithData:imageData];
        question.profileImage = profilePhoto;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(profilePhoto);
        }];
    }];
}

- (void) downloadImageFromUserSearch: (User *) user withCompletionHandler: (void (^) (UIImage *)) completionHandler; {
    self.imageDownloadQueue = [[NSOperationQueue alloc] init];
    [self.imageDownloadQueue addOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString: user.profileImageURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *profilePhoto = [UIImage imageWithData:imageData];
        user.profileImage = profilePhoto;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(profilePhoto);
        }];
    }];
}
@end