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

@property (nonatomic, weak) IBOutlet UIProgressView *progressBarView;

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
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view bringSubviewToFront:self.progressBarView];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"] && [object isKindOfClass:[WKWebView class]]) {
        if (self.progressBarView) {
            NSLog(@"progress: %f", self.webView.estimatedProgress);
            
            self.progressBarView.progress = self.webView.estimatedProgress;
            
            if (self.progressBarView.progress >= 1) {
                self.progressBarView.hidden = YES;
            } else {
                self.progressBarView.hidden = NO;
            }
        }
    }
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
}

@end
