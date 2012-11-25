//
//  DateLocReference.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-22.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"


@interface DateLocReference : NSObject
{
    CGFloat mStartLoc;
    CGFloat mEndLoc;
    NSDate* mStartDate;
    NSDate* mEndDate;
    
    NSInteger mNumMajorTicks;
    NSInteger mNumMinorTicksPerMajorInterval;
    CPTMutableTextStyle* mLabelTextStyle;
    
    CGFloat mXLocDelta;
    NSTimeInterval mXDateDelta;
}

@property (nonatomic, assign) CGFloat mStartLoc;
@property (nonatomic, assign) CGFloat mEndLoc;
@property (nonatomic, retain) NSDate* mStartDate;
@property (nonatomic, retain) NSDate* mEndDate;
@property (nonatomic, assign) NSInteger mNumMajorTicks;
@property (nonatomic, assign) NSInteger mNumMinorTicksPerMajorInterval;
@property (nonatomic, copy) CPTMutableTextStyle* mLabelTextStyle;
@property (nonatomic, assign) CGFloat mXLocDelta;
@property (nonatomic, assign) NSTimeInterval mXDateDelta;

- (NSDate*) getDateByLoc:(CGFloat)aLoc;
- (CGFloat) getLocByDate:(NSDate*)aDate;
- (BOOL) getAxisInfoLabels:(NSMutableSet**)aLabels aMajroTickLocs:(NSMutableSet**)aMajorTickLocs aMinorTickLocs:(NSMutableSet**)aMinorTickLocs;

- (void) prepareDeltaValue;
@end
