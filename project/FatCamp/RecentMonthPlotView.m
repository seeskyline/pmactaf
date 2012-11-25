////
////  RecentPlotView.m
////  FatCamp
////
////  Created by Wen Shane on 12-10-24.
////  Copyright (c) 2012年 Wen Shane. All rights reserved.
////
//
//#import "RecentMonthPlotView.h"
//#import "NSDate+MyDate.h"
//
//#define NUM_MAJOR_TICKS_X    6
//#define NUM_MAJOR_TICKS_Y    5
//
//
//@implementation RecentMonthPlotView
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.mType = ENUM_VIEW_TYPE_RECENT_WEIGHT;
//    }
//    return self;
//}
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//}
//*/
//
//- (BOOL) prepareWeightsForPlot
//{
//    self.mNumOfTicksX = NUM_MAJOR_TICKS_X;
//    self.mNumOfTicksY = NUM_MAJOR_TICKS_Y;
//    
////    NSInteger sNumOfDaysDisplayed;
//    
//    CGFloat sMinWeight;
//    CGFloat sMaxWeight;
//    CGFloat sFirstWeight;
//    
//
//    NSDate* sStartDate = [[NSDate date] beginningOfFirstDayOfMonthInLocalZone];
//    NSDate* sEndDate = [[NSDate date] beginningOfLastDayOfMonthInLocalZone];
//    
////    self.mWeights = [self.mCoreData getRecentWeightsForDays:sNumOfDaysDisplayed aFirstWeight:&(sFirstWeight) aOutMaxWeight:&(sMaxWeight) aOutMinWeight:&(sMinWeight)];
//    
//    self.mWeights = [self.mCoreData getWeightsFromStartDateSelfIncluded:sStartDate aEndDateIncludedSelfIncluded:sEndDate aFirstWeight:&sFirstWeight aOutMaxWeight:&sMaxWeight aOutMinWeight:&sMinWeight];
//    
//    if (self.mWeights.count <= 0)
//    {
//        sFirstWeight = 50;
//        sMinWeight = 35;
//        sMaxWeight = 65;
//    }
//    
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
//    self.mDateLocRefer.mStartDate = sStartDate;
//    self.mDateLocRefer.mEndDate = sEndDate;
//    self.mDateLocRefer.mNumMajorTicks = NUM_MAJOR_TICKS_X;
//    self.mDateLocRefer.mNumMinorTicksPerMajorInterval = 1;
//    self.mDateLocRefer.mLabelTextStyle = sLabelTexStyle;
//    
//    
//    double sMinValue;
//    double sDeltaValue;
//    [PlotAssistant getAxisConfig:&sMinValue aOutDeltaValue:&sDeltaValue aFirstValue:sFirstWeight aMinValue:sMinWeight aMaxValue:sMaxWeight aNumOfTicks:NUM_MAJOR_TICKS_Y];
//    
//    CGFloat sYLen = 0.8;
//    NSInteger sNumOfSeg = NUM_MAJOR_TICKS_Y-1;
//    CGFloat sYLocDelta = sYLen/sNumOfSeg;
//    self.mWeightLocRefer = [[[WeightLocReference alloc] init] autorelease];
//    self.mWeightLocRefer.mStartLoc = 0-(sNumOfSeg/2)*sYLocDelta;
//    self.mWeightLocRefer.mEndLoc = self.mWeightLocRefer.mStartLoc+sNumOfSeg*sYLocDelta;
//    self.mWeightLocRefer.mStartWeight = sMinValue;
//    self.mWeightLocRefer.mEndWeight = self.mWeightLocRefer.mStartWeight + sNumOfSeg*sDeltaValue;
//    self.mWeightLocRefer.mNumMajorTicks = NUM_MAJOR_TICKS_Y;
//    self.mWeightLocRefer.mNumMinorTicksPerMajorInterval = sDeltaValue-1;
//    self.mWeightLocRefer.mLabelTextStyle = sLabelTexStyle;
//    
//    
//    NSInteger sX = 10;
//    NSString* sMonthStrForLocalization = [NSString stringWithFormat:@"month %d", sX];
//    NSString* sMonthStr = NSLocalizedString(sMonthStrForLocalization, nil);
//    self.mTitle = [NSString stringWithFormat:NSLocalizedString(@"weight changes in month %@", nil), sMonthStr];
//
//    self.mPrepared = YES;
//    
//    return YES;
//}
//
//@end
