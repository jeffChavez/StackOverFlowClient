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
#import <NSString+HTML.h>

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

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QUESTION_CELL" forIndexPath:indexPath];
    cell.profileImageView.image = nil;
    Question *question = self.questions[indexPath.row];
    cell.answerCountLabel.text = [NSString stringWithFormat:@"%ld views", (long)question.viewCount];
    if ([cell.answerCountLabel.text  isEqual: @"1 views"]) {
        cell.answerCountLabel.text = @"1 view";
    }
    cell.scoreLabel.text = [NSString stringWithFormat:@"%ld answers", (long)question.answerCount];
    if ([cell.answerCountLabel.text  isEqual: @"1 answers"]) {
        cell.answerCountLabel.text = @"1 answer";
    }
    cell.titleLabel.text = [question.title kv_decodeHTMLCharacterEntities];
    cell.usernameLabel.text = question.username;
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeElapsedInSeconds = [currentDate timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:question.timeSincePost]];
    NSLog(@"%f", timeElapsedInSeconds);
    if (timeElapsedInSeconds >= 120 && timeElapsedInSeconds < 60 * 60) {
        NSTimeInterval timeInMinutes = timeElapsedInSeconds / 60;
        cell.timeLabel.text = [NSString stringWithFormat:@"%.0f minutes ago", timeInMinutes];
    } else if (timeElapsedInSeconds >= 60 * 60 && timeElapsedInSeconds < 60 * 60 * 24) {
        NSTimeInterval timeInHours = timeElapsedInSeconds / 60 / 60;
        cell.timeLabel.text = [NSString stringWithFormat:@"%.0f hours ago", timeInHours];
        if ([cell.timeLabel.text isEqual: @"1 hours ago"]) {
            cell.timeLabel.text = @"1 hour ago";
        }
    } else if (timeElapsedInSeconds >= 60 * 60 * 24 && timeElapsedInSeconds < 60 * 60 * 24 * 30) {
        NSTimeInterval timeInDays = timeElapsedInSeconds / 60 / 60 / 24;
        cell.timeLabel.text = [NSString stringWithFormat:@"%.0f days ago", timeInDays];
        if ([cell.timeLabel.text isEqual: @"1 days ago"]) {
            cell.timeLabel.text = @"1 day ago";
        }
    } else if (timeElapsedInSeconds >= 60 * 60 * 24 * 30 && timeElapsedInSeconds < 60 * 60 * 24 * 30 * 12) {
        NSTimeInterval timeInMonths = timeElapsedInSeconds / 60 / 60 / 24 / 30;
        cell.timeLabel.text = [NSString stringWithFormat:@"%.0f months ago", timeInMonths];
        if ([cell.timeLabel.text isEqual: @"1 months ago"]) {
            cell.timeLabel.text = @"1 month ago";
        }
    } else if (timeElapsedInSeconds >= 60 * 60 * 24 * 30 * 12) {
        NSTimeInterval timeInYears = timeElapsedInSeconds / 60 / 60 / 24 / 30 / 12;
        cell.timeLabel.text = [NSString stringWithFormat:@"%.0f years ago", timeInYears];
        if ([cell.timeLabel.text isEqual: @"1 years ago"]) {
            cell.timeLabel.text = @"1 year ago";
        }
    } else {
        cell.timeLabel.text = @"just now";
    }

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[ NSBundle mainBundle]];
    QuestionDetailViewController *newVC = [storyboard instantiateViewControllerWithIdentifier:@"QUESTION_DETAIL_VC"];
    [self.navigationController pushViewController:newVC animated:YES];
    newVC.selectedQuestion = self.questions[indexPath.row];
    
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
