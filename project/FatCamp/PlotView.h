//
//  PlotView.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-24.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "PlotAssistant.h"
#import "DateLocReference.h"
#import "WeightLocReference.h"
#import "NSDateFormatter+MyDateFormatter.h"
#import "NSDate+MyDate.h"
#import "SharedVariables.h"
#import "CoreData.h"

#import "MainPage.h"
///Users/seeskyline/workplace/FatCamp/CorePlot_1.0/Source/framework/


//typedef enum _PlotViewType
//{
//    ENUM_VIEW_TYPE_UNDEFINED,
//    ENUM_VIEW_TYPE_RECENT_WEIGHT,
//    ENUM_VIEW_TYPE_RECENT_ROUND
//}ENUM_PLOTVIEW_TYPE;

@interface PlotView : UIView<CPTPlotDataSource>
{
    
    ENUM_CHILDVIEW_TYPE mType;
    NSString* mTitle;
    
  
    CoreData* mCoreData;
    CPTGraphHostingView* mGraphHostingView;
    
    NSMutableArray* mWeights;
    DateLocReference* mDateLocRefer;
    WeightLocReference* mWeightLocRefer;
    
    NSInteger mNumOfTicksX;
    NSInteger mNumOfTicksY;
    
    BOOL mPrepared;

    //
    RoundInfo* mRound;
}

@property (nonatomic, assign) ENUM_CHILDVIEW_TYPE mType;
@property (nonatomic, copy) NSString* mTitle;

@property (nonatomic, assign) CoreData* mCoreData;

@property (nonatomic, retain) CPTGraphHostingView* mGraphHostingView;
@property (nonatomic, retain) NSMutableArray* mWeights;
@property (nonatomic, retain) DateLocReference* mDateLocRefer;
@property (nonatomic, retain) WeightLocReference* mWeightLocRefer;

@property (nonatomic, assign) NSInteger mNumOfTicksX;
@property (nonatomic, assign) NSInteger mNumOfTicksY;
@property (nonatomic, assign) BOOL mPrepared;

@property (nonatomic, retain) RoundInfo* mRound;


+ (PlotView*) getARecentRegularPlotViewWithSize:(CGRect)aFrame;
+ (PlotView*) getARecentRoundPlotViewWithSize:(CGRect)aFrame;

- (void) update;

@end
