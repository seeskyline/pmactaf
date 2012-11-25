//
//  CoreData.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-12.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DateWeight.h"
#import "RoundInfo.h"
#import "UserInfo.h"

@interface CoreData : NSObject


+ (CoreData*) getInstance;


- (DateWeight*) getInitDateWeight;
- (DateWeight*) getLastRecorededDateWeight;
//- (DateWeight*) getTargetDateWeight;

- (NSInteger) getDaysPassed;
//- (NSInteger) getDaysRemains;
- (CGFloat) getUnwantedWeight;

//test
- (void) doSomething;

- (double) getWeightByDate:(NSDate*)aDate;
- (double) getLastWeightBeforeDate:(NSDate*)aDate;
- (DateWeight*) getLastDateWeightBeforeDate:(NSDate*)aDate;

- (NSMutableArray*) getRecentWeightsForDays:(NSInteger)aNumOfDays;
- (NSMutableArray*)getRecentWeightsForDays:(NSInteger)aNumOfDays aFirstWeight:(CGFloat*)aFirstWeight aOutMaxWeight:(CGFloat*)aOutMaxWeight aOutMinWeight:(CGFloat*)aOutMinWeight;

- (DateWeight*) getFirstDateWeighOfThisMonth;
- (NSMutableArray*) getWeightsOfThisMonth;
- (NSMutableArray*) getWeightsFromStartDate:(NSDate*)aStartDate aEndDateIncluded:(NSDate*)aEndDateIncluded;
- (NSMutableArray*) getWeightsFromStartDateSelfIncluded:(NSDate*)aStartDateSelfIncluded aEndDateIncludedSelfIncluded:(NSDate*)aEndDateIncludedSelfIncluded aFirstWeight:(CGFloat*)aFirstWeight aOutMaxWeight:(CGFloat*)aOutMaxWeight aOutMinWeight:(CGFloat*)aOutMinWeight;

- (RoundInfo*) getLastRound;
- (NSMutableArray*) getAllRounds;

- (UserInfo*) getUserInfo;

@end
