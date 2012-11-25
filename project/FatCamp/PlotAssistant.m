////
////  PlotAssistant.m
////  FatCamp
////
////  Created by Wen Shane on 12-10-22.
////  Copyright (c) 2012年 Wen Shane. All rights reserved.
////
//
//#import "PlotAssistant.h"
//
//@implementation PlotAssistant
//
//+ (void) getAxisConfig: (double*)aOutMinValue  aOutDeltaValue:(double*)aOutDeltaValue  aFirstValue:(double)aFirstValue aMinValue:(double)aMinValue aMaxValue:(double)aMaxValue aNumOfTicks:(NSInteger)aNumOfTicks
//{
//    if (aNumOfTicks < 3)
//    {
//        *aOutMinValue = -1;
//        *aOutDeltaValue = -1;
//        return;
//    }
// 
//    NSInteger sMinInt = floor(aMinValue);
//    NSInteger sMaxInt = ceil(aMaxValue);
//    
//    double sDelta = (sMaxInt-sMinInt)/(aNumOfTicks-1);
//    
//    NSInteger sDeltaInt = ceil(sDelta);
//    
//    *aOutMinValue = sMinInt;
//    *aOutDeltaValue = sDeltaInt;
//    
//    return;
//
//}
//
//@end
