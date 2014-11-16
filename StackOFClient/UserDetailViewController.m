//
//  UserDetailViewController.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/15/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "UserDetailViewController.h"
#import <WebKit/WebKit.h>

@interface UserDetailViewController ()

@property WKWebView *webView;

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = self.view.frame;
    [self.view addSubview: self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.selectedUser.link]]];
}

@end
