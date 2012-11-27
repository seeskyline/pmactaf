//
//  RoundInfo.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-24.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "RoundInfo.h"

#import "StoreManager.h"
#import "NSDate+MyDate.h"
#import "CoreData.h"

@interface RoundInfo()
{
    NSInteger mRoundID;
    NSDate* mStartDate;
    NSDate* mEndDate;
    double mTargetWeight;
    
    ENUM_ROUND_STATUS mStatus;
}

@end



@implementation RoundInfo

@synthesize mRoundID;
@synthesize mStartDate;
@synthesize mEndDate;
@synthesize mTargetWeight;
@synthesize mStatus;

- (BOOL) isUnderway
{
    return (self.mStatus == ENUM_ROUND_STATUS_UNDERWAY);
}

- (BOOL) updateStatusIfNecessary
{
    if (self.mStatus == ENUM_ROUND_STATUS_UNDERWAY)
    {
        NSDate* sNowDate = [NSDate date];
        NSComparisonResult sComparisonResult = [self.mEndDate compareByDay:sNowDate];
        
        ENUM_ROUND_STATUS sNewRoundStatus = ENUM_ROUND_STATUS_UNDERWAY;
        if ( sComparisonResult == NSOrderedAscending)
        {
            double sWeightOfDayBeforeEndDate = [[CoreData getInstance] getLastWeightBeforeDayOfDate:self.mEndDate];
//            double sWeightOfDayBeforeEndDate = [StoreManager getLastWeightBeforeDate:self.mEndDate];
            if (-1 != sWeightOfDayBeforeEndDate)
            {
                if (sWeightOfDayBeforeEndDate <= self.mTargetWeight)
                {
                    sNewRoundStatus = ENUM_ROUND_STATUS_DONE_SUCCESS;
                }
                else
                {
                    sNewRoundStatus = ENUM_ROUND_STATUS_DONE_FAILURE;
                }
            }

        }
        else if (sComparisonResult == NSOrderedSame)
        {
            double sWeightOfEndDay = [StoreManager getWeightByDate:self.mEndDate];
            if (-1 != sWeightOfEndDay)
            {
                if (sWeightOfEndDay <= self.mTargetWeight)
                {
                    sNewRoundStatus = ENUM_ROUND_STATUS_DONE_SUCCESS;
                }
                else
                {
                    sNewRoundStatus = ENUM_ROUND_STATUS_DONE_FAILURE;
                }
            }
        }
        else
        {
            //nothing done here.
        }
        
        if (sNewRoundStatus != self.mStatus)
        {
            self.mStatus = sNewRoundStatus;
            [StoreManager UpdateROundStatus:sNewRoundStatus RoundID:self.mRoundID];
            
            return YES;
        }
    }
    
    return NO;
}

@end
