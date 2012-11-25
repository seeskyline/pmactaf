//
//  WeightCaculator.m
//  FatCamp
//
//  Created by Wen Shane on 12-11-13.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "WeightCaculator.h"

#define MIN_HEIGHT  70 //cm
#define MAX_HEIGHT  220

#define MIN_WEIGHT 30 //kg
#define MAX_WEIGHT 150

@implementation WeightCaculator

+ (double) getMinHeight
{
    return MIN_HEIGHT;
}

+ (double) getMaxHeight
{
    return MAX_HEIGHT;
}

+ (double) getMinWeight
{
    return MIN_WEIGHT;
}

+ (double) getMaxWeight
{
    return MAX_WEIGHT;
}


+ (BOOL) isHeightValid:(double)aHeight
{
    if (aHeight < [self getMinHeight]
        || aHeight > [self getMaxHeight])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (BOOL) isWeightValid:(double)aWeight
{
    if (aWeight < [self getMinWeight]
        || aWeight > [self getMaxWeight])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (double) calculateBMIByWeightKG:(double)aWeightKG HeightCM:(double)aHeightCM
{
    double aHeightM = aHeightCM/100.0;
    double sBMI = aWeightKG/(aHeightM*aHeightM);
    
    return sBMI;

}

+ (double) getStandardWeightByHeight:(double)aHeight IsFemale:(BOOL)aIsFemale
{
    //follows the second algorithm in "other algorithms" defined at http://baike.baidu.com/view/93890.htm
    //some othere rules we may consider, like those taking age and gender into account.
    double sStandardBMI;
    if (aIsFemale)
    {
        sStandardBMI = 20;
    }
    else
    {
        sStandardBMI = 22;
    }
    double sStandardWeight = (aHeight/100.0)*(aHeight/100.0)*sStandardBMI;
    return sStandardWeight;
}
+ (NSArray*) getNormalWeightRange:(double)aHeight
{
    double sNormalBMILow = 18.5;
    double sNormalWeightLow = (aHeight/100.0)*(aHeight/100.0)*sNormalBMILow;
    
    double sNormalBMIHigh = 24;
    double sNormalWeightHigh = (aHeight/100.0)*(aHeight/100.0)*sNormalBMIHigh;
    
    NSMutableArray* sRangeArray = [NSMutableArray arrayWithCapacity:2];
    [sRangeArray addObject:[NSNumber numberWithDouble:sNormalWeightLow]];
    [sRangeArray addObject:[NSNumber numberWithDouble:sNormalWeightHigh]];
    return sRangeArray;
}

+ (ENUM_WEIGHT_STATUS_TYPE) getWeightStatusByWeight:(double)aWeight Height:(double)aHeight
{
    double sBMI = [self calculateBMIByWeightKG:aWeight HeightCM:aHeight];
    ENUM_WEIGHT_STATUS_TYPE sWeightStatus = [self getWeightStatusByBMI:sBMI];
    return sWeightStatus;
}

+ (ENUM_WEIGHT_STATUS_TYPE) getWeightStatusByBMI:(double)aBMI
{
    //follow rules defined at http://app.baidu.com/app/enter?appid=101874
    if (aBMI < 18.5)
    {
        return ENUM_WEIGHT_STATUS_TYPE_UNDER_WEIGHT;
    }
    else if (aBMI >= 18.5
             && aBMI < 24)
    {
        return ENUM_WEIGHT_STATUS_TYPE_NORAML;
    }
    else if (aBMI >=24
             && aBMI < 28)
    {
        return ENUM_WEIGHT_STATUS_TYPE_OVER_WEIGHT;
    }
    else if (aBMI >= 28)
    {
        return ENUM_WEIGHT_STATUS_TYPE_OBESE;
    }
    else
    {
        return ENUM_WEIGHT_STATUS_TYPE_UNDEFINED;
    }
    
}

+ (NSString*) formatWeightDiffWithPlusOrNegtiveSign:(double)aWeight0 Weight1:(double)aWeight1
{
    double sWeightDiff = aWeight0 - aWeight1;
    return [self formatWeightDiffWithPlusOrNegtiveSign:sWeightDiff];
}

+ (NSString*) formatWeightDiffWithPlusOrNegtiveSign:(double)aWeighDiff
{
    NSString* sFormatedStr = nil;
    
    if (aWeighDiff > 0)
    {
        sFormatedStr = [NSString stringWithFormat:@"+%.1fkg", fabs(aWeighDiff)];
    }
    else if (aWeighDiff < 0)
    {
        sFormatedStr = [NSString stringWithFormat:@"-%.1fkg", fabs(aWeighDiff)];
    }
    else
    {
        sFormatedStr = @" 0";
    }
    
    return sFormatedStr;
}

+ (NSString*) formatWeightDiffWithPlusOrNegtiveSignTwoDigits:(double)aWeighDiff
{
    NSString* sFormatedStr = nil;
    
    if (aWeighDiff > 0)
    {
        sFormatedStr = [NSString stringWithFormat:@"+%.2fkg", fabs(aWeighDiff)];
    }
    else if (aWeighDiff < 0)
    {
        sFormatedStr = [NSString stringWithFormat:@"-%.2fkg", fabs(aWeighDiff)];
    }
    else
    {
        sFormatedStr = @" 0";
    }
    
    return sFormatedStr;
}


@end
