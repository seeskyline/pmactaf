//
//  UserInfo.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-30.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateWeight.h"

@interface UserInfo : NSObject
{
    NSInteger mUserID;
    NSString* mName;
    BOOL mIsFemale;
    NSInteger mAge;
    
    DateWeight* mNewDateWeight;
    CGFloat mWeight;
    CGFloat mHeight;
    
    NSString* mEmail;
}

@property (nonatomic, assign) NSInteger mUserID;
@property (nonatomic, retain) NSString* mName;
@property (nonatomic, assign) BOOL mIsFemale;
@property (nonatomic, assign) NSInteger mAge;


@property (nonatomic, assign) CGFloat mHeight;
@property (nonatomic, assign) CGFloat mWeight;
@property (nonatomic, retain) DateWeight* mNewDateWeight;

@property (nonatomic, retain) NSString* mEmail;

@end
