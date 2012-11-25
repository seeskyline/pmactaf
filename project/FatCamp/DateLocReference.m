//
//  DateLocReference.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-22.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "DateLocReference.h"
#import "NSDateFormatter+MyDateFormatter.h"
#import "NSDate+MyDate.h"

@implementation DateLocReference

@synthesize mStartLoc;
@synthesize mEndLoc;
@synthesize mStartDate;
@synthesize mEndDate;
@synthesize mNumMajorTicks;
@synthesize mNumMinorTicksPerMajorInterval;
@synthesize mLabelTextStyle;

@synthesize mXLocDelta;
@synthesize mXDateDelta;

- (void) dealloc
{
    self.mLabelTextStyle = nil;
    
    [super dealloc];
}


- (void) prepareDeltaValue
{
    self.mXLocDelta = (mEndLoc-mStartLoc)/(mNumMajorTicks-1);

    NSTimeInterval sTimeIntervalRange = [mEndDate timeIntervalSince1970]- [mStartDate timeIntervalSince1970];
    
    NSInteger sDaysDelta = (sTimeIntervalRange)/(SECONDS_FOR_ONE_DAY*(mNumMajorTicks-1));
    if (sDaysDelta*(mNumMajorTicks-1) < sTimeIntervalRange)
    {
        sDaysDelta++;
    }
    
    if (sDaysDelta <= 0)
    {
        sDaysDelta = 1;
    }
    
    //adjust the sXdataDelta to ensure the daysDelta between major ticks is even number.
    if (sDaysDelta%2 != 0)
    {
        sDaysDelta++;
    }
    

    
    self.mXDateDelta = sDaysDelta*SECONDS_FOR_ONE_DAY;
}

- (BOOL) invalid
{
    if (mStartLoc >= mEndLoc
        || [mStartDate timeIntervalSince1970] >= [mEndDate timeIntervalSince1970])
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

- (BOOL) dateInRange:(NSDate*)aDate
{  
    NSComparisonResult sC1 = [self.mStartDate compareByDay:aDate];
    NSComparisonResult sC2 = [aDate compareByDay:self.mEndDate];
    
    if ((sC1 == NSOrderedSame || sC1 == NSOrderedAscending)
        && (sC2 == NSOrderedSame || sC2 == NSOrderedAscending))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
//    //!!! timeInterval comparison cannot produce satisfactory results due to precision granularity reasons.
//    if ([aDate timeIntervalSinceDate:self.mStartDate] >= 0
//        && [aDate timeIntervalSinceDate:self.mEndDate] <= 0)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

- (NSDate*) getDateByLoc:(CGFloat)aLoc
{
    if ([self invalid]
        || ![self locInRange:aLoc])
    {
        return nil;
    }
    
    CGFloat sLocOffset = aLoc-self.mStartLoc;
    CGFloat sPercent = sLocOffset/self.mXLocDelta;
    
    NSTimeInterval sTimeIntervalOffset = sPercent*self.mXDateDelta;
    NSDate* sDate = [self.mStartDate dateByAddingTimeInterval:sTimeIntervalOffset];

    return sDate;
}

- (CGFloat) getLocByDate:(NSDate*)aDate
{
    if ([self invalid]
        || ![self dateInRange:aDate])
    {
        return CGFLOAT_MIN;
    }
    NSTimeInterval sTimeIntervalOffset = [aDate timeIntervalSinceDate:self.mStartDate];
    CGFloat sPercent = (CGFloat)sTimeIntervalOffset/self.mXDateDelta;
    
    CGFloat sLocOffset = sPercent*self.mXLocDelta;
    CGFloat sXLoc = self.mStartLoc+sLocOffset;
    
    return sXLoc;
}

- (BOOL) getAxisInfoLabels:(NSMutableSet**)aLabels aMajroTickLocs:(NSMutableSet**)aMajorTickLocs aMinorTickLocs:(NSMutableSet**)aMinorTickLocs;
{
    if (mStartLoc == mEndLoc
        || [mStartDate timeIntervalSince1970] == [mEndDate timeIntervalSince1970]
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
    
    CGFloat sXLoc = mStartLoc;
    NSDate* sXDate = mStartDate;
    
  
    
    CGFloat sMinLoc = sXLoc+mXLocDelta/2;
    NSDate* sNowDate = [NSDate date];
    for (NSInteger i=1; i<=mNumMajorTicks; i++)
    {
        NSString* sLabelText;
        if ([sXDate isSameDayWith:sNowDate])
        {
            sLabelText = NSLocalizedString(@"today", nil);
        }
        else
        {
            sLabelText= [[[[NSDateFormatter alloc]init]autorelease]standardMDFormatedString:sXDate];
        }
        CPTAxisLabel* sLabel = [[[CPTAxisLabel alloc] initWithText:sLabelText  textStyle:self.mLabelTextStyle] autorelease];
        sLabel.tickLocation = CPTDecimalFromCGFloat(sXLoc);
        sLabel.offset = 4.0f;

        if (sLabel) {
            [*aLabels addObject:sLabel];
            [*aMajorTickLocs addObject:[NSNumber numberWithFloat:sXLoc]];
            [*aMinorTickLocs addObject:[NSNumber numberWithFloat:sMinLoc]];
        }
        sXLoc += mXLocDelta;
        sMinLoc += mXLocDelta;
        sXDate = [sXDate dateByAddingTimeInterval:mXDateDelta];
    }

    return YES;
}

@end
