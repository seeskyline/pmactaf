//
//  WeightLocReference.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-22.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "WeightLocReference.h"
//#import "CPTAxisLabel.h"

@implementation WeightLocReference

@synthesize mMinWeight;
@synthesize mMaxWeight;

@synthesize mStartLoc;
@synthesize mEndLoc;
@synthesize mStartWeight;
@synthesize mEndWeight;
@synthesize mNumMajorTicks;
@synthesize mNumMinorTicksPerMajorInterval;
@synthesize mLabelTextStyle;

@synthesize mYLocDelta;
@synthesize mYWeightDelta;

- (void) dealloc
{
    self.mLabelTextStyle = nil;
    
    [super dealloc];
}

- (void) prepareDeltaValue
{
    NSInteger sNumOfSeg = self.mNumMajorTicks-1;
    self.mYLocDelta = (self.mEndLoc-self.mStartLoc)/sNumOfSeg;

    [self setWeightRangeAndDelta];
}

- (void) setWeightRangeAndDelta
{
    
    NSInteger sMinWeight = floor(self.mMinWeight);
    NSInteger sMaxWeight = ceil(self.mMaxWeight);
        
    
    self.mStartWeight = sMinWeight;
    
    double sDelta = (sMaxWeight-self.mStartWeight)/(self.mNumMajorTicks-1);
    
    if (0 == sDelta)
    {
        sDelta = 1;
    }
    
    self.mYWeightDelta = ceil(sDelta);
    self.mEndWeight = self.mStartWeight+self.mYWeightDelta*(self.mNumMajorTicks-1);
    
    return;
}


- (BOOL) invalid
{
    if (mStartLoc >= mEndLoc
        || mStartWeight >= mEndWeight)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (BOOL) locInRange:(CGFloat)aLoc
{
    if (aLoc >= mStartLoc
        && aLoc <= mEndLoc)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL) weightInRange:(CGFloat)aWeight
{
    if (aWeight >= mStartWeight
        && aWeight <= mEndWeight)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (CGFloat) getWeightByLoc:(CGFloat)aLoc
{
    if ([self invalid]
        || ![self locInRange:aLoc])
    {
        return CGFLOAT_MIN;
    }
    
    CGFloat sPercent = (aLoc-mStartLoc)/(mEndLoc-mStartLoc);
    
    CGFloat sWeight = mStartWeight+sPercent*(mEndWeight-mStartWeight);
    
    return sWeight;

}

- (CGFloat) getLocByWeight:(CGFloat)aWeight
{
    if ([self invalid]
        || ![self weightInRange:aWeight])
    {
        return CGFLOAT_MIN;
    }
    
    CGFloat sPercent = (aWeight-mStartWeight)/(mEndWeight-mStartWeight);
    CGFloat sLoc = mStartLoc+sPercent*(mEndLoc-mStartLoc);
    
    return sLoc;
}

- (BOOL) getAxisInfoLabels:(NSMutableSet**)aLabels aMajroTickLocs:(NSMutableSet**)aMajorTickLocs aMinorTickLocs:(NSMutableSet**)aMinorTickLocs
{
    if (mStartLoc == mEndLoc
        || mStartWeight == mEndWeight
        || mNumMajorTicks <= 0
        || !self.mLabelTextStyle)
    {
        return NO;
    }
    
    if (!aLabels || !(*aLabels)
        || !aMajorTickLocs || !(*aMajorTickLocs))
    {
        return NO;
    }
    
    CGFloat sYLoc = mStartLoc;
    NSInteger sYWeight =  mStartWeight;
    CGFloat sYLocDelta = (mEndLoc-mStartLoc)/(mNumMajorTicks-1);
    NSInteger sYWeightDelta = (mEndWeight-mStartWeight)/(mNumMajorTicks-1);
    
    for (NSInteger i=1; i<=mNumMajorTicks; i++)
    {
        NSString* sLabelText = [NSString stringWithFormat:@"%d", sYWeight];
        CPTAxisLabel* sLabel = [[[CPTAxisLabel alloc] initWithText:sLabelText  textStyle:self.mLabelTextStyle] autorelease];
        sLabel.tickLocation = CPTDecimalFromCGFloat(sYLoc);
        sLabel.offset =4;
        
        if (sLabel)
        {
            [*aLabels addObject:sLabel];
            [*aMajorTickLocs addObject:[NSNumber numberWithFloat:sYLoc]];
            for (NSInteger i=1; i<=self.mNumMinorTicksPerMajorInterval; i++)
            {
                [*aMinorTickLocs addObject:[NSNumber numberWithFloat:(sYLoc+i*(sYLocDelta/(self.mNumMinorTicksPerMajorInterval+1)))]];
            }
            
        }
        sYLoc += sYLocDelta;
        sYWeight += sYWeightDelta;
    }
    
    return YES;

}




@end

