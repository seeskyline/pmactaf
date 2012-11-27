//
//  NSDateFormatter+MyDateFormatter.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-12.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//
#import "NSDate+MyDate.h"
#import "NSDateFormatter+MyDateFormatter.h"

@implementation NSDateFormatter (MyDateFormatter)

- (void) setLocaleTimeZone
{
    [self setTimeZone:[NSTimeZone localTimeZone]];
}

- (NSString*) year: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    
    [self setDateFormat:@"yyyy"];
    sDateStr = [self stringFromDate:aDate];
    
    return sDateStr;
}


- (NSString*) standardYMDFormatedString: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    
    [self setDateFormat:@"yyyy-M-d"];
    sDateStr = [self stringFromDate:aDate];

    return sDateStr;
}

- (NSString*) standardYMDFormatedStringLeadigZero: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    
    [self setDateFormat:@"yyyy-MM-dd"];
    sDateStr = [self stringFromDate:aDate];
    
    return sDateStr;
}

- (NSString*) standardMDFormatedString: (NSDate*)aDate
{
    [self setLocaleTimeZone];
    
    NSString* sDateStr;
    
    [self setDateFormat:@"M-d"];
    sDateStr = [self stringFromDate:aDate];
    
    return sDateStr;
}

- (NSString*) standardMDFormatedStringLeadigZero: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    
    [self setDateFormat:@"MM-dd"];
    sDateStr = [self stringFromDate:aDate];
    
    return sDateStr;
}

- (NSString*) standardMDFormatedStringLeadigZeroCN: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    
    NSString* sFormatStr = [NSString stringWithFormat:@"MM%@dd%@", NSLocalizedString(@"month", nil), NSLocalizedString(@"day", nil)];
    [self setDateFormat:sFormatStr];
    sDateStr = [self stringFromDate:aDate];
    
    return sDateStr;
}


- (NSString*) standardMDFormatedStringCN: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    
    NSString* sFormatStr = [NSString stringWithFormat:@"M%@d%@", NSLocalizedString(@"month", nil), NSLocalizedString(@"day", nil)];
    [self setDateFormat:sFormatStr];
    sDateStr = [self stringFromDate:aDate];
    
    return sDateStr;
}

- (NSString*) standardMDFormatedStringCNMoreReadable: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    
    if ([aDate isSameDayWith:[NSDate date]])
    {
        sDateStr = NSLocalizedString(@"today", nil);
    }
    else
    {
        NSString* sFormatStr = [NSString stringWithFormat:@"M%@d%@", NSLocalizedString(@"month", nil), NSLocalizedString(@"day", nil)];
        [self setDateFormat:sFormatStr];
        sDateStr = [self stringFromDate:aDate];
    }
    return sDateStr;
}


- (NSString*) standardYMDFormatedStringLeadigZeroCN: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    
    NSString* sFormatStr = [NSString stringWithFormat:@"yyyy%@MM%@dd%@",  NSLocalizedString(@"year", nil), NSLocalizedString(@"month", nil), NSLocalizedString(@"day", nil)];
    [self setDateFormat:sFormatStr];
    sDateStr = [self stringFromDate:aDate];
    
    return sDateStr;}


- (NSString*) standardYMDFormatedStringLeadigZeroMoreReadable: (NSDate*)aDate
{
    [self setLocaleTimeZone];

    NSString* sDateStr;
    if ([aDate isSameDayWith:[NSDate date]])
    {
        sDateStr = NSLocalizedString(@"today", nil);
    }
    else
    {
        [self setDateFormat:@"yyyy-MM-dd"];
        sDateStr = [self stringFromDate:aDate];
    }
    
    return sDateStr;
}



@end
