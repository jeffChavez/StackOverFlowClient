//
//  WebViewController.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/11/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "Constants.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginURL = [NSString stringWithFormat:@"https://stackexchange.com/oauth/dialog?client_id=%@&redirect_uri=https://stackexchange.com/oauth/login_success&scope=read_inbox", clientID];
    
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    self.webView.frame = self.view.frame;
    [self.view addSubview: self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loginURL]] ];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSObject *request = navigationAction.request.URL.description;
    NSString *urlString = (NSString *) request;
    NSLog(@"%@",urlString);
    
    if ([urlString containsString:@"access_token"]) {
        NSString *tokenFromURL = [urlString componentsSeparatedByString:@"&"].firstObject;
        tokenFromURL = [tokenFromURL componentsSeparatedByString:@"="].lastObject;
        NSLog(@"%@",tokenFromURL);
        [[NSUserDefaults standardUserDefaults] setValue:tokenFromURL forKey:@"OAuthToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"Authentication Complete" message: @"Your authentication was successful" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
