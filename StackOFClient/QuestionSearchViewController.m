//
//  QuestionSearchViewController.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "NetworkController.h"
#import "Question.h"

@interface QuestionSearchViewController ()

@end

@implementation QuestionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QUESTION_CELL" forIndexPath:indexPath];
    
    Question *currentQuestion = self.questions[indexPath.row];
    cell.textLabel.text = currentQuestion.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questions.count;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [[NetworkController networkController] searchForQuestionsWithTag:searchBar.text withCompletionHandler:^(NSString *errorDescription, NSMutableArray *questions) {
        if (!errorDescription) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.questions = questions;
                [self.tableView reloadData];
            }];
        }
    }];
}
@end
