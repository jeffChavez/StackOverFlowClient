//
//  User.m
//  StackOFClient
//
//  Created by Jeff Chavez on 11/10/14.
//  Copyright (c) 2014 Jeff Chavez. All rights reserved.
//

#import "User.h"

@interface User ()

@end

@implementation User

- (instancetype) initWithDictionary: (NSDictionary *) userDictionary {
    self = [super init];
    
    if (self) {
        self.username = userDictionary[@"display_name"];
        self.link = userDictionary[@"link"];
        self.bronzeBadgeCount = [[userDictionary valueForKeyPath:@"badge_counts.bronze"] integerValue];
        self.silverBadgeCount = [[userDictionary valueForKeyPath:@"badge_counts.silver"] integerValue];
        self.goldBadgeCount = [[userDictionary valueForKeyPath:@"badge_counts.gold"] integerValue];
        self.location = userDictionary[@"location"];
        self.profileImageURLString = userDictionary[@"profile_image"];
    }
    return self;
}

- (NSMutableArray *) parseJSONDataIntoUsers: (NSData *) data {
    NSError *error = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSMutableArray *itemArray = jsonDictionary[@"items"];
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (NSDictionary *item in itemArray) {
        User *newUser = [[User alloc] initWithDictionary:item];
        [users addObject:newUser];
    }
    return users;
}

@end
