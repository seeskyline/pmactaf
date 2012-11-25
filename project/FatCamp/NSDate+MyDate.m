//
//  NSDate+MyDate.m
//  AboutSex
//
//  Created by Shane Wen on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSDate+MyDate.h"


@implementation NSDate (MyDate)

- (BOOL) isSameDayWith:(NSDate*)aDate
{
    
    NSCalendar *sCalendar = [NSCalendar currentCalendar];
    
    NSTimeZone* localzone = [NSTimeZone localTimeZone];  
    [sCalendar setTimeZone:localzone];  
    
    int unit =NSMonthCalendarUnit |NSYearCalendarUnit |NSDayCalendarUnit;
    NSDateComponents *fistComponets = [sCalendar components: unit fromDate: self];
    NSDateComponents *secondComponets = [sCalendar components: unit fromDate: aDate];
    if ([fistComponets day] == [secondComponets day]
        && [fistComponets month] == [secondComponets month]
        && [fistComponets year] == [secondComponets year])
    {
        return YES;
    }
    return NO;
}

- (BOOL) isSameMonth:(NSDate*)aDate
{
    NSCalendar *sCalendar = [NSCalendar currentCalendar];
    NSTimeZone* localzone = [NSTimeZone localTimeZone];  
    [sCalendar setTimeZone:localzone];  
    
    int unit =NSMonthCalendarUnit |NSYearCalendarUnit;
    NSDateComponents *fistComponets = [sCalendar components: unit fromDate: self];
    NSDateComponents *secondComponets = [sCalendar components: unit fromDate: aDate];
    if ([fistComponets month] == [secondComponets month]
        && [fistComponets year] == [secondComponets year])
    {
        return YES;
    }
    return NO;
}

- (NSComparisonResult) compareByDay:(NSDate*)aDate
{
    NSCalendar *sCalendar = [NSCalendar currentCalendar]; 
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    [sCalendar setTimeZone:localzone];
    
    int unit = NSMonthCalendarUnit |NSYearCalendarUnit |NSDayCalendarUnit;
    NSDateComponents *fistComponets = [sCalendar components: unit fromDate: self];
    NSDateComponents *secondComponets = [sCalendar components: unit fromDate: aDate];

    if ([fistComponets year] < [secondComponets year])
    {
        return NSOrderedAscending;
    }
    else if ([fistComponets year] > [secondComponets year])
    {
        return NSOrderedDescending;
    }
    else
    {
        if ([fistComponets month] < [secondComponets month])
        {
            return NSOrderedAscending;
        }
        else if ([fistComponets month] > [secondComponets month])
        {
            return NSOrderedDescending;
        }
        else
        {
            if ([fistComponets day] < [secondComponets day])
            {
                return NSOrderedAscending;
            }
            else if ([fistComponets day] > [secondComponets day])
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedSame;
            }
        }
    }
    
}

- (BOOL) isInRecentDaysBefore: (NSDate*)sDate NumberOfDays:(NSInteger)aNumberOfDays
{
    NSTimeInterval sTimeIntervalForStartDateOfTheDay = [[sDate startDateOfTheDayinLocalTimezone] timeIntervalSince1970];
    
    
    NSTimeInterval sTimeIntervalForStartDay = sTimeIntervalForStartDateOfTheDay-(aNumberOfDays-1)*SECONDS_FOR_ONE_DAY;
    NSTimeInterval sTimeIntervalForEndDay = sTimeIntervalForStartDateOfTheDay+SECONDS_FOR_ONE_DAY; 
    
    if ([self timeIntervalSince1970] >= sTimeIntervalForStartDay
        && [self timeIntervalSince1970] <= sTimeIntervalForEndDay)
    {
        return YES;
    }
    else {
        return NO;
    }
    
}

- (NSDate*) startDateOfTheDayinLocalTimezone
{
    
    NSTimeInterval sTimeInterval = [self timeIntervalSince1970]; 
    NSInteger secondsFromGMT = [[NSTimeZone localTimeZone]secondsFromGMT];
    NSTimeInterval sRemainder = ((NSUInteger)(sTimeInterval+secondsFromGMT))%((NSUInteger)SECONDS_FOR_ONE_DAY);
    NSTimeInterval sStartTimeIntervalOfTheDay =  sTimeInterval- sRemainder;
    NSDate* sDate = [NSDate dateWithTimeIntervalSince1970:sStartTimeIntervalOfTheDay];

    return sDate;
}

- (NSDate*) endDateOfTheDayinLocalTimezone
{
    NSDate* sStartDateofTheDayInLocalTimeZone = [self startDateOfTheDayinLocalTimezone];
    NSDate* sDate = [sStartDateofTheDayInLocalTimeZone dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY-1];
    
    return sDate;
}


- (NSInteger) daysSinceStartingOfDate:(NSDate*)aDate
{
//    NSDate* sStartingOfDate = [aDate startDateOfTheDayinLocalTimezone];
    NSTimeInterval sTimeInterval = [self timeIntervalSinceDate:aDate];
    
    NSInteger sDays = round(sTimeInterval/((CGFloat)(SECONDS_FOR_ONE_DAY)));
    return sDays;

}

- (NSInteger) ceilingDaysSinceStartingOfDate:(NSDate*)aDate
{
    NSDate* sStartingOfDate = [aDate startDateOfTheDayinLocalTimezone];
    NSTimeInterval sTimeInterval = [self timeIntervalSinceDate:sStartingOfDate];
    
    NSInteger sDays = ceil(sTimeInterval/((CGFloat)(SECONDS_FOR_ONE_DAY)));
    return sDays;
}


- (NSDate*) beginningOfFirstDayOfMonthInLocalZone
{
    
    NSDateComponents* sComps = [self getYMDComponents];

    [sComps setDay:1];
    NSDate* sBeginningOfFirstDayOfMonth = [[NSCalendar currentCalendar] dateFromComponents:sComps];

    return sBeginningOfFirstDayOfMonth;
}

- (NSDate*) beginningOfLastDayOfMonthInLocalZone
{
    NSDateComponents* sComps = [self getYMDComponents];

    [sComps setMonth:sComps.month+1];
    [sComps setDay:1];
    
    NSDate* sBeginningOfLastDayOfMonth = [[[NSCalendar currentCalendar] dateFromComponents:sComps] dateByAddingTimeInterval:-(SECONDS_FOR_ONE_DAY)];
    
    return sBeginningOfLastDayOfMonth;

}

- (NSDate*) beginningOfLastYearInLocalZone
{
    NSDateComponents* sComps = [self getYMDComponents];
 
    [sComps setYear:sComps.year-1];
    [sComps setMonth:1];
    [sComps setDay:1];
    
    NSDate* sBeginningOfLastYear =[[NSCalendar currentCalendar] dateFromComponents:sComps];

    return sBeginningOfLastYear;
}

- (NSDate*) endOfNextYearInLocalZone
{
    NSDateComponents* sComps = [self getYMDComponents];
    
    [sComps setYear:sComps.year+2];
    [sComps setMonth:1];
    [sComps setDay:1];
    
    NSDate* sEndOfNextYear =[[[NSCalendar currentCalendar] dateFromComponents:sComps] dateByAddingTimeInterval:-(SECONDS_FOR_ONE_DAY)];
    
    return sEndOfNextYear;
}

//just add monthoffset, ignoring the different days (29, 30, 31)in different month issue.
- (NSDate*) monthOffset:(NSInteger)aOffset
{
    NSDateComponents* sComps = [self getYMDComponents];
    NSInteger month = [sComps month];
    NSInteger year = [sComps year];
    
    // now calculate the new month and year values
    NSInteger newMonth = month + aOffset;
    
    // deal with overflow/underflow
    NSInteger newYear = year + newMonth / 12;
    newMonth = newMonth % 12;
    
    // month is 1-based, so if we've ended up with the 0th month,
    // make it the 12th month of the previous year
    if (newMonth == 0) {
        newMonth = 12;
        newYear = newYear - 1;
    }
    
    [sComps setYear: newYear];
    [sComps setMonth: newMonth];
    
    NSDate* sDate = [[NSCalendar currentCalendar] dateFromComponents: sComps];
    
    return sDate;
}

- (NSDateComponents*) getYMDComponents
{
    NSCalendar *sCalendar = [NSCalendar currentCalendar];
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    [sCalendar setTimeZone:localzone];
    
    NSDateComponents* sComps = [sCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    
    return sComps;
}

- (BOOL) isToday
{
	return [self isSameDayWith:[NSDate date]];
}


@end
