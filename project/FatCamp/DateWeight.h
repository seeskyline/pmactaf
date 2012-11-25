//
//  DateWeight.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-12.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface DateWeight : NSObject

@property (nonatomic, assign) NSInteger mDWID;
@property (nonatomic, retain) NSDate* mDate;
@property (nonatomic, assign) CGFloat mWeight;

- (id) initWithDate: (NSDate*)aDate;
- (id) initWithDate: (NSDate*)aDate Weight:(CGFloat)aWeight;

@end
