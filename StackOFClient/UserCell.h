//
//  UserCell.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/15/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView  *profileImageView;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;

@end
