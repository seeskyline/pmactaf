//
//  RecentWeightView.m
//  FatCamp
//
//  Created by Wen Shane on 12-11-13.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//



//#define TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_IMAGE_VIEW    1001
#define TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_LABEL         1002
//#define TAG_BRIEF_VIEW_ROUND_UPDOWN_IMAGE_VIEW          1003
//#define TAG_BRIEF_VIEW_ROUND_WEIGHTLOST_LABEL           1004
//#define TAG_BRIEF_VIEW_ROUND_PROGRESS_IMAGE_VIEW        1005
//#define TAG_BRIEF_VIEW_ROUND_PROGRESS_LABEL             1006
#define TAG_DETAIL_VIEW_MONTH_WEIGHTLOSTTHISMONTH_LABEL 1007
#define TAG_DETAIL_VIEW_DIFF_FROM_STANDARDWEIGHT_LABEL  1008
#define TAG_DETAIL_VIEW_MONTH_STANDARDWEIGHT_LABEL      1009
//#define TAG_DETAIL_VIEW_ROUND_DAYSPASSED_LABEL          1009
//#define TAG_DETAIL_VIEW_ROUND_WEIGHTLOST_LABEL          1010
//#define TAG_DETAIL_VIEW_ROUND_WEIGHTUNWANTED_LABEL      1011
//#define TAG_DETAIL_VIEW_ROUND_DAYSREMAINS_LABEL         1012


#define TAG_FOR_CELL_UPDOWN_IMAGEVIEW       10001
#define TAG_FOR_CELL_WEIGHT_LABEL           10002
#define TAG_FOR_CELL_WEIGHT_DIFF_LABEL      10003
#define TAG_FOR_CELL_DATE_LABEL             10004


#define MAX_DAYS_OF_WEIGHTS_DISPLAYED       100

#import "RecentWeightView.h"
#import "NSDate+MyDate.h"
#import "NSDateFormatter+MyDateFormatter.h"
#import "SharedVariables.h"
#import "CustomCellBackgroundView.h"
#import "WeightCaculator.h"
#import <QuartzCore/QuartzCore.h>

@interface RecentWeightView ()
{
    UILabel* mWeightHeaderLabel;
    UILabel* mWeightLabel;
    
    UIView* mBriefViewForRecentMonth;
    UIView* mDetailViewForRecentMonth;
    
    UITableView* mRecentWeightsTableView;

    NSMutableArray* mRecentWeightsASC;
    DateWeight* mLastRecordedDateWeight;
    DateWeight* mStartingDateWeightOfThisMonth;
    
    BOOL mListWeightByDateDESC;
}

@property (nonatomic, retain) UILabel* mWeightHeaderLabel;
@property (nonatomic, retain) UILabel* mWeightLabel;

@property (nonatomic, retain) UIView* mBriefViewForRecentMonth;
@property (nonatomic, retain) UIView* mDetailViewForRecentMonth;
@property (nonatomic, retain) UITableView* mRecentWeightsTableView;

@property (nonatomic, retain) NSMutableArray* mRecentWeightsASC;
@property (nonatomic, retain) DateWeight* mLastRecordedDateWeight;
@property (nonatomic, retain) DateWeight* mStartingDateWeightOfThisMonth;


@property (nonatomic, assign) BOOL mListWeightByDateDESC;
@end


@implementation RecentWeightView

@synthesize mWeightHeaderLabel;
@synthesize mWeightLabel;
@synthesize mBriefViewForRecentMonth;
@synthesize mDetailViewForRecentMonth;
@synthesize mRecentWeightsTableView;

@synthesize mRecentWeightsASC;
@synthesize mLastRecordedDateWeight;
@synthesize mStartingDateWeightOfThisMonth;

@synthesize mListWeightByDateDESC;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mType = ENUM_VIEW_TYPE_RECENT_WEIGHT;
        self.mListWeightByDateDESC = YES;
        [self loadWeights];
        [self layoutStatisticsView];
        [self refreshStaticsView];
    }
    return self;
}

- (void) loadWeights
{
    if (self.mCoreData)
    {
        self.mRecentWeightsASC = [self.mCoreData getRecentWeightsForDays:MAX_DAYS_OF_WEIGHTS_DISPLAYED];
        self.mStartingDateWeightOfThisMonth = [self.mCoreData getFirstDateWeighOfThisMonth];
        self.mLastRecordedDateWeight = [self.mCoreData getLastRecorededDateWeight];
    }
}

- (void) layoutStatisticsView
{
    //1. add the most recent Weight label
//    DateWeight* sLastRecordedDateWeight = [self.mCoreData getLastRecorededDateWeight];

    
    CGFloat sX = 10;
    CGFloat sY = 10;//45
    CGFloat sWidth = 150;
    CGFloat sHeight = 18;
    
    self.mWeightHeaderLabel = [[[UILabel alloc]initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
//    NSString* sDateStr = [sDateFormatter standardMDFormatedStringCN: sLastRecordedDateWeight.mDate];
//    NSString* sText = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"weight", nil),sDateStr];
//    self.mWeightHeaderLabel.text = sText;
    self.mWeightHeaderLabel.textColor = COLOR_TRIVAL_TEXT;
    self.mWeightHeaderLabel.font = [UIFont systemFontOfSize:13];
    self.mWeightHeaderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mWeightHeaderLabel];
    
    sX = 10;
    sY = sY+sHeight;
    sWidth = 150;
    sHeight = 44;
//    NSString* sWeightStr = [NSString stringWithFormat:@"%.1fkg", sLastRecordedDateWeight.mWeight];
    
    self.mWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//    self.mWeightLabel.text = sWeightStr;
    self.mWeightLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    self.mWeightLabel.font = [UIFont systemFontOfSize:40];
    self.mWeightLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.mWeightLabel];
    
    //2. add brief view
    sX = sX+sWidth+15;
    sY = sY+20;
    sWidth = self.bounds.size.width-sX-5;
    sHeight = 25;
    //2.1 add mStatusOfWeightImageView, mWeightStatus FOR mBriefViewForRencenMonth
    self.mBriefViewForRecentMonth = [[[UIView alloc]initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    
//    UIImageView* sWeightStatusImageView = [ [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 16, 16)] autorelease];
//    sWeightStatusImageView.image = [UIImage imageNamed:@"apple12.png"];
//    //        sWeightStatusImageView.tag = TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_IMAGE_VIEW;
//    [self.mBriefViewForRecentMonth addSubview:sWeightStatusImageView];
    
    UILabel* sWeightStatusLabel = [[[UILabel alloc]initWithFrame:CGRectMake(35, 0, 60, 20)] autorelease];
    sWeightStatusLabel.backgroundColor = [UIColor clearColor];
    sWeightStatusLabel.font = [UIFont systemFontOfSize:13];
    sWeightStatusLabel.textColor = [UIColor whiteColor];
    sWeightStatusLabel.textAlignment = UITextAlignmentCenter;
    sWeightStatusLabel.layer.cornerRadius = 4.0;
    sWeightStatusLabel.backgroundColor = MAIN_BGCOLOR;
    sWeightStatusLabel.tag = TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_LABEL;
    [self.mBriefViewForRecentMonth addSubview:sWeightStatusLabel];
    
    [self addSubview:self.mBriefViewForRecentMonth];

    //3. add detail view
    sX = 10;
    sY = sY + sHeight+9;
    sWidth = self.bounds.size.width-2*sX;
    sHeight = 40;
    
    //3.1 add mDetailViewForRecentMonth
    self.mDetailViewForRecentMonth = [[[UIView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    self.mDetailViewForRecentMonth.backgroundColor = [UIColor clearColor];
    
    //header
    UILabel* sDetailHeaderWeightLostThisMonthLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 15)] autorelease];
    sDetailHeaderWeightLostThisMonthLabel.text = NSLocalizedString(@"WeightLostThisMonth", nil);
    sDetailHeaderWeightLostThisMonthLabel.textColor = COLOR_TRIVAL_TEXT;
    sDetailHeaderWeightLostThisMonthLabel.font = [UIFont systemFontOfSize:13];
    sDetailHeaderWeightLostThisMonthLabel.textAlignment = UITextAlignmentCenter;
    sDetailHeaderWeightLostThisMonthLabel.backgroundColor = [UIColor clearColor];
    [self.mDetailViewForRecentMonth addSubview:sDetailHeaderWeightLostThisMonthLabel];
 
    UILabel* sDetailHeaderDiffFromStandardWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 75, 15)] autorelease];
    sDetailHeaderDiffFromStandardWeightLabel.text = NSLocalizedString(@"DiffFromStandardWeight", nil);
    sDetailHeaderDiffFromStandardWeightLabel.textColor = COLOR_TRIVAL_TEXT;
    sDetailHeaderDiffFromStandardWeightLabel.font = [UIFont systemFontOfSize:13];
    sDetailHeaderDiffFromStandardWeightLabel.textAlignment = UITextAlignmentCenter;
    sDetailHeaderDiffFromStandardWeightLabel.backgroundColor = [UIColor clearColor];
    [self.mDetailViewForRecentMonth addSubview:sDetailHeaderDiffFromStandardWeightLabel];

    
    UILabel* sDetailHeaderStandardWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(200, 0, 60, 15)] autorelease];
    sDetailHeaderStandardWeightLabel.text = NSLocalizedString(@"StandardWeight", nil);
    sDetailHeaderStandardWeightLabel.textColor = COLOR_TRIVAL_TEXT;
    sDetailHeaderStandardWeightLabel.font = [UIFont systemFontOfSize:13];
    sDetailHeaderStandardWeightLabel.textAlignment = UITextAlignmentCenter;
    sDetailHeaderStandardWeightLabel.backgroundColor = [UIColor clearColor];
    [self.mDetailViewForRecentMonth addSubview:sDetailHeaderStandardWeightLabel];

    
    //non-header
    UILabel* sDetailWeightLostThisMonthLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 15, 60, 25)] autorelease];
    sDetailWeightLostThisMonthLabel.font = [UIFont systemFontOfSize:13];
    sDetailWeightLostThisMonthLabel.textAlignment = UITextAlignmentCenter;
    sDetailWeightLostThisMonthLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    sDetailWeightLostThisMonthLabel.backgroundColor = [UIColor clearColor];
    sDetailWeightLostThisMonthLabel.tag = TAG_DETAIL_VIEW_MONTH_WEIGHTLOSTTHISMONTH_LABEL;
    [self.mDetailViewForRecentMonth addSubview:sDetailWeightLostThisMonthLabel];
    
    UILabel* sDetailDiffFromStandardWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(100, 15, 75, 25)] autorelease];
    sDetailDiffFromStandardWeightLabel.font = [UIFont systemFontOfSize:13];
    sDetailDiffFromStandardWeightLabel.textAlignment = UITextAlignmentCenter;
    sDetailDiffFromStandardWeightLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    sDetailDiffFromStandardWeightLabel.backgroundColor = [UIColor clearColor];
    sDetailDiffFromStandardWeightLabel.tag = TAG_DETAIL_VIEW_DIFF_FROM_STANDARDWEIGHT_LABEL;
    [self.mDetailViewForRecentMonth addSubview:sDetailDiffFromStandardWeightLabel];

    
    UILabel* sDetailStandardWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(200, 15, 60, 25)] autorelease];
    sDetailStandardWeightLabel.font = [UIFont systemFontOfSize:13];
    sDetailStandardWeightLabel.textAlignment = UITextAlignmentCenter;
    sDetailStandardWeightLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    sDetailStandardWeightLabel.backgroundColor = [UIColor clearColor];
    sDetailStandardWeightLabel.tag = TAG_DETAIL_VIEW_MONTH_STANDARDWEIGHT_LABEL;
    [self.mDetailViewForRecentMonth addSubview:sDetailStandardWeightLabel];
    
    [self addSubview:self.mDetailViewForRecentMonth];
    

    sX = 10;
    sY += sHeight + 10;
    sWidth = 300;
    sHeight = self.bounds.size.height-sY;
    
    UITableView* sTableView = [[UITableView alloc] initWithFrame:CGRectMake(sX, 144, sWidth, sHeight) style:UITableViewStylePlain];
    sTableView.dataSource = self;
    sTableView.delegate = self;
    //[setBackgroundView:nil] only works on ios 6, and setBackgroundColor:[UIColor clearColor] works on ios 5 only.
    [sTableView setBackgroundView:nil];
    [sTableView setBackgroundColor:[UIColor clearColor]];
//    sTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    sTableView.bounces = NO;
    sTableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    self.mRecentWeightsTableView = sTableView;
    [sTableView release];
    [self addSubview:self.mRecentWeightsTableView];
    

}

- (void) dealloc
{
    self.mWeightHeaderLabel = nil;
    self.mWeightLabel = nil;
    self.mBriefViewForRecentMonth = nil;
    self.mDetailViewForRecentMonth = nil;
    self.mRecentWeightsTableView = nil;
    self.mRecentWeightsASC = nil;
    self.mLastRecordedDateWeight = nil;

    [super dealloc];
}

- (void) update
{
    [self loadWeights];

    [self refreshStaticsView];
    [self.mRecentWeightsTableView reloadData];    
}

- (void) refreshStaticsView
{
    //1. refresh last recorded weight
    NSString* sText = nil;
    if (self.mLastRecordedDateWeight)
    {
        NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
        NSString* sDateStr = [sDateFormatter standardMDFormatedStringCNMoreReadable: self.mLastRecordedDateWeight.mDate];
        sText = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"weight", nil),sDateStr];
    }
    else
    {
        sText = [NSString stringWithFormat:@"%@", NSLocalizedString(@"weight", nil)];
    }
    self.mWeightHeaderLabel.text = sText;
    NSString* sWeightStr = [NSString stringWithFormat:@"%.1fkg", self.mLastRecordedDateWeight.mWeight];
    self.mWeightLabel.text = sWeightStr;
    
    //2. refresh brief view;
    UserInfo* sUserInfo = [self.mCoreData getUserInfo];
    if (sUserInfo)
    {
        UILabel* sWeightStatusLabel = (UILabel*)[self.mBriefViewForRecentMonth viewWithTag:TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_LABEL];
        ENUM_WEIGHT_STATUS_TYPE sWeightStatus = [WeightCaculator getWeightStatusByWeight:self.mLastRecordedDateWeight.mWeight Height:sUserInfo.mHeight];
        switch (sWeightStatus) {
            case ENUM_WEIGHT_STATUS_TYPE_UNDER_WEIGHT:
            {
                sWeightStatusLabel.text = NSLocalizedString(@"UnderWeight", nil);
            }
                break;
            case ENUM_WEIGHT_STATUS_TYPE_NORAML:
            {
                sWeightStatusLabel.text = NSLocalizedString(@"NormalWeight", nil);
            }
                break;
            case ENUM_WEIGHT_STATUS_TYPE_OVER_WEIGHT:
            {
                sWeightStatusLabel.text = NSLocalizedString(@"Overweight", nil);
            }
                break;
            case ENUM_WEIGHT_STATUS_TYPE_OBESE:
            {
                sWeightStatusLabel.text = NSLocalizedString(@"Obese", nil);
            }
                break;
            default:
                break;
        }
        
        //3. refresh detail view
        NSString* sWeightLostStr;
        if (self.mStartingDateWeightOfThisMonth)
        {
            double sWeightDiff = self.mLastRecordedDateWeight.mWeight-self.mStartingDateWeightOfThisMonth.mWeight;
            sWeightLostStr = [WeightCaculator formatWeightDiffWithPlusOrNegtiveSign:sWeightDiff];
        }
        else
        {
            sWeightLostStr = NSLocalizedString(@"no record(s) yet", nil);
        }
        
        UILabel* sDetailWeightLostThisMonthLabel = (UILabel*)[self.mDetailViewForRecentMonth viewWithTag:TAG_DETAIL_VIEW_MONTH_WEIGHTLOSTTHISMONTH_LABEL];
        sDetailWeightLostThisMonthLabel.text = sWeightLostStr;
        
        double sStandardWeight = [WeightCaculator getStandardWeightByHeight:sUserInfo.mHeight IsFemale:sUserInfo.mIsFemale];
        
        UILabel* sDiffFromStandardWeightLabel = (UILabel*)[self.mDetailViewForRecentMonth viewWithTag:TAG_DETAIL_VIEW_DIFF_FROM_STANDARDWEIGHT_LABEL];
        double sDiffFromStandardWeight = (double)(self.mLastRecordedDateWeight.mWeight)- sStandardWeight;
        
        sDiffFromStandardWeightLabel.text = [WeightCaculator formatWeightDiffWithPlusOrNegtiveSign:sDiffFromStandardWeight];
        
        
        UILabel* sDetailStandardWeightLabel = (UILabel*)[self.mDetailViewForRecentMonth viewWithTag:TAG_DETAIL_VIEW_MONTH_STANDARDWEIGHT_LABEL];
        sDetailStandardWeightLabel.text = [NSString stringWithFormat:@"%.1fkg", sStandardWeight];

    }
    

}


#pragma mark -
#pragma mark tableview's datasource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        if (self.mRecentWeightsASC)
        {
            return [self.mRecentWeightsASC count];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* sCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIImageView* sUpDownImageView;
    UILabel* sWeightLabel;
    UILabel* sWeightDiffLabel;
    UILabel* sDateLabel;
    
    if (!sCell)
    {
        sCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
        UIView* sBGView = [[[UIView alloc] initWithFrame:sCell.bounds] autorelease];
        sBGView.backgroundColor = SELECTED_CELL_COLOR;
        sCell.selectedBackgroundView = sBGView;

        //date label
        sDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 60, 30)];
        sDateLabel.backgroundColor = [UIColor clearColor];
        sDateLabel.font = [UIFont systemFontOfSize:13];
        sDateLabel.textColor = COLOR_TRIVAL_TEXT;
        sDateLabel.textAlignment = UITextAlignmentLeft;
        sDateLabel.tag = TAG_FOR_CELL_DATE_LABEL;
        [sCell.contentView addSubview:sDateLabel];
        [sDateLabel release];
        
        //weight label
        sWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 3, 100, 30)];
        sWeightLabel.textColor = [UIColor grayColor];
        sWeightLabel.backgroundColor = [UIColor clearColor];
        sWeightLabel.tag = TAG_FOR_CELL_WEIGHT_LABEL;
        [sCell.contentView addSubview:sWeightLabel];
        [sWeightLabel release];       
      
        //weight difference label
        sWeightDiffLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 3, 70, 30)];
        sWeightDiffLabel.backgroundColor = [UIColor clearColor];
        sWeightDiffLabel.font = [UIFont systemFontOfSize:15];
        sWeightDiffLabel.textColor = COLOR_TRIVAL_TEXT;
        sWeightDiffLabel.tag = TAG_FOR_CELL_WEIGHT_DIFF_LABEL;
        [sCell.contentView addSubview:sWeightDiffLabel];
        [sWeightDiffLabel release];
        
        //updown imageview
        sUpDownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 12, 12, 12)];
        sUpDownImageView.tag = TAG_FOR_CELL_UPDOWN_IMAGEVIEW;
        [sCell.contentView addSubview:sUpDownImageView];
        [sUpDownImageView release];

    }
    else
    {
        sUpDownImageView = (UIImageView*)[sCell viewWithTag:TAG_FOR_CELL_UPDOWN_IMAGEVIEW];
        sWeightLabel = (UILabel*)[sCell viewWithTag:TAG_FOR_CELL_WEIGHT_LABEL];
        sDateLabel = (UILabel*)[sCell viewWithTag:TAG_FOR_CELL_DATE_LABEL];
        sWeightDiffLabel = (UILabel*)[sCell viewWithTag:TAG_FOR_CELL_WEIGHT_DIFF_LABEL];
    }
  
    NSInteger sRow = [indexPath row];
    
    if (self.mRecentWeightsASC)
    {
        NSInteger sIndexInWeightsOfCurRow;
        NSInteger sIndexInWeightsForPreviousDateWeight;
        
        if (!self.mListWeightByDateDESC)
        {
            sIndexInWeightsOfCurRow = sRow;
        }
        else
        {
            sIndexInWeightsOfCurRow = self.mRecentWeightsASC.count-1-sRow;
        }
        DateWeight* sDateWeight = (DateWeight*)[self.mRecentWeightsASC objectAtIndex:sIndexInWeightsOfCurRow];

        
        sIndexInWeightsForPreviousDateWeight = sIndexInWeightsOfCurRow-1;  
        if (sIndexInWeightsForPreviousDateWeight >= 0)
        {
            DateWeight* sPreviousDateWeight = (DateWeight*)[self.mRecentWeightsASC objectAtIndex:sIndexInWeightsForPreviousDateWeight];

            double sDiff = sDateWeight.mWeight-sPreviousDateWeight.mWeight;
            sWeightDiffLabel.text = [WeightCaculator formatWeightDiffWithPlusOrNegtiveSign:sDiff];
            if (sDiff < 0)
            {
                sUpDownImageView.image = [UIImage imageNamed:@"down12.png"];
            }
            else if (sDiff > 0)
            {
                sUpDownImageView.image = [UIImage imageNamed:@"up12.png"];
            }
            else
            {
                sUpDownImageView.image = [UIImage imageNamed:@"still12.png"];
            }
        }
        else
        {
            sWeightDiffLabel.text = nil;
            sUpDownImageView.image = nil;
        }
        
        sWeightLabel.text = [NSString stringWithFormat:@"%.1f kg", sDateWeight.mWeight];
  
        NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
        NSString* sDateStr = [sDateFormatter standardMDFormatedStringLeadigZeroCN:sDateWeight.mDate];
        sDateLabel.text = [NSString stringWithFormat:@"%@", sDateStr];
    }
    else
    {
        sCell.textLabel.text = nil;
    }
    
    return sCell;
    
}


#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* sLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width-5, [self tableView:tableView heightForHeaderInSection:section])] autorelease];
    sLabel.backgroundColor = SELECTED_CELL_COLOR_TRANSPARENT;
    sLabel.layer.cornerRadius = 2.0;
    sLabel.text = @"最近体重变化";
    sLabel.textAlignment = UITextAlignmentLeft;
    sLabel.textColor = [UIColor whiteColor];
    sLabel.font = [UIFont boldSystemFontOfSize:13];
    return sLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
