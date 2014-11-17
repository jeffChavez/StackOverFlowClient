//
//  SearchFilterViewController.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/16/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "SearchFilterViewController.h"
#import "QuestionSearchViewController.h"

@interface SearchFilterViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *saveButton;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cells;

@end

@implementation SearchFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.headerView.backgroundColor = self.tableView.backgroundColor;
    self.saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(willSave:)];
    self.navigationItem.rightBarButtonItem = self.saveButton;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (UITableViewCell *otherCells in self.cells) {
        otherCells.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        
    }
}

- (void) willSave: (id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
