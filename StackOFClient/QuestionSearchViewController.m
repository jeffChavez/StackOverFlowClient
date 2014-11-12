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
#import "QuestionDetailViewController.h"
#import "QuestionCell.h"

@interface QuestionSearchViewController ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation QuestionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QuestionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"QUESTION_CELL"];
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [self.dateFormatter setDateFormat:@"dd-MM-yy 'at' hh:mm a"];
}

- (void)viewDidAppear:(BOOL)animated {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QUESTION_CELL" forIndexPath:indexPath];
    cell.profileImageView.image = nil;
    Question *question = self.questions[indexPath.row];
    
    cell.titleLabel.text = question.title;
    cell.usernameLabel.text = question.username;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:question.timeSincePost];
    cell.timeLabel.text = [self.dateFormatter stringFromDate:date];
    
    if (question.profileImage) {
        cell.profileImageView.image = question.profileImage;
    } else {
        [[NetworkController networkController] downloadImageFromQuestionSearch:question withCompletionHandler:^(UIImage *image) {
            if ( [[self.tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[QuestionCell class]]) {
                QuestionCell *cellForImage = (QuestionCell *) [self.tableView cellForRowAtIndexPath:indexPath];
                [UIView transitionWithView:cellForImage.profileImageView duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    cellForImage.profileImageView.image = image;
                    cellForImage.profileImageView.layer.cornerRadius = 3;
                    cellForImage.profileImageView.layer.masksToBounds = YES;
                    cellForImage.profileImageView.layer.borderWidth = 0.5;
                } completion:nil];
            }
        }];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questions.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if ([segue.identifier  isEqual: @"SHOW_SELECTED_QUESTION"]) {
        QuestionDetailViewController *destination = (QuestionDetailViewController *) segue.destinationViewController;
        destination.selectedQuestion = self.questions[indexPath.row];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [[NetworkController networkController] searchForQuestionsWithTag:searchBar.text withCompletionHandler:^(NSString *errorDescription, NSMutableArray *questions) {
        if (!errorDescription) {
            self.questions = questions;
            [self.tableView reloadData];
        }
    }];
}

@end
