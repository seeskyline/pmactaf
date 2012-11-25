//
//  CoreData.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-12.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "CoreData.h"
#import "DateWeight.h"
#import "NSDate+MyDate.h"
#import "StoreManager.h"

static CoreData* singleton = nil;

@interface CoreData ()
{
    CGFloat mTargetWeight;
    NSMutableArray* mWeightArray;   //hold all weight info from start day to end day set by user.
    NSInteger mIndexOfLastRecordedDateWeight;
    
    
}

@property (nonatomic, assign) CGFloat mTargetWeight;
@property (nonatomic, retain) NSMutableArray* mWeightArray;
@property (nonatomic, assign) NSInteger mIndexOfLastRecordedDateWeight;
@end



@implementation CoreData

@synthesize mTargetWeight;
@synthesize mWeightArray;
@synthesize mIndexOfLastRecordedDateWeight;

+ (CoreData*) getInstance
{
    if (!singleton)
    {
        singleton = [[CoreData alloc] initFromFile];
    }
    
    return singleton;
}

- (id) initFromFile
{
    self = [super init];
    if (self)
    {
        self.mWeightArray = [[[NSMutableArray alloc]initWithCapacity:20] autorelease];
        [self initData];
//        [self doSomething];
    }
    
    return self;
}

- (void)dealloc
{
    self.mWeightArray = nil;
    
    [super dealloc];
}

- (BOOL) initData
{
    //-test
    self.mTargetWeight = 54.0;
    self.mIndexOfLastRecordedDateWeight = 13;
    
    NSTimeInterval sTimeIntervalOfStartDate = 1350031038.973512-13*SECONDS_FOR_ONE_DAY;
    NSDate* sDate = [NSDate dateWithTimeIntervalSince1970:sTimeIntervalOfStartDate];
    
    DateWeight* sDateWeight;
    
    //9-29
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.7] autorelease];
    [self.mWeightArray addObject:sDateWeight];
    
 //9-30
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.7] autorelease];
    [self.mWeightArray addObject:sDateWeight];
    
 //10-1
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.5] autorelease];
    [self.mWeightArray addObject:sDateWeight];
    
 //10-2
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.4] autorelease];
    [self.mWeightArray addObject:sDateWeight];
    
//10-3
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.5] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-4
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.5] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-5
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-6
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-7
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:57.7] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-8
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:57.7] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-9
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:57.6] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-10
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-11
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:57.3] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-12
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:57.2] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-13
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate] autorelease];
    [self.mWeightArray addObject:sDateWeight];

    //10-14
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate] autorelease];
    [self.mWeightArray addObject:sDateWeight];    
    
    
    
    //-test
    
    return YES;
}

- (DateWeight*) getInitDateWeight
{
    if (!self.mWeightArray
       || [self.mWeightArray count]<=0)
    {
        return nil;
    }
    
    return (DateWeight*)[self.mWeightArray objectAtIndex:0];

}

- (DateWeight*) getLastRecorededDateWeight
{
    return [StoreManager getMostRecentDateWeight];
}

//- (DateWeight*) getTargetDateWeight
//{
////    NSInteger sLenOfWeightArray = [self.mWeightArray count];
////    if (!self.mWeightArray
////        || sLenOfWeightArray <= 1)
////    {
////        return nil;
////    }
////
////    NSDate* sTargetDate = ((DateWeight*)[self.mWeightArray objectAtIndex:sLenOfWeightArray-1]).mDate;
////    DateWeight* sTargetDateWeigh = [[[DateWeight alloc]initWithDate:sTargetDate Weight:self.mTargetWeight]autorelease];
////    return sTargetDateWeigh;
//}
//
- (NSInteger) getDaysPassed
{
    NSDate* sInitDate = [self getInitDateWeight].mDate;
    NSDate* sNowDate = [NSDate date];
    
    NSInteger sDaysPassed = [sNowDate ceilingDaysSinceStartingOfDate:sInitDate];
    
    if (sDaysPassed<0)
    {
        return 0;
    }
    
    return sDaysPassed;
}

//- (NSInteger) getDaysRemains
//{
//    NSDate* sTargetDate = [self getTargetDateWeight].mDate;
//    NSDate* sNowDate = [NSDate date];
//    
//    NSInteger sDaysRemains = [sTargetDate ceilingDaysSinceStartingOfDate:sNowDate];
//    
//    if (sDaysRemains<0)
//    {
//        return 0;
//    }
//    
//    return sDaysRemains;
//}

- (CGFloat) getUnwantedWeight
{
    CGFloat sWeightRecordedLast = [self getLastRecorededDateWeight].mWeight;
    CGFloat sTargetWeight = self.mTargetWeight;
    
    CGFloat sUnwantedWeight = sWeightRecordedLast-sTargetWeight;
    
    if (sUnwantedWeight < 0)
    {
        sUnwantedWeight = 0;
    }
    
    return sUnwantedWeight;
}

- (void) doSomething
{
    [StoreManager addOrUpdateUserInfoWithMail:@"shanewen@qq.com" aName:@"shanewen" aIsFemale:YES aAge:18 aHeight:165 aWeight:50.1f];
    
    //update weights
    NSTimeInterval sTimeIntervalOfStartDate = 1350031038.973512-23*SECONDS_FOR_ONE_DAY;
    NSDate* sDate = [NSDate dateWithTimeIntervalSince1970:sTimeIntervalOfStartDate];
    
    DateWeight* sDateWeight;

     //9-19
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-20
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-21
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.5] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-22
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-23
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-24
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-25
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:59] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-26
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-27
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-28
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //9-29
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    //9-30
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-1
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-2
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-3
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-4
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-5
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-6
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-7
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.5] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-8
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-9
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.5] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-10
//    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
//    sDateWeight = [[[DateWeight alloc] initWithDate:sDate] autorelease];
//    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-11
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-12
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:52.0] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-13
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-14
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
 
    //10-15
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-16   
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.5] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    
    //10-17
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.0] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    
    //10-18
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.6] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-19
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58.6] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
//    //10-20
//    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
//    sDateWeight = [[[DateWeight alloc] initWithDate:sDate] autorelease];
//    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
    
    //10-21
    sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY*4];
    sDateWeight = [[[DateWeight alloc] initWithDate:sDate Weight:58] autorelease];
    [StoreManager addOrUpdateWeight:sDateWeight.mWeight aDate:sDateWeight.mDate];
        
    //update rounds
    NSTimeInterval sTimeIntervalOfStartDate2 = 1350031038.973512-13*SECONDS_FOR_ONE_DAY;
    NSDate* sStartDate = [NSDate dateWithTimeIntervalSince1970:sTimeIntervalOfStartDate2];
    NSDate* sEndDate = sDate;
    CGFloat sTargetWeight = 54.0;
    ENUM_ROUND_STATUS sRoundStatus = ENUM_ROUND_STATUS_DONE_FAILURE;
    
    [StoreManager addRoundInfoWithStartTime:sStartDate aEndTime:sEndDate aTargetWeight:sTargetWeight aStatus:sRoundStatus];
    
    return;
}

- (double) getWeightByDate:(NSDate*)aDate
{
    return [StoreManager getWeightByDate:aDate];
}

- (double) getLastWeightBeforeDate:(NSDate*)aDate
{
    return [StoreManager getLastWeightBeforeDate:aDate];
}

- (DateWeight*) getLastDateWeightBeforeDate:(NSDate*)aDate
{
    return [StoreManager getLastDateWeightBeforeDate:aDate];
}

- (NSMutableArray*) getRecentWeightsForDays:(NSInteger)aNumOfDays
{    
    return [self getRecentWeightsForDays:aNumOfDays aFirstWeight:nil aOutMaxWeight:nil aOutMinWeight:nil];
}

- (NSMutableArray*)getRecentWeightsForDays:(NSInteger)aNumOfDays aFirstWeight:(CGFloat*)aFirstWeight aOutMaxWeight:(CGFloat*)aOutMaxWeight aOutMinWeight:(CGFloat*)aOutMinWeight;
{
    if (aNumOfDays < 1)
    {
        return nil;
    }
    
    return [StoreManager getRecentWeightsForDays:aNumOfDays aFirstWeight:aFirstWeight aOutMaxWeight:aOutMaxWeight aOutMinWeight:aOutMinWeight];
}

- (DateWeight*) getFirstDateWeighOfThisMonth
{
    NSDate* sNowDate = [NSDate date];
    NSDate* sBeginningDateOfThisMonth = [sNowDate beginningOfFirstDayOfMonthInLocalZone];

    return [StoreManager getFirstDateWeighSinceDate:sBeginningDateOfThisMonth];
}

- (NSMutableArray*) getWeightsOfThisMonth
{
    NSDate* sNowDate = [NSDate date];
    NSDate* sBeginningDateOfThisMonth = [sNowDate beginningOfFirstDayOfMonthInLocalZone];
    
    return [self getWeightsFromStartDate:sBeginningDateOfThisMonth aEndDateIncluded:sNowDate];
}

- (NSMutableArray*) getWeightsFromStartDate:(NSDate*)aStartDate aEndDateIncluded:(NSDate*)aEndDateIncluded
{
    return [self getWeightsFromStartDateSelfIncluded:aStartDate aEndDateIncludedSelfIncluded:aEndDateIncluded aFirstWeight:nil aOutMaxWeight:nil aOutMinWeight:nil];
}

- (NSMutableArray*) getWeightsFromStartDateSelfIncluded:(NSDate*)aStartDateSelfIncluded aEndDateIncludedSelfIncluded:(NSDate*)aEndDateIncludedSelfIncluded aFirstWeight:(CGFloat*)aFirstWeight aOutMaxWeight:(CGFloat*)aOutMaxWeight aOutMinWeight:(CGFloat*)aOutMinWeight
{
    return [StoreManager getWeightsFromStartDateSelfIncluded:aStartDateSelfIncluded aEndDateSelfIncluded:aEndDateIncludedSelfIncluded aFirstWeight:aFirstWeight aOutMaxWeight:aOutMaxWeight aOutMinWeight:aOutMinWeight];
}

- (RoundInfo*) getFakeLastRound
{
    RoundInfo* sRoundInfo = [[[RoundInfo alloc] init] autorelease];
    sRoundInfo.mStartDate = [[NSDate date] dateByAddingTimeInterval:-10*SECONDS_FOR_ONE_DAY];
    sRoundInfo.mEndDate = [[NSDate date] dateByAddingTimeInterval:3*SECONDS_FOR_ONE_DAY];
    sRoundInfo.mTargetWeight = 45.2f;
    sRoundInfo.mStatus = ENUM_ROUND_STATUS_UNDERWAY;
    sRoundInfo.mRoundID = 1000;
    
    return sRoundInfo;
}

- (RoundInfo*) getLastRound
{
    return [StoreManager getLastRound];
    //test
//    return [self getFakeLastRound];
    //test
}

- (NSMutableArray*) getAllRounds
{
    return [StoreManager getAllRounds];
}


- (UserInfo*) getUserInfo
{
    UserInfo* sUserInfo = [StoreManager getUserInfo];
    return sUserInfo;
}

@end
