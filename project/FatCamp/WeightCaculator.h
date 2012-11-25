//
//  WeightCaculator.h
//  FatCamp
//
//  Created by Wen Shane on 12-11-13.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum _WeightStatusType
{
    ENUM_WEIGHT_STATUS_TYPE_UNDEFINED,
    ENUM_WEIGHT_STATUS_TYPE_UNDER_WEIGHT,
    ENUM_WEIGHT_STATUS_TYPE_NORAML,
    ENUM_WEIGHT_STATUS_TYPE_OVER_WEIGHT,
    ENUM_WEIGHT_STATUS_TYPE_OBESE
}ENUM_WEIGHT_STATUS_TYPE;



@interface WeightCaculator : NSObject

+ (double) getMinHeight;
+ (double) getMaxHeight;
+ (double) getMinWeight;
+ (double) getMaxWeight;



+ (BOOL) isHeightValid:(double)aHeight;
+ (BOOL) isWeightValid:(double)aWeight;

//+ (double) getStandardWeight;
//+ (double) calculateBMIByWeight:(double)aWeight;
+ (double) calculateBMIByWeightKG:(double)aWeightKG HeightCM:(double)aHeightCM;

+ (double) getStandardWeightByHeight:(double)aHeight IsFemale:(BOOL)aIsFemale;
+ (NSArray*) getNormalWeightRange:(double)aHeight;


+ (ENUM_WEIGHT_STATUS_TYPE) getWeightStatusByWeight:(double)aWeight Height:(double)aHeight;
+ (ENUM_WEIGHT_STATUS_TYPE) getWeightStatusByBMI:(double)aBMI;


+ (NSString*) formatWeightDiffWithPlusOrNegtiveSign:(double)aWeight0 Weight1:(double)aWeight1;
+ (NSString*) formatWeightDiffWithPlusOrNegtiveSign:(double)aWeighDiff;

+ (NSString*) formatWeightDiffWithPlusOrNegtiveSignTwoDigits:(double)aWeighDiff;

@end
