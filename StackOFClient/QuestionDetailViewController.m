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

@property WKWebView *webView;
@property (nonatomic, weak) IBOutlet UIProgressView *progressBarView;

@end

@implementation QuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = self.view.frame;
    [self.view addSubview: self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.selectedQuestion.link]]];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view bringSubviewToFront:self.progressBarView];
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