//
//  QuestionDetailViewController.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/11/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Question.h"

@interface QuestionDetailViewController : UIViewController

@property QuestionDetailViewController *QuestionDetailViewController;
@property WKWebView *webView;
@property Question *selectedQuestion;

@end
