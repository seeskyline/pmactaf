//
//  RecentRoundView.m
//  FatCamp
//
//  Created by Wen Shane on 12-11-13.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

//#define TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_IMAGE_VIEW    1001
//#define TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_LABEL         1002
//#define TAG_BRIEF_VIEW_ROUND_UPDOWN_IMAGE_VIEW          1100
//#define TAG_BRIEF_VIEW_ROUND_WEIGHTLOST_LABEL           1104
//#define TAG_BRIEF_VIEW_ROUND_PROGRESS_IMAGE_VIEW        1005
//#define TAG_BRIEF_VIEW_ROUND_PROGRESS_LABEL             1106
//#define TAG_DETAIL_VIEW_MONTH_WEIGHTLOSTTHISMONTH_LABEL 1007
//#define TAG_DETAIL_VIEW_MONTH_STANDARDWEIGHT_LABEL      1008
#define TAG_DETAIL_VIEW_ROUND_DAYSPASSED_LABEL          1109
#define TAG_DETAIL_VIEW_ROUND_WEIGHTLOST_LABEL          1110
#define TAG_DETAIL_VIEW_ROUND_WEIGHTUNWANTED_LABEL      1111
#define TAG_DETAIL_VIEW_ROUND_DAYSREMAINS_LABEL         1112



#import "RecentRoundView.h"
#import "PlotView.h"
#import "NSDate+MyDate.h"
#import "WeightCaculator.h"

@interface RecentRoundView ()
{
    UILabel* mInitWeightHeaderLabel;
    UILabel* mInitWeightLabel;

    UILabel* mTargetWeightHeaderLabel;
    UILabel* mTargetWeightLabel;
    
    UIView* mDetailView;
    PlotView* mPlotView;
    
    UIView* mEmptyPlanView; //constucted and displayed only when there are no exisitent plans yet.
}
@property (nonatomic, retain) UILabel* mInitWeightHeaderLabel;
@property (nonatomic, retain) UILabel* mInitWeightLabel;

@property (nonatomic, retain) UILabel* mTargetWeightHeaderLabel;
@property (nonatomic, retain) UILabel* mTargetWeightLabel;

@property (nonatomic, retain) UIView* mDetailView;
@property (nonatomic, retain) PlotView* mPlotView;

@property (nonatomic, retain) UIView* mEmptyPlanView;

@end


@implementation RecentRoundView
@synthesize mInitWeightHeaderLabel;
@synthesize mInitWeightLabel;
@synthesize mTargetWeightHeaderLabel;
@synthesize mTargetWeightLabel;
@synthesize mPlotView;
@synthesize mDetailView;
@synthesize mEmptyPlanView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mType = ENUM_VIEW_TYPE_RECENT_ROUND;
        self.backgroundColor = [UIColor clearColor];
        
//        if ([self.mCoreData getAllRounds].count <= 0)
//        {
//            [self layoutEmptyPlanView];         
//        }
//        else
//        {
//            [self layoutLastRoundView];          
//        }
        
        [self update];
    }
    return self;
}


- (void) dealloc
{
    self.mInitWeightHeaderLabel = nil;
    self.mInitWeightLabel = nil;
    self.mTargetWeightHeaderLabel = nil;
    self.mTargetWeightLabel = nil;
    self.mPlotView = nil;
    self.mDetailView = nil;
    self.mEmptyPlanView = nil;
    
    [super dealloc];
}

- (void) layoutLastRoundView
{
    //1. init and target weight header
    CGFloat sX = 10;
    CGFloat sY = 10;//45
    CGFloat sWidth = 110;
    CGFloat sHeight = 15;
    
    self.mInitWeightHeaderLabel = [[[UILabel alloc]initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    //    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
    //    NSString* sDateStr = [sDateFormatter standardMDFormatedStringCN: sLastRecordedDateWeight.mDate];
    //    NSString* sText = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"weight", nil),sDateStr];
    //    self.mWeightHeaderLabel.text = sText;
    self.mInitWeightHeaderLabel.textColor = COLOR_TRIVAL_TEXT;
    self.mInitWeightHeaderLabel.font = [UIFont systemFontOfSize:13];
    self.mInitWeightHeaderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mInitWeightHeaderLabel];

    self.mTargetWeightHeaderLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-10-sWidth, sY, sWidth, sHeight)] autorelease];
    //    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
    //    NSString* sDateStr = [sDateFormatter standardMDFormatedStringCN: sLastRecordedDateWeight.mDate];
    //    NSString* sText = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"weight", nil),sDateStr];
    //    self.mWeightHeaderLabel.text = sText;
    self.mTargetWeightHeaderLabel.textColor = COLOR_TRIVAL_TEXT;
    self.mTargetWeightHeaderLabel.font = [UIFont systemFontOfSize:13];
    self.mTargetWeightHeaderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mTargetWeightHeaderLabel];

    //2.init and target weight
    sX = 10;
    sY = sY+sHeight;
    sWidth = 108;
    sHeight = 35;

    self.mInitWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    //    self.mWeightLabel.text = sWeightStr;
    self.mInitWeightLabel.textColor = [UIColor grayColor];
    self.mInitWeightLabel.font = [UIFont systemFontOfSize:30];
    self.mInitWeightLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mInitWeightLabel];

    self.mTargetWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-10-sWidth, sY, sWidth, sHeight)] autorelease];
    //    self.mWeightLabel.text = sWeightStr;
    self.mTargetWeightLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    self.mTargetWeightLabel.font = [UIFont systemFontOfSize:30];
    self.mTargetWeightLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mTargetWeightLabel];
   
    //3. direction img
    UIImageView* sImageView = [[UIImageView alloc] initWithFrame:CGRectMake(sX+sWidth+16, sY, 32, 32)];
    [sImageView setImage:[UIImage imageNamed:@"right32.png"]];
    [self addSubview:sImageView];
    [sImageView release];

    //4. detail view    
    sX = 8;
    sY += sHeight+9;
    sWidth = self.bounds.size.width-2*sX;
    sHeight = 40;
    //3.2 add
    self.mDetailView = [[[UIView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    
    UILabel* sDetailHeaderDaysPassedLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 47, 15)] autorelease];
    sDetailHeaderDaysPassedLabel.text = NSLocalizedString(@"DaysPassed", nil);
    sDetailHeaderDaysPassedLabel.textColor = COLOR_TRIVAL_TEXT;
    sDetailHeaderDaysPassedLabel.font = [UIFont systemFontOfSize:13];
    sDetailHeaderDaysPassedLabel.textAlignment = UITextAlignmentCenter;
    sDetailHeaderDaysPassedLabel.backgroundColor = [UIColor clearColor];
    [self.mDetailView addSubview:sDetailHeaderDaysPassedLabel];
    
    UILabel* sDetailHeaderWeightLostLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 47, 15)] autorelease];
    sDetailHeaderWeightLostLabel.text = NSLocalizedString(@"WeightLost", nil);
    sDetailHeaderWeightLostLabel.textColor = COLOR_TRIVAL_TEXT;
    sDetailHeaderWeightLostLabel.font = [UIFont systemFontOfSize:13];
    sDetailHeaderWeightLostLabel.textAlignment = UITextAlignmentCenter;
    sDetailHeaderWeightLostLabel.backgroundColor = [UIColor clearColor];
    [self.mDetailView addSubview:sDetailHeaderWeightLostLabel];
    
    UILabel* sDetailHeaderWeightUnwantedLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75+75, 0, 47, 15)] autorelease];
    sDetailHeaderWeightUnwantedLabel.text = NSLocalizedString(@"WeighUnwanted", nil);
    sDetailHeaderWeightUnwantedLabel.textColor = COLOR_TRIVAL_TEXT;
    sDetailHeaderWeightUnwantedLabel.font = [UIFont systemFontOfSize:13];
    sDetailHeaderWeightUnwantedLabel.textAlignment = UITextAlignmentCenter;
    sDetailHeaderWeightUnwantedLabel.backgroundColor = [UIColor clearColor];
    [self.mDetailView addSubview:sDetailHeaderWeightUnwantedLabel];
    
    UILabel* sDetailHeaderDaysRemainsLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75+75+75, 0, 47, 15)] autorelease];
    sDetailHeaderDaysRemainsLabel.text = NSLocalizedString(@"DaysRemains", nil);
    sDetailHeaderDaysRemainsLabel.textColor = COLOR_TRIVAL_TEXT;
    sDetailHeaderDaysRemainsLabel.font = [UIFont systemFontOfSize:13];
    sDetailHeaderDaysRemainsLabel.textAlignment = UITextAlignmentCenter;
    sDetailHeaderDaysRemainsLabel.backgroundColor = [UIColor clearColor];
    [self.mDetailView addSubview:sDetailHeaderDaysRemainsLabel];
    
    //detail statistis
    UILabel* sDetailDaysPassedLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 47, 25)] autorelease];
    sDetailDaysPassedLabel.font = [UIFont systemFontOfSize:13];
    sDetailDaysPassedLabel.textAlignment = UITextAlignmentCenter;
    sDetailDaysPassedLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    sDetailDaysPassedLabel.backgroundColor = [UIColor clearColor];
    sDetailDaysPassedLabel.tag = TAG_DETAIL_VIEW_ROUND_DAYSPASSED_LABEL;
    [self.mDetailView addSubview:sDetailDaysPassedLabel];
    
    UILabel* sDetailWeightLostLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75, 15, 47, 25)] autorelease];
    sDetailWeightLostLabel.font = [UIFont systemFontOfSize:13];
    sDetailWeightLostLabel.textAlignment = UITextAlignmentCenter;
    sDetailWeightLostLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    sDetailWeightLostLabel.backgroundColor = [UIColor clearColor];
    sDetailWeightLostLabel.tag = TAG_DETAIL_VIEW_ROUND_WEIGHTLOST_LABEL;
    [self.mDetailView addSubview:sDetailWeightLostLabel];
    
    UILabel* sDetailWeightUnwantedLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75+75, 15, 47, 25)] autorelease];
    sDetailWeightUnwantedLabel.font = [UIFont systemFontOfSize:13];
    sDetailWeightUnwantedLabel.textAlignment = UITextAlignmentCenter;
    sDetailWeightUnwantedLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    sDetailWeightUnwantedLabel.backgroundColor = [UIColor clearColor];
    sDetailWeightUnwantedLabel.tag = TAG_DETAIL_VIEW_ROUND_WEIGHTUNWANTED_LABEL;
    [self.mDetailView addSubview:sDetailWeightUnwantedLabel];
    
    UILabel* sDetailDaysRemainsLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75+75+75-8, 15, 75, 25)] autorelease];
    sDetailDaysRemainsLabel.font = [UIFont systemFontOfSize:13];
    sDetailDaysRemainsLabel.textAlignment = UITextAlignmentCenter;
    sDetailDaysRemainsLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
    sDetailDaysRemainsLabel.backgroundColor = [UIColor clearColor];
    sDetailDaysRemainsLabel.tag = TAG_DETAIL_VIEW_ROUND_DAYSREMAINS_LABEL;
    [self.mDetailView addSubview:sDetailDaysRemainsLabel];
    
    [self addSubview:self.mDetailView];
    
    //plot view for recent round
    sY += sHeight+10;
    sHeight = self.bounds.size.height-sY-10;

    PlotView* sPlotView = [PlotView getARecentRoundPlotViewWithSize:CGRectMake(sX, sY, sWidth, sHeight)];
    sPlotView.backgroundColor = [UIColor clearColor];
    [self addSubview:sPlotView];
    self.mPlotView = sPlotView;
    
}


- (void) layoutEmptyPlanView
{
    UIView* sView = [[UIView alloc] initWithFrame:self.bounds];
    sView.backgroundColor = [UIColor clearColor];    
    [self addSubview:sView];

    self.mEmptyPlanView = sView;
    [sView release];
    
    CGFloat sX = self.bounds.size.width-140;
    CGFloat sY = 30;
    CGFloat sWidth = 75;
    CGFloat sHeight = 20;

    UIImageView* sImageViewSetGoal = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startplan75x20.png"]];
    [sImageViewSetGoal setFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    [self.mEmptyPlanView addSubview:sImageViewSetGoal];
    [sImageViewSetGoal release];

    
    sX = sX+sWidth+5;
    sY = 0;
    sWidth = 39;
    sHeight = 44;
    UIImageView* sRightUpArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightuparrow39x44.png"]];
    [sRightUpArrowImageView setFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    [self.mEmptyPlanView addSubview:sRightUpArrowImageView];
    [sRightUpArrowImageView release];
    
     sY = 100;
     sWidth = 64.0;
     sHeight = 64.0;
     sX = self.center.x-sWidth/2;
    
    UIImageView* sImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag64.png"]];
    [sImageView setFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    [self.mEmptyPlanView addSubview:sImageView];
    [sImageView release];
    
    sX = 30;
    sY += sHeight+10;
    sWidth = 260;
    sHeight = 50;
    
    UILabel* sNoticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX, sY, self.bounds.size.width-2*sX, sHeight)];
    sNoticeLabel.text = NSLocalizedString(@"make a weight loss plan right now!", nil);
    sNoticeLabel.textAlignment = UITextAlignmentCenter;
    sNoticeLabel.font = [UIFont systemFontOfSize:18];
    sNoticeLabel.textColor = [UIColor grayColor];
    sNoticeLabel.backgroundColor = [UIColor clearColor];

    [self.mEmptyPlanView addSubview:sNoticeLabel];
    [sNoticeLabel release];
}



- (void) update
{
    if ([self.mCoreData getAllRounds].count <= 0)
    {
        if (!self.mEmptyPlanView)
        {
            [self layoutEmptyPlanView];
        }
    }
    else
    {
        if (self.mEmptyPlanView)
        {
            [self.mEmptyPlanView removeFromSuperview];
            self.mEmptyPlanView = nil;
        }
        if (!self.mInitWeightHeaderLabel
            ||!self.mTargetWeightHeaderLabel
            ||!self.mDetailView)
        {
            [self layoutLastRoundView];
        }
        [self updateBaiscInfo];
        [self updateStaticsView];
        [self.mPlotView update];
    }
}

- (void) updateBaiscInfo
{
    RoundInfo* sLastRound = [self.mCoreData getLastRound];
    NSDate* sInitDate = sLastRound.mStartDate;
    NSDate* sTargetDate = sLastRound.mEndDate;
    double sInitWeight = [self.mCoreData getLastWeightBeforeDayOfDate:sInitDate];
    double sTargetWeight = sLastRound.mTargetWeight;
    
    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
    NSString* sInitDateStr = [sDateFormatter standardMDFormatedStringCN: sInitDate];
    NSString* sTargetDateStr = [sDateFormatter standardMDFormatedStringCN: sTargetDate];

    self.mInitWeightHeaderLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"init", nil), sInitDateStr];
    self.mInitWeightLabel.text = [NSString stringWithFormat:@"%.1fkg", sInitWeight];
    
    self.mTargetWeightHeaderLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"target", nil), sTargetDateStr];
    self.mTargetWeightLabel.text = [NSString stringWithFormat:@"%.1fkg", sTargetWeight];
}

- (void) updateStaticsView
{
    RoundInfo* sLastRound = [self.mCoreData getLastRound];
    
    double sLastWeightForRound = -1;
    NSDate* sLastDateForRound = nil;
    
    if ([sLastRound isUnderway])
    {
        sLastWeightForRound = [self.mCoreData getLastRecorededDateWeight].mWeight;
        sLastDateForRound = [NSDate date];
    }
    else
    {
        sLastWeightForRound = [self.mCoreData getLastDateWeightBeforeDayOfDate:sLastRound.mEndDate].mWeight;
        sLastDateForRound = sLastRound.mEndDate;
    }

    NSInteger sDaysPassed = [sLastDateForRound daysSinceStartingOfDate:sLastRound.mStartDate];
    UILabel* sDaysPassedLabel = (UILabel*)[self.mDetailView viewWithTag:TAG_DETAIL_VIEW_ROUND_DAYSPASSED_LABEL];
    sDaysPassedLabel.text = [NSString stringWithFormat:@"%d%@", sDaysPassed, NSLocalizedString(@"day(s)", nil)];
    
//    double sWeightLost = sDateWeight.mWeight - [self.mCoreData getLastWeightBeforeDate:sLastRound.mStartDate];
    UILabel* sWeightLostLabel = (UILabel*)[self.mDetailView viewWithTag:TAG_DETAIL_VIEW_ROUND_WEIGHTLOST_LABEL];
    sWeightLostLabel.text = [NSString stringWithFormat:@"%@", [WeightCaculator formatWeightDiffWithPlusOrNegtiveSign:sLastWeightForRound Weight1:[self.mCoreData getLastWeightBeforeDayOfDate:sLastRound.mStartDate]]];
    
//    double sWeightDiffFromTarget = sDateWeight.mWeight - sLastRound.mTargetWeight;
    UILabel* sWeightDiffFromTargetLabel = (UILabel*)[self.mDetailView viewWithTag:TAG_DETAIL_VIEW_ROUND_WEIGHTUNWANTED_LABEL];
    sWeightDiffFromTargetLabel.text = [NSString stringWithFormat:@"%@", [WeightCaculator formatWeightDiffWithPlusOrNegtiveSign:   sLastWeightForRound Weight1:sLastRound.mTargetWeight]];

    UILabel* sDaysRemainsLabel = (UILabel*)[self.mDetailView viewWithTag:TAG_DETAIL_VIEW_ROUND_DAYSREMAINS_LABEL];
    if ([sLastRound isUnderway])
    {
        NSInteger sDaysRemains = [sLastRound.mEndDate ceilingDaysSinceStartingOfDate:sLastRound.mStartDate] - sDaysPassed;
        sDaysRemainsLabel.text = [NSString stringWithFormat:@"%d%@", sDaysRemains, NSLocalizedString(@"day(s)", nil)];
    }
    else
    {
        NSString* sStatusText = nil;
        if (sLastRound.mStatus == ENUM_ROUND_STATUS_DONE_CANCELED)
        {
            sStatusText = NSLocalizedString(@"done&canceled", nil);
        }
        else if (sLastRound.mStatus == ENUM_ROUND_STATUS_DONE_FAILURE)
        {
            sStatusText = NSLocalizedString(@"done&failure", nil);
        }
        else if (sLastRound.mStatus == ENUM_ROUND_STATUS_DONE_SUCCESS)
        {
            sStatusText = NSLocalizedString(@"done&success", nil);
        }
        else
        {
            //nothing done.
        }
        sDaysRemainsLabel.text = sStatusText;
    }

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
