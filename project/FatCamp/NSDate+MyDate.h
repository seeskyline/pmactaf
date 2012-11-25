//
//  NSDate+MyDate.h
//  AboutSex
//
//  Created by Shane Wen on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SECONDS_FOR_ONE_DAY       (24*60*60)
#define SECONDS_FOR_ONE_MINUTE    (60)
#define SECONDS_FOR_ONE_HOUR      (60*60)

@interface NSDate (MyDate)

- (BOOL) isSameDayWith:(NSDate*)aDate;
- (BOOL) isSameMonth:(NSDate*)aDate;

- (NSComparisonResult) compareByDay:(NSDate*)aDate;

- (BOOL) isInRecentDaysBefore: (NSDate*)sCurDate NumberOfDays:(NSInteger)aNumberOfDays;

- (NSDate*) startDateOfTheDayinLocalTimezone;
- (NSDate*) endDateOfTheDayinLocalTimezone;

- (NSInteger) ceilingDaysSinceStartingOfDate:(NSDate*)aDate;
- (NSInteger) daysSinceStartingOfDate:(NSDate*)aDate;

- (NSDate*) beginningOfFirstDayOfMonthInLocalZone;

- (NSDate*) beginningOfLastDayOfMonthInLocalZone;

- (NSDate*) beginningOfLastYearInLocalZone;
- (NSDate*) endOfNextYearInLocalZone;
- (NSDate*) monthOffset:(NSInteger)aOffset;

- (BOOL) isToday;
@end
