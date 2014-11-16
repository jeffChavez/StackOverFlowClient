//
//  ViewController.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "MenuViewController.h"
#import "WebViewController.h"

@interface MenuViewController ()

@property UIBarButtonItem *loginButton;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style: UIBarButtonItemStylePlain target: self action: @selector(beginLogin:)];
    self.navigationItem.rightBarButtonItem = self.loginButton;
    
    self.title = NSLocalizedString(@"Search", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beginLogin: (id) sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebViewController *webViewController = [storyboard instantiateViewControllerWithIdentifier:@"WEB_VC"];
    [self.navigationController pushViewController:webViewController animated:true];
}

@end