//
//  QuestionCell.h
//  StackOFClient
//
//  Created by Jeff Chavez on 11/11/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView  *profileImageView;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@end
