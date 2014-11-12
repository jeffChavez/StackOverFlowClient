//
//  QuestionDetailViewController.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/11/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import <WebKit/WebKit.h>

@interface QuestionDetailViewController ()

@end

@implementation QuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.selectedQuestion.link]] ];
    
    self.view = [[WKWebView alloc] init];
    
    // Do any additional setup after loading the view.
}

@end