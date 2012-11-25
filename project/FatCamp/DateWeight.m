//
//  DateWeight.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-12.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "DateWeight.h"

@interface DateWeight()
{
    NSInteger mDWID;
    NSDate* mDate;
    CGFloat mWeight;
}

@end


@implementation DateWeight

@synthesize mDWID;
@synthesize mDate;
@synthesize mWeight;

- (id) initWithDate: (NSDate*)aDate
{
    return [self initWithDate:aDate Weight:-1];
}

- (id) initWithDate: (NSDate*)aDate Weight:(CGFloat)aWeight
{
    self = [super init];
    if (self)
    {
        self.mDate = aDate;
        self.mWeight = aWeight;
    }
    return self;
}

- (void) dealloc
{
    self.mDate = nil;
    
    [super dealloc];
}


@end
