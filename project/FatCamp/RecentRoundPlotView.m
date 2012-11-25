////
////  RecentRoundPlotView.m
////  FatCamp
////
////  Created by Wen Shane on 12-10-24.
////  Copyright (c) 2012年 Wen Shane. All rights reserved.
////
//
//#import "RecentRoundPlotView.h"
//
//#define NUM_MAJOR_TICKS_X    6
//#define NUM_MAJOR_TICKS_Y    8
//
//
//
//@implementation RecentRoundPlotView
//
//@synthesize mRound;
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.mType = ENUM_VIEW_TYPE_RECENT_ROUND;
//    }
//    return self;
//}
//
//- (BOOL) prepareWeightsForPlot
//{
//    self.mNumOfTicksX = NUM_MAJOR_TICKS_X ;
//    self.mNumOfTicksY = NUM_MAJOR_TICKS_Y;
// 
////    NSInteger sNumOfDaysDisplayed;
//    CGFloat sMinWeight;
//    CGFloat sMaxWeight;
//    CGFloat sFirstWeight;
//
//    self.mRound = [self.mCoreData getLastRound];
////    sNumOfDaysDisplayed = ([[sRound.mEndDate startDateOfTheDayinLocalTimezone] timeIntervalSince1970]-[[sRound.mStartDate startDateOfTheDayinLocalTimezone] timeIntervalSince1970])/(SECONDS_FOR_ONE_DAY);
//    
//    self.mWeights = [self.mCoreData getWeightsFromStartDateSelfIncluded:[mRound.mStartDate startDateOfTheDayinLocalTimezone] aEndDateIncludedSelfIncluded:[mRound.mEndDate endDateOfTheDayinLocalTimezone]  aFirstWeight:&sFirstWeight aOutMaxWeight:&sMaxWeight aOutMinWeight:&sMinWeight];
//    
//    if (self.mWeights.count <= 0)
//    {
//        sFirstWeight = 50;
//        sMinWeight = 35;
//        sMaxWeight = 65;      
//    }
//    
//    if (self.mRound.mTargetWeight < sMinWeight)
//    {
//        sMinWeight = self.mRound.mTargetWeight;
//    }
//    if (self.mRound.mTargetWeight > sMaxWeight)
//    {
//        sMaxWeight = self.mRound.mTargetWeight;
//    }
//    
//    //X axis
//    if (!self.mDateLocRefer)
//    {
//        self.mDateLocRefer = [[[DateLocReference alloc]init] autorelease];
//    }
//    
//    CPTMutableTextStyle *sLabelTexStyle = [[[CPTMutableTextStyle alloc] init] autorelease];
//    sLabelTexStyle.color = [CPTColor grayColor];
//    sLabelTexStyle.fontName = @"Helvetica-Bold";
//    sLabelTexStyle.fontSize = 11.0f;
//    
//    self.mDateLocRefer.mStartLoc = 0;
//    self.mDateLocRefer.mEndLoc = 0.8;
//    self.mDateLocRefer.mEndDate = [mRound.mEndDate startDateOfTheDayinLocalTimezone];
//    self.mDateLocRefer.mStartDate = [mRound.mStartDate startDateOfTheDayinLocalTimezone];
//    self.mDateLocRefer.mNumMajorTicks = NUM_MAJOR_TICKS_X;
//    self.mDateLocRefer.mNumMinorTicksPerMajorInterval = 1;
//    self.mDateLocRefer.mLabelTextStyle = sLabelTexStyle;
//    [self.mDateLocRefer prepareDeltaValue];
//    
//
//    //Y axis
//    self.mWeightLocRefer = [[[WeightLocReference alloc] init] autorelease];
//    self.mWeightLocRefer.mStartLoc = 0;
//    self.mWeightLocRefer.mEndLoc = 0.8;
//    self.mWeightLocRefer.mMinWeight = sMinWeight;
//    self.mWeightLocRefer.mMaxWeight = sMaxWeight;
//    self.mWeightLocRefer.mNumMajorTicks = NUM_MAJOR_TICKS_Y;
////    self.mWeightLocRefer.mNumMinorTicksPerMajorInterval = sDeltaValue-1;
//    self.mWeightLocRefer.mNumMinorTicksPerMajorInterval = 1;
//    self.mWeightLocRefer.mLabelTextStyle = sLabelTexStyle;
//    [self.mWeightLocRefer prepareDeltaValue];
//    
////    self.mTitle = NSLocalizedString(@"Weight Change in Last Round", nil);
//
//    
//    self.mPrepared = YES;
//    return self.mPrepared;    
//}
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//}
//*/
//
//@end
