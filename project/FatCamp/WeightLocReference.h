//
//  WeightLocReference.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-22.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPTXYAxis.h"
#import "CPTMutableTextStyle.h"
#import "CorePlot-CocoaTouch.h"

@interface WeightLocReference : NSObject
{
    double mMinWeight;
    double mMaxWeight;
    
    CGFloat mStartLoc;
    CGFloat mEndLoc;
    double mStartWeight;
    double mEndWeight;
    
    
    NSInteger mNumMajorTicks;
    NSInteger mNumMinorTicksPerMajorInterval;
    CPTMutableTextStyle* mLabelTextStyle;
    
    CGFloat mYLocDelta;
    double mYWeightDelta;

}

@property (nonatomic, assign) CGFloat mStartLoc;
@property (nonatomic, assign) CGFloat mEndLoc;
@property (nonatomic, assign) double mStartWeight;
@property (nonatomic, assign) double mEndWeight;

@property (nonatomic, assign) double mMinWeight;
@property (nonatomic, assign) double mMaxWeight;

@property (nonatomic, assign) NSInteger mNumMajorTicks;
@property (nonatomic, assign) NSInteger mNumMinorTicksPerMajorInterval;
@property (nonatomic, copy) CPTMutableTextStyle* mLabelTextStyle;
@property (nonatomic, assign) CGFloat mYLocDelta;
@property (nonatomic, assign) double mYWeightDelta;

- (CGFloat) getWeightByLoc:(CGFloat)aLoc;
- (CGFloat) getLocByWeight:(CGFloat)aWeight;
- (BOOL) getAxisInfoLabels:(NSMutableSet**)aLabels aMajroTickLocs:(NSMutableSet**)aMajorTickLocs aMinorTickLocs:(NSMutableSet**)aMinorTickLocs;

- (void) prepareDeltaValue;
@end
