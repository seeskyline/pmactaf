//
//  PlotView.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-24.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "PlotView.h"
#import "RecentMonthPlotView.h"
#import "RecentRoundPlotView.h"

#define PLOT_IDENTIFIER_LAST_ROUND  @"last_round"
#define PLOT_IDENTIFIER_TARGET_LINE @"target_line"

#define NUM_MAJOR_TICKS_X    6
#define NUM_MAJOR_TICKS_Y    6


@interface PlotView ()
{

}


@end

@implementation PlotView

@synthesize mType;
@synthesize mTitle;

@synthesize mCoreData;

@synthesize mGraphHostingView;
@synthesize mWeights;
@synthesize mDateLocRefer;
@synthesize mWeightLocRefer;
@synthesize mNumOfTicksX;
@synthesize mNumOfTicksY;
@synthesize mPrepared;

@synthesize mRound;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mCoreData = [CoreData getInstance];
        [self initDataAndStyle];
    }
    return self;
}

- (void) dealloc
{
    self.mGraphHostingView = nil;
    self.mWeights = nil;
    self.mDateLocRefer = nil;
    self.mWeightLocRefer = nil;
    self.mTitle = nil;

    self.mRound = nil;
    [super dealloc];
    
}

- (void) initDataAndStyle
{
    if ([self prepareWeightsForPlot])
    {
        [self configHostingViewAndGraph];
        [self configPlots];
        [self configAxes];
    }
    
}

- (void) configHostingViewAndGraph
{
//#ifdef DEBUG
//    NSLog(@"%f\t%f\t%f\t%f", self.bounds.size.width, self.bounds.size.height, self.frame.size.width, self.frame.size.height);
//#endif
    CGFloat sX = 0;
    CGFloat sY = 0;
    CGFloat sWidth =  self.bounds.size.width;
    CGFloat sHeight = self.bounds.size.height;
    CGRect sFrame = CGRectMake(sX, sY, sWidth, sHeight);
    
    
    
    //1. 图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    self.mGraphHostingView = [[[CPTGraphHostingView alloc] initWithFrame:sFrame] autorelease];
    self.mGraphHostingView.collapsesLayers = NO; // Setting to YES reduces GPU memory usage, but can slow drawing/scrolling
    self.mGraphHostingView.allowPinchScaling = YES;
    self.mGraphHostingView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mGraphHostingView];
    
    //2. create, configure, and add graph
    CPTXYGraph* sGraph = [[[CPTXYGraph alloc] initWithFrame:self.mGraphHostingView.bounds]autorelease];
    
    //    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    //    [sGraph applyTheme:theme];
    
    //2.2 padding
    sGraph.paddingLeft	= 5.0;
    sGraph.paddingTop	= 5.0;
    sGraph.paddingRight	= 5.0;
    sGraph.paddingBottom = 5.0;
    
    //2.3 Set up text and its style.
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor lightGrayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 12.0f;
    sGraph.titleTextStyle = textStyle;
    sGraph.titlePlotAreaFrameAnchor = CPTRectAnchorBottom;
    sGraph.titleDisplacement = CGPointMake(0.0f, -0.2f);
    sGraph.title = self.mTitle;
    
    
    //2.4 Enable user interactions for plot space
    //    sGraph.defaultPlotSpace.allowsUserInteraction = YES;
    
    self.mGraphHostingView.hostedGraph = sGraph;
    
}

- (void) configPlots
{
    //1. configure last round plot
    CPTScatterPlot* sPlotForLastRound = [[[CPTScatterPlot alloc] init] autorelease];
    sPlotForLastRound.identifier = PLOT_IDENTIFIER_LAST_ROUND;
    sPlotForLastRound.dataSource = self;
    
    CPTMutableLineStyle* sLineStyle = [[sPlotForLastRound.dataLineStyle mutableCopy] autorelease];
    sLineStyle.lineWidth = 1.5f;
    sLineStyle.lineColor = [CPTColor colorWithCGColor:MAIN_BGCOLOR.CGColor];
    sPlotForLastRound.dataLineStyle = sLineStyle;
    
    CPTMutableLineStyle *sSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    sSymbolLineStyle.lineColor = [CPTColor redColor];
    CPTPlotSymbol* sSymbol = [CPTPlotSymbol pentagonPlotSymbol];
    sSymbol.fill = [CPTFill fillWithColor:[CPTColor redColor]];
    sSymbol.lineStyle = sSymbolLineStyle;
    sSymbol.size = CGSizeMake(2.0f, 2.0f);
    sPlotForLastRound.plotSymbol = sSymbol;
    
    
    [self.mGraphHostingView.hostedGraph addPlot:sPlotForLastRound toPlotSpace:self.mGraphHostingView.hostedGraph.defaultPlotSpace];
    
    //2. configure target line plot
    
    CPTScatterPlot* sPlotForTargetLine = [[[CPTScatterPlot alloc] init] autorelease];
    sPlotForTargetLine.identifier = PLOT_IDENTIFIER_TARGET_LINE;
    sPlotForTargetLine.dataSource = self;
    
    sLineStyle.lineWidth = 0.4f;
    sLineStyle.lineColor = [CPTColor greenColor];
    sPlotForTargetLine.dataLineStyle = sLineStyle;
    
    [self.mGraphHostingView.hostedGraph addPlot:sPlotForTargetLine toPlotSpace:self.mGraphHostingView.hostedGraph.defaultPlotSpace];

    
    
    //adjust plot space
    
    CPTXYPlotSpace*  sGraphPlotSpace = (CPTXYPlotSpace *)self.mGraphHostingView.hostedGraph.defaultPlotSpace;
    
    CPTMutablePlotRange* sXRange = [[sGraphPlotSpace.xRange mutableCopy] autorelease];
    sXRange.location = CPTDecimalSubtract(sXRange.location, CPTDecimalFromDouble(0.12f));
    sGraphPlotSpace.xRange = sXRange;
 
    
    CPTMutablePlotRange* sYRange = [[sGraphPlotSpace.yRange mutableCopy] autorelease];
    sYRange.location = CPTDecimalSubtract(sXRange.location, CPTDecimalFromDouble(0.12f));
    sGraphPlotSpace.yRange = sXRange;

//    CPTPlotRange * sPlotRangeY = [sPlot plotRangeForCoordinate:CPTCoordinateY];
//    //    [sGraphPlotSpace scaleToFitPlots:[NSArray arrayWithObjects:sPlot, nil]];
//    CPTMutablePlotRange *yRange = [[sPlotRangeY mutableCopy] autorelease];
//    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.9f)];
//    sGraphPlotSpace.yRange = yRange;
    
    
    
    return;
}

- (void)configAxes
{
    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor lightGrayColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    
    CPTMutableLineStyle *sXAxisLineStyle = [CPTMutableLineStyle lineStyle];
    sXAxisLineStyle.lineWidth = 1.0f;
    sXAxisLineStyle.lineColor = [CPTColor grayColor];
    
    CPTMutableTextStyle *axisTextStyle = [[[CPTMutableTextStyle alloc] init] autorelease];
    axisTextStyle.color = [CPTColor grayColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
    
    CPTMutableLineStyle *sXTickLineStyle = [CPTMutableLineStyle lineStyle];
    sXTickLineStyle.lineColor = [CPTColor grayColor];
    sXTickLineStyle.lineWidth = 1.0f;
    
    CPTMutableLineStyle* sGridLineStyle = [CPTMutableLineStyle lineStyle];
    sGridLineStyle.lineColor = [CPTColor grayColor];
    sGridLineStyle.lineWidth = 0.07f;
    sGridLineStyle.miterLimit = 2;
    
    
    // 3 - Configure x-axis
    CPTAxis *sXAxis = ((CPTXYAxisSet *) self.mGraphHostingView.hostedGraph.axisSet).xAxis;
    sXAxis.title = NSLocalizedString(@"date", nil);
    sXAxis.titleTextStyle = axisTitleStyle;
    sXAxis.titleOffset = -25.0f;
    sXAxis.titleLocation = CPTDecimalFromDouble(0.8f);
    sXAxis.axisLineStyle = sXAxisLineStyle;
    sXAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    sXAxis.labelTextStyle = axisTextStyle;
    sXAxis.majorTickLineStyle = sXTickLineStyle;
    sXAxis.minorTickLineStyle = sXTickLineStyle;
    sXAxis.majorTickLength = 4.0f;
    sXAxis.minorTickLength = 2.5f;
    sXAxis.tickDirection = CPTSignNegative;
    
    //    sXAxis.majorGridLineStyle = sGridLineStyle;
    
    NSMutableSet* sXlables = [NSMutableSet setWithCapacity:self.mNumOfTicksX];
    NSMutableSet* sXLocs = [NSMutableSet setWithCapacity:self.mNumOfTicksX];
    NSMutableSet* sXMinLocs = [NSMutableSet setWithCapacity:self.mNumOfTicksX+1];
    
    [self.mDateLocRefer getAxisInfoLabels:&sXlables aMajroTickLocs:&sXLocs aMinorTickLocs:&sXMinLocs];
    sXAxis.axisLabels = sXlables;
    sXAxis.majorTickLocations = sXLocs;
    sXAxis.minorTickLocations = sXMinLocs;
    
    
    //
    CPTMutableLineStyle * sYAxisLineStyle = [CPTMutableLineStyle lineStyle];
    sYAxisLineStyle.lineWidth = 0.05f;
    sYAxisLineStyle.lineColor = [CPTColor grayColor];
    
    CPTMutableLineStyle *sYTickLIneStyle = [CPTMutableLineStyle lineStyle];
    sYTickLIneStyle.lineColor = [CPTColor grayColor];
    sYTickLIneStyle.lineWidth = 0.5f;
    
    
    CPTAxis *sYAxis = ((CPTXYAxisSet *) self.mGraphHostingView.hostedGraph.axisSet).yAxis;
    sYAxis.title = NSLocalizedString(@"weight(kg)", nil);
    sYAxis.titleTextStyle = axisTitleStyle;
    sYAxis.titleOffset = 20.0f;
    sYAxis.axisLineStyle = sYAxisLineStyle;
    sYAxis.majorGridLineStyle = sGridLineStyle;
    sYAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    sYAxis.labelOffset = 16.0f;
    sYAxis.majorTickLineStyle = sYTickLIneStyle;
    sYAxis.minorTickLineStyle = sYTickLIneStyle;
    sYAxis.majorTickLength = 2.5f;
    sYAxis.minorTickLength = 2.0f;
    sYAxis.tickDirection = CPTSignNegative;
    
    NSMutableSet* sYLabels = [NSMutableSet set];
    NSMutableSet* sYMajorTickLocs = [NSMutableSet set];
    NSMutableSet* sYMinorTickLocs = [NSMutableSet set];
    
    [self.mWeightLocRefer getAxisInfoLabels:&sYLabels aMajroTickLocs:&sYMajorTickLocs aMinorTickLocs:&sYMinorTickLocs];
    sYAxis.axisLabels = sYLabels;
    sYAxis.majorTickLocations = sYMajorTickLocs;
    sYAxis.minorTickLocations = sYMinorTickLocs;
    
}

#pragma mark -
#pragma mark delegate methods for CPTPlotDataSource

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    
    if (plot.identifier == PLOT_IDENTIFIER_LAST_ROUND)
    {
        return [self.mWeights count];        
    }
    else if (plot.identifier == PLOT_IDENTIFIER_TARGET_LINE)
    {
        return 2;
    }
    else
    {
        return 0;
    }
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
      if (plot.identifier  == PLOT_IDENTIFIER_LAST_ROUND)
      {
          if (index >= [self.mWeights count])
          {
              return nil;
          }
          
          DateWeight* sDW = (DateWeight*)[self.mWeights objectAtIndex:index];
          
          switch (fieldEnum) {
              case CPTScatterPlotFieldX:
              {
                  NSDate* sDate = [sDW.mDate startDateOfTheDayinLocalTimezone];
                  CGFloat sLocX = [self.mDateLocRefer getLocByDate:sDate];
                  return [NSNumber numberWithDouble:sLocX];
              }
                  break;
              case CPTScatterPlotFieldY:
              {
                  CGFloat sLocY = [self.mWeightLocRefer getLocByWeight:sDW.mWeight];
                  if (sLocY == CGFLOAT_MIN)
                  {
                      return nil;
                  }
                  return [NSNumber numberWithDouble:sLocY];
                  
              }
              default:
                  break;
          }
          
          return nil;
      }
    else if (plot.identifier == PLOT_IDENTIFIER_TARGET_LINE)
    {
        switch (fieldEnum) {
            case CPTScatterPlotFieldX:
            {
                CGFloat sLocX;
                if (index == 0)
                {
                    sLocX = 0;
                }
                else
                {
                    sLocX = self.mDateLocRefer.mEndLoc;
                }
                return [NSNumber numberWithDouble:sLocX];
            }
                break;
            case CPTScatterPlotFieldY:
            {
                double sLocY = [self.mWeightLocRefer getLocByWeight:self.mRound.mTargetWeight];
                return  [NSNumber numberWithDouble:sLocY];
            }
                break;
            default:
                break;
        }
    }
    else
    {
        return nil;
    }
    
    return nil;

}


//+ (PlotView*) getARecentRegularPlotViewWithSize:(CGRect)aFrame
//{
//    RecentMonthPlotView* sRecentPlotView = [[[RecentMonthPlotView alloc] initWithFrame:aFrame] autorelease];
//    
//    return sRecentPlotView;
//}
//
//+ (PlotView*) getARecentRoundPlotViewWithSize:(CGRect)aFrame
//{
//    RecentRoundPlotView* sRecentRoundPlotView = [[[RecentRoundPlotView alloc]initWithFrame:aFrame] autorelease];
//    
//    return sRecentRoundPlotView;
//}

+ (PlotView*) getARecentRegularPlotViewWithSize:(CGRect)aFrame
{
    PlotView* sRecentPlotView = [[[PlotView alloc] initWithFrame:aFrame] autorelease];
    sRecentPlotView.mType = ENUM_VIEW_TYPE_RECENT_WEIGHT;
    return sRecentPlotView;
}

+ (PlotView*) getARecentRoundPlotViewWithSize:(CGRect)aFrame
{
    PlotView* sRecentRoundPlotView = [[[PlotView alloc]initWithFrame:aFrame] autorelease];
    sRecentRoundPlotView.mType = ENUM_VIEW_TYPE_RECENT_ROUND;
    return sRecentRoundPlotView;
}


- (void) update
{
    [self prepareWeightsForPlot];
    [self configAxes];
    [self.mGraphHostingView.hostedGraph reloadData];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL) prepareWeightsForPlot
{
    self.mNumOfTicksX = NUM_MAJOR_TICKS_X ;
    self.mNumOfTicksY = NUM_MAJOR_TICKS_Y;
    
    //    NSInteger sNumOfDaysDisplayed;
    CGFloat sMinWeight;
    CGFloat sMaxWeight;
    CGFloat sFirstWeight;
    
    self.mRound = [self.mCoreData getLastRound];
    //    sNumOfDaysDisplayed = ([[sRound.mEndDate startDateOfTheDayinLocalTimezone] timeIntervalSince1970]-[[sRound.mStartDate startDateOfTheDayinLocalTimezone] timeIntervalSince1970])/(SECONDS_FOR_ONE_DAY);
    
    self.mWeights = [self.mCoreData getWeightsFromStartDateSelfIncluded:[mRound.mStartDate startDateOfTheDayinLocalTimezone] aEndDateIncludedSelfIncluded:[mRound.mEndDate endDateOfTheDayinLocalTimezone]  aFirstWeight:&sFirstWeight aOutMaxWeight:&sMaxWeight aOutMinWeight:&sMinWeight];
    
    if (self.mWeights.count <= 0)
    {
        sFirstWeight = 50;
        sMinWeight = 35;
        sMaxWeight = 65;
    }
    
    //if target weight is equal to min weight, then decrease min weight to avoid target line overlapping the x axis.
    if (self.mRound.mTargetWeight <= sMinWeight)
    {
        sMinWeight = self.mRound.mTargetWeight-1;
    }
    else if (self.mRound.mTargetWeight > sMaxWeight)
    {
        sMaxWeight = self.mRound.mTargetWeight+1;
    }
    else
    {
        //nothing done here.
    }
    
    //X axis
    if (!self.mDateLocRefer)
    {
        self.mDateLocRefer = [[[DateLocReference alloc]init] autorelease];
    }
    
    CPTMutableTextStyle *sLabelTexStyle = [[[CPTMutableTextStyle alloc] init] autorelease];
    sLabelTexStyle.color = [CPTColor grayColor];
    sLabelTexStyle.fontName = @"Helvetica-Bold";
    sLabelTexStyle.fontSize = 11.0f;
    
    self.mDateLocRefer.mStartLoc = 0;
    self.mDateLocRefer.mEndLoc = 0.8;
    self.mDateLocRefer.mEndDate = [mRound.mEndDate startDateOfTheDayinLocalTimezone];
    self.mDateLocRefer.mStartDate = [mRound.mStartDate startDateOfTheDayinLocalTimezone];
    self.mDateLocRefer.mNumMajorTicks = NUM_MAJOR_TICKS_X;
    self.mDateLocRefer.mNumMinorTicksPerMajorInterval = 1;
    self.mDateLocRefer.mLabelTextStyle = sLabelTexStyle;
    [self.mDateLocRefer prepareDeltaValue];
    
    
    //Y axis
    self.mWeightLocRefer = [[[WeightLocReference alloc] init] autorelease];
    self.mWeightLocRefer.mStartLoc = 0;
    self.mWeightLocRefer.mEndLoc = 0.8;
    self.mWeightLocRefer.mMinWeight = sMinWeight;
    self.mWeightLocRefer.mMaxWeight = sMaxWeight;
    self.mWeightLocRefer.mNumMajorTicks = NUM_MAJOR_TICKS_Y;
    //    self.mWeightLocRefer.mNumMinorTicksPerMajorInterval = sDeltaValue-1;
    self.mWeightLocRefer.mNumMinorTicksPerMajorInterval = 1;
    self.mWeightLocRefer.mLabelTextStyle = sLabelTexStyle;
    [self.mWeightLocRefer prepareDeltaValue];
    
    self.mTitle = NSLocalizedString(@"Weight Change in Last Round", nil);
    
    
    self.mPrepared = YES;
    return self.mPrepared;
}


@end
