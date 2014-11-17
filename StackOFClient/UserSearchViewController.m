//
//  UserSearchViewController.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/15/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "UserSearchViewController.h"
#import "UserCell.h"
#import "NetworkController.h"
#import "User.h"
#import "UserDetailViewController.h"

@interface UserSearchViewController ()

@end

@implementation UserSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.searchBar.delegate = self;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"USER_CELL" forIndexPath:indexPath];
    cell.profileImageView.image = nil;
    User *user = self.users[indexPath.row];
    cell.usernameLabel.text = user.username;
    
    if (user.profileImage) {
        cell.profileImageView.image = user.profileImage;
    } else {
        [[NetworkController networkController] downloadImageFromUserSearch:user withCompletionHandler:^(UIImage *image) {
            if ( [[self.collectionView cellForItemAtIndexPath:indexPath] isKindOfClass:[UserCell class]]) {
                UserCell *cellForImage = (UserCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.users.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[ NSBundle mainBundle]];
    UserDetailViewController *newVC = [storyboard instantiateViewControllerWithIdentifier:@"USER_DETAIL_VC"];
    [self.navigationController pushViewController:newVC animated:YES];
    newVC.selectedUser = self.users[indexPath.row];

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [[NetworkController networkController] searchForUsersByName:searchBar.text withCompletionHandler:^(NSString *errorDescription, NSMutableArray *users) {
        if (!errorDescription) {
            self.users = users;
            [self.collectionView reloadData];
        }
    }];
    [searchBar performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0.1];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
