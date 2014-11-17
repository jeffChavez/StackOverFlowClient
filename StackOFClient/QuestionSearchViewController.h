//
//  QuestionSearchViewController.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionSearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *questions;

@end
