////
////  MainPageVC.m
////  FatCamp
////
////  Created by Wen Shane on 12-10-8.
////  Copyright (c) 2012年 Wen Shane. All rights reserved.
////
//
//#import "MainPageVC.h"
////#import "MyDateView.h"
//#import "SharedVariables.h"
//#import "CoreData.h"
//#import <QuartzCore/QuartzCore.h>
//
//#import "NSDateFormatter+MyDateFormatter.h"
//#import "NSDate+MyDate.h"
//#import "PlotView.h"
//
//#import "RecentRoundPlotView.h"
//
//#import "WeightInputView.h"
//
//#import "ATMHud.h"
////#import "CPTXYAxis.h"
////
////#import "PlotAssistant.h"
////#import "DateLocReference.h"
////#import "WeightLocReference.h"
////
//
//#define NUM_PLOTS 2
//
//
////#define TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_IMAGE_VIEW    1001
//#define TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_LABEL         1002
//#define TAG_BRIEF_VIEW_ROUND_UPDOWN_IMAGE_VIEW          1003
//#define TAG_BRIEF_VIEW_ROUND_WEIGHTLOST_LABEL           1004
////#define TAG_BRIEF_VIEW_ROUND_PROGRESS_IMAGE_VIEW        1005
//#define TAG_BRIEF_VIEW_ROUND_PROGRESS_LABEL             1006
//#define TAG_DETAIL_VIEW_MONTH_WEIGHTLOSTTHISMONTH_LABEL 1007
//#define TAG_DETAIL_VIEW_MONTH_STANDARDWEIGHT_LABEL      1008
//#define TAG_DETAIL_VIEW_ROUND_DAYSPASSED_LABEL          1009
//#define TAG_DETAIL_VIEW_ROUND_WEIGHTLOST_LABEL          1010
//#define TAG_DETAIL_VIEW_ROUND_WEIGHTUNWANTED_LABEL      1011
//#define TAG_DETAIL_VIEW_ROUND_DAYSREMAINS_LABEL         1012
//
//@interface MainPageVC ()
//{
//    CoreData* mCoreData;
//
//    UIView* mMainView;
//    WeightInputView* mWeightInputView;
//    
//    UILabel* mDateView;
//    UILabel* mMottoLabel;
//    
//    UILabel* mWeightHeaderLabel;
//    UILabel* mWeightLabel;
//    
//    UIView* mBriefViewForRecentMonth;
//    UIView* mBriefViewForRecentRound;
//    
//    UIView* mDetailViewForRecentMonth;
//    UIView* mDetailViewForRecentRound;
//        
//    XLCycleScrollView* mHorizontalScrollView;
//
//    NSMutableArray* mChildScrollViews;
//    ENUM_CHILDVIEW_TYPE mCurPlotViewType;
//    
//    BOOL mNeedUpdateStatisticsForRecentMonth;
//    BOOL mNeedUpdateStatisticsForRecentRound;
//        
//}
//@property (nonatomic, assign) CoreData* mCoreData;
//
//
//@property (nonatomic, retain)UIView* mMainView;
//@property (nonatomic, retain)WeightInputView* mWeightInputView;
//
//@property (nonatomic, retain) UILabel* mDateView;
//@property (nonatomic, retain) UILabel* mMottoLabel;
//
//@property (nonatomic, retain) UILabel* mWeightHeaderLabel;
//@property (nonatomic, retain) UILabel* mWeightLabel;
//
//@property (nonatomic, retain) UIView* mBriefViewForRecentMonth;
//@property (nonatomic, retain) UIView* mBriefViewForRecentRound;
//
//@property (nonatomic, retain) UIView* mDetailViewForRecentMonth;
//@property (nonatomic, retain) UIView* mDetailViewForRecentRound;
//
//@property (nonatomic, retain) XLCycleScrollView* mHorizontalScrollView;
//
//@property (nonatomic, retain) NSMutableArray* mChildScrollViews;
//@property (nonatomic, assign) ENUM_CHILDVIEW_TYPE mCurPlotViewType;
//
//@property (nonatomic, assign) BOOL mNeedUpdateStatisticsForRecentMonth;
//@property (nonatomic, assign) BOOL mNeedUpdateStatisticsForRecentRound;
//
//@end
//
//@implementation MainPageVC
//@synthesize mCoreData;
//@synthesize mMainView;
//@synthesize mWeightInputView;
//
//@synthesize mDateView;
//@synthesize mMottoLabel;
//
//@synthesize mWeightHeaderLabel;
//@synthesize mWeightLabel;
//
//@synthesize mBriefViewForRecentMonth;
//@synthesize mBriefViewForRecentRound;
//
//@synthesize mDetailViewForRecentMonth;
//@synthesize mDetailViewForRecentRound;
//
//@synthesize mHorizontalScrollView;
//
//@synthesize mChildScrollViews;
//@synthesize mCurPlotViewType;
//
//@synthesize mNeedUpdateStatisticsForRecentMonth;
//@synthesize mNeedUpdateStatisticsForRecentRound;
//
////@synthesize mWeightDataPicker;
////@synthesize mWeightInputNoticeLabel;
////@synthesize mWeightInputBoxLabel;
////@synthesize mWeightDataValueInteger;
////@synthesize mWeightDataValueDigit;
////@synthesize mDateForWeightInput;
//
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (id) initWithTitle: (NSString*)aTitle
//{
//    self = [super init];
//    if (self)
//    {
//        UIButton* sAddWeightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [sAddWeightButton setImage:[UIImage imageNamed:@"add24.png" ] forState:UIControlStateNormal];
//        sAddWeightButton.frame = CGRectMake(0, 0, 55, 30);
//        sAddWeightButton.showsTouchWhenHighlighted = YES;
//        [sAddWeightButton addTarget:self action:@selector(logWeight) forControlEvents:UIControlEventTouchDown];
//        UIBarButtonItem* sAddWeightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sAddWeightButton];
////        UIBarButtonItem* sAddWeightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Add", nil) style:UIBarButtonItemStylePlain target:self action:@selector(addWeight)];
//
//        self.navigationItem.rightBarButtonItem = sAddWeightBarButtonItem;
//        [sAddWeightBarButtonItem release];
//
//        self.title = aTitle;
//        self.mCoreData = [CoreData getInstance];
//        self.mNeedUpdateStatisticsForRecentMonth = YES;
//        self.mNeedUpdateStatisticsForRecentRound = YES;
//    }
//    
//    return self;
//}
//
//- (void) loadView
//{
//    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
//    
//    UIView* sView = [[UIView alloc] initWithFrame:applicationFrame];
//    self.view = sView;
//    [sView release];
//    
//    
//    UIView* sBGView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
//    sBGView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:sBGView];
//    
//    self.mMainView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
//    self.mMainView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
//    [self.view addSubview:self.mMainView];
//
//    [self displayDateLabel];
////    [self displayMottoLable];
//    
//    
//    [self displayStatistics];
//   
//
// 
//    if (!mHorizontalScrollView)
//    {
//        CGFloat sX = 0;
//        CGFloat sY = 200-41-10;
//        CGFloat sWidth = 320;
//        CGFloat sHeight = 200;
//        CGRect sFrame = CGRectMake(sX, sY, sWidth, sHeight);
//
//        mHorizontalScrollView = [[[XLCycleScrollView alloc]initWithFrame:sFrame IsRepeating:NO] autorelease];
//    
//        //you should setPlot to prepare the subviews before set datasouce for mHorizontalScrollView
//        [self setPlot];
//
//        mHorizontalScrollView.datasource = self;
//        mHorizontalScrollView.delegate = self;
//        mHorizontalScrollView.backgroundColor = [UIColor clearColor];
//        [self.mMainView addSubview:mHorizontalScrollView];
//    }
//    
//}
//
//- (void) dealloc
//{
//    self.mMainView = nil;
//    self.mWeightInputView = nil;
//
//    
//    self.mDateView = nil;
//    self.mMottoLabel = nil;
//    
//    self.mWeightHeaderLabel = nil;
//    self.mWeightLabel = nil;
//    
//    self.mBriefViewForRecentMonth = nil;
//    self.mBriefViewForRecentRound = nil;
//    
//    self.mDetailViewForRecentMonth = nil;
//    self.mDetailViewForRecentRound = nil;
//    
//    self.mChildScrollViews = nil;    
//    
//    self.mHorizontalScrollView = nil;
//    
//    [super dealloc];
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//}
//
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    if (!self.mWeightInputView)
//    {
//        [self prepareWeightInputView];       
//    }
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void) displayDateLabel
//{
//    if (!self.mDateView)
//    {
////        self.mDateView = [[[MyDateView alloc]initWithDate:sDate] autorelease];
////        [self.mDateView setFrame:CGRectMake(250, 5, 64, 44)];
////        mDateView.backgroundColor = MAIN_BGCOLOR_TRANSPARENT;
////        mDateView.layer.cornerRadius = 5;
////        mDateView.layer.masksToBounds = YES;
//        mDateView = [[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 315, 20)] autorelease];
//        
//        NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//        mDateView.text = [sDateFormatter standardMDFormatedStringCN:[NSDate date]];
//        mDateView.textAlignment = UITextAlignmentRight;
//        mDateView.textColor = [UIColor grayColor];
//        mDateView.backgroundColor = [UIColor clearColor];
//        [self.mMainView addSubview:self.mDateView];
//        
//    }
//    else
//    {
//    }
//    return;
//    
//}
//
//- (void) displayMottoLable
//{
//    if (!self.mMottoLabel)
//    {
//        
//        
//        CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
//        CGFloat sX = self.mDateView.frame.origin.x+self.mDateView.frame.size.width+5;
//        CGFloat sY = 4;
//        CGFloat sWidth;
//        CGFloat sHeight = 40;
//        
//        UIImageView* sSpeakerImgView = [[[UIImageView alloc] initWithImage: [UIImage imageNamed:@"speaker32.png"]] autorelease ];
//        [sSpeakerImgView setFrame:CGRectMake(sX, sY, 32, 32)];
//        
//        [self.mMainView addSubview:sSpeakerImgView];
//        
//        sX += 32;
//        sWidth = applicationFrame.size.width-sX;
//        self.mMottoLabel = [[[UILabel alloc]initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
////        self.mMottoLabel.backgroundColor = MAIN_BGCOLOR_TRANSPARENT;
//        self.mMottoLabel.numberOfLines = 0;
////        self.mMottoLabel.layer.cornerRadius = 5;
////        self.mMottoLabel.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"motto", nil),[[[[NSDateFormatter alloc] init] autorelease] standardYMDFormatedStringLeadigZero:[NSDate date]]];
//;
//        self.mMottoLabel.font = [UIFont systemFontOfSize:17];
//        self.mMottoLabel.backgroundColor = [UIColor clearColor];
//        
//        [self.mMainView addSubview:self.mMottoLabel];
//    }
//    else
//    {
//        self.mMottoLabel.text = NSLocalizedString(@"motto", nil);
//    }
//
//}
//
//- (void) displayStatistics
//{
//
//    if (!self.mWeightHeaderLabel)
//    {
//        CGRect sApplicationFrame = [[UIScreen mainScreen] applicationFrame];
//
//        //1. add the most recent Weight label
//        CGFloat sX = 15;
//        CGFloat sY = 20;//45
//        CGFloat sWidth = 150;
//        CGFloat sHeight = 20;
//        DateWeight* sLastRecordedDateWeight = [self.mCoreData getLastRecorededDateWeight];
//        self.mWeightHeaderLabel = [[[UILabel alloc]initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//        NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
//        NSString* sDateStr = [sDateFormatter standardMDFormatedStringCN: sLastRecordedDateWeight.mDate];
//        NSString* sText = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"weight", nil),sDateStr];
//        self.mWeightHeaderLabel.text = sText;
//        self.mWeightHeaderLabel.textColor = COLOR_TRIVAL_TEXT;
//        self.mWeightHeaderLabel.font = [UIFont systemFontOfSize:13];
//        self.mWeightHeaderLabel.backgroundColor = [UIColor clearColor];
//        [self.mMainView addSubview:self.mWeightHeaderLabel];
//         
//        sX = 8;
//        sY = sY+sHeight;
//        sWidth = 150;
//        sHeight = 44;
//        NSString* sWeightStr = [NSString stringWithFormat:@"%.1fkg", sLastRecordedDateWeight.mWeight];
//        
//        self.mWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//        self.mWeightLabel.text = sWeightStr;
//        self.mWeightLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        self.mWeightLabel.font = [UIFont systemFontOfSize:40];
//        self.mWeightLabel.backgroundColor = [UIColor clearColor];
//
//        [self.mMainView addSubview:self.mWeightLabel];
// 
//        //2. add brief view
//        sX = sX+sWidth+15;
//        sY = sY+20;
//        sWidth = sApplicationFrame.size.width-sX-5;
//        sHeight = 25;
//        //2.1 add mStatusOfWeightImageView, mWeightStatus FOR mBriefViewForRencenMonth
//        self.mBriefViewForRecentMonth = [[[UIView alloc]initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//    
//        UIImageView* sWeightStatusImageView = [ [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)] autorelease];
//        sWeightStatusImageView.image = [UIImage imageNamed:@"weightstatus12.png"];
////        sWeightStatusImageView.tag = TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_IMAGE_VIEW;
//        [self.mBriefViewForRecentMonth addSubview:sWeightStatusImageView];
//        
//        UILabel* sWeightStatusLabel = [[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 25)] autorelease];
//        sWeightStatusLabel.backgroundColor = [UIColor clearColor];
//        sWeightStatusLabel.font = [UIFont systemFontOfSize:15];
//        sWeightStatusLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sWeightStatusLabel.tag = TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_LABEL;
//        [self.mBriefViewForRecentMonth addSubview:sWeightStatusLabel];
//        
//        [self.mMainView addSubview:self.mBriefViewForRecentMonth];
//        
//        //2.2 add updownImageView, mWeightLostLabel, mProgressImageVIew, mWeightLostProgressLable FOR mBriefViewForRecentRound
//        self.mBriefViewForRecentRound = [[[UIView alloc]initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//        
//        UIImageView* sUpDownImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)] autorelease];
//        sUpDownImageView.image = [UIImage imageNamed:@"down12.png"];
//        sUpDownImageView.tag = TAG_BRIEF_VIEW_ROUND_UPDOWN_IMAGE_VIEW;
//        [self.mBriefViewForRecentRound addSubview:sUpDownImageView];
//        
//        UILabel* sWeightLostLabel = [[[UILabel alloc] initWithFrame:CGRectMake(12, 0, 60, 25)] autorelease];
//        sWeightLostLabel.backgroundColor = [UIColor clearColor];
//        sWeightLostLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sWeightLostLabel.tag = TAG_BRIEF_VIEW_ROUND_WEIGHTLOST_LABEL;
//        [self.mBriefViewForRecentRound addSubview:sWeightLostLabel];
//        
//        
//        UIImageView* sProgressImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(12+60+10, 0, 12, 12)] autorelease];
//        sProgressImageView.image = [UIImage imageNamed:@"accept12.png"];
////        sProgressImageView.tag = TAG_BRIEF_VIEW_ROUND_PROGRESS_IMAGE_VIEW;
//        [self.mBriefViewForRecentRound addSubview:sProgressImageView];
//        
//        UILabel* sProgressLabel = [[[UILabel alloc] initWithFrame:CGRectMake(12+60+10+12, 0, 200, 25)] autorelease];
//        sProgressLabel.backgroundColor = [UIColor clearColor];
//        sProgressLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sProgressLabel.textAlignment = UITextAlignmentLeft;
//        sProgressLabel.tag = TAG_BRIEF_VIEW_ROUND_PROGRESS_LABEL;
//        [self.mBriefViewForRecentRound addSubview:sProgressLabel];
//        
//        [self.mMainView addSubview:self.mBriefViewForRecentRound];
//
//        //3. add detail view
//        sX = 8;
//        sY = sY + sHeight+9;
//        sWidth = sApplicationFrame.size.width-sX;
//        sHeight = 40;
//        
//        //3.1 add mDetailViewForRecentMonth
//        self.mDetailViewForRecentMonth = [[[UIView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//        self.mDetailViewForRecentMonth.backgroundColor = [UIColor clearColor];
//        UILabel* sDetailHeaderWeightLostThisMonthLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 15)] autorelease];
//        sDetailHeaderWeightLostThisMonthLabel.text = NSLocalizedString(@"WeightLostThisMonth", nil);
//        sDetailHeaderWeightLostThisMonthLabel.textColor = COLOR_TRIVAL_TEXT;
//        sDetailHeaderWeightLostThisMonthLabel.font = [UIFont systemFontOfSize:13];
//        sDetailHeaderWeightLostThisMonthLabel.textAlignment = UITextAlignmentCenter;
//        sDetailHeaderWeightLostThisMonthLabel.backgroundColor = [UIColor clearColor];
//        [self.mDetailViewForRecentMonth addSubview:sDetailHeaderWeightLostThisMonthLabel];
//        
//        UILabel* sDetailHeaderStandardWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 75, 15)] autorelease];
//        sDetailHeaderStandardWeightLabel.text = NSLocalizedString(@"StandardWeight", nil);
//        sDetailHeaderStandardWeightLabel.textColor = COLOR_TRIVAL_TEXT;
//        sDetailHeaderStandardWeightLabel.font = [UIFont systemFontOfSize:13];
//        sDetailHeaderStandardWeightLabel.textAlignment = UITextAlignmentCenter;
//        sDetailHeaderStandardWeightLabel.backgroundColor = [UIColor clearColor];
//        [self.mDetailViewForRecentMonth addSubview:sDetailHeaderStandardWeightLabel];
//        
//        UILabel* sDetailWeightLostThisMonthLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 15, 75, 25)] autorelease];
//        sDetailWeightLostThisMonthLabel.font = [UIFont systemFontOfSize:13];
//        sDetailWeightLostThisMonthLabel.textAlignment = UITextAlignmentCenter;
//        sDetailWeightLostThisMonthLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sDetailWeightLostThisMonthLabel.backgroundColor = [UIColor clearColor];
//        sDetailWeightLostThisMonthLabel.tag = TAG_DETAIL_VIEW_MONTH_WEIGHTLOSTTHISMONTH_LABEL;
//        [self.mDetailViewForRecentMonth addSubview:sDetailWeightLostThisMonthLabel];
//        
//        UILabel* sDetailStandardWeightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(100, 15, 75, 25)] autorelease];
//        sDetailStandardWeightLabel.font = [UIFont systemFontOfSize:13];
//        sDetailStandardWeightLabel.textAlignment = UITextAlignmentCenter;
//        sDetailStandardWeightLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sDetailStandardWeightLabel.backgroundColor = [UIColor clearColor];
//        sDetailStandardWeightLabel.tag = TAG_DETAIL_VIEW_MONTH_STANDARDWEIGHT_LABEL;
//        [self.mDetailViewForRecentMonth addSubview:sDetailStandardWeightLabel];
//       
//        [self.mMainView addSubview:self.mDetailViewForRecentMonth];
//
//        //3.2 add
//        self.mDetailViewForRecentRound = [[[UIView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//        
//        UILabel* sDetailHeaderDaysPassedLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 15)] autorelease];
//        sDetailHeaderDaysPassedLabel.text = NSLocalizedString(@"DaysPassed", nil);
//        sDetailHeaderDaysPassedLabel.textColor = COLOR_TRIVAL_TEXT;
//        sDetailHeaderDaysPassedLabel.font = [UIFont systemFontOfSize:13];
//        sDetailHeaderDaysPassedLabel.textAlignment = UITextAlignmentCenter;
//        sDetailHeaderDaysPassedLabel.backgroundColor = [UIColor clearColor];
//        [self.mDetailViewForRecentRound addSubview:sDetailHeaderDaysPassedLabel];
//        
//        UILabel* sDetailHeaderWeightLostLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 75, 15)] autorelease];
//        sDetailHeaderWeightLostLabel.text = NSLocalizedString(@"WeightLost", nil);
//        sDetailHeaderWeightLostLabel.textColor = COLOR_TRIVAL_TEXT;
//        sDetailHeaderWeightLostLabel.font = [UIFont systemFontOfSize:13];
//        sDetailHeaderWeightLostLabel.textAlignment = UITextAlignmentCenter;
//        sDetailHeaderWeightLostLabel.backgroundColor = [UIColor clearColor];
//        [self.mDetailViewForRecentRound addSubview:sDetailHeaderWeightLostLabel];
//        
//        UILabel* sDetailHeaderWeightUnwantedLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75+75, 0, 75, 15)] autorelease];
//        sDetailHeaderWeightUnwantedLabel.text = NSLocalizedString(@"WeighUnwanted", nil);
//        sDetailHeaderWeightUnwantedLabel.textColor = COLOR_TRIVAL_TEXT;
//        sDetailHeaderWeightUnwantedLabel.font = [UIFont systemFontOfSize:13];
//        sDetailHeaderWeightUnwantedLabel.textAlignment = UITextAlignmentCenter;
//        sDetailHeaderWeightUnwantedLabel.backgroundColor = [UIColor clearColor];
//        [self.mDetailViewForRecentRound addSubview:sDetailHeaderWeightUnwantedLabel];
//        
//        UILabel* sDetailHeaderDaysRemainsLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75+75+75, 0, 75, 15)] autorelease];
//        sDetailHeaderDaysRemainsLabel.text = NSLocalizedString(@"DaysRemains", nil);
//        sDetailHeaderDaysRemainsLabel.textColor = COLOR_TRIVAL_TEXT;
//        sDetailHeaderDaysRemainsLabel.font = [UIFont systemFontOfSize:13];
//        sDetailHeaderDaysRemainsLabel.textAlignment = UITextAlignmentCenter;
//        sDetailHeaderDaysRemainsLabel.backgroundColor = [UIColor clearColor];
//        [self.mDetailViewForRecentRound addSubview:sDetailHeaderDaysRemainsLabel];
//        
//        //
//        
//        
//        //detail statistis
//
//        UILabel* sDetailDaysPassedLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 44, 25)] autorelease];
//        sDetailDaysPassedLabel.font = [UIFont systemFontOfSize:13];
//        sDetailDaysPassedLabel.textAlignment = UITextAlignmentCenter;
//        sDetailDaysPassedLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sDetailDaysPassedLabel.backgroundColor = [UIColor clearColor];
//        sDetailDaysPassedLabel.tag = TAG_DETAIL_VIEW_ROUND_DAYSPASSED_LABEL;
//        [self.mDetailViewForRecentRound addSubview:sDetailDaysPassedLabel];
//        
//        UILabel* sDetailWeightLostLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75, 15, 75, 25)] autorelease];
//        sDetailWeightLostLabel.font = [UIFont systemFontOfSize:13];
//        sDetailWeightLostLabel.textAlignment = UITextAlignmentCenter;
//        sDetailWeightLostLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sDetailWeightLostLabel.backgroundColor = [UIColor clearColor];
//        sDetailWeightLostLabel.tag = TAG_DETAIL_VIEW_ROUND_WEIGHTLOST_LABEL;
//        [self.mDetailViewForRecentRound addSubview:sDetailWeightLostLabel];
//        
//        UILabel* sDetailWeightUnwantedLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75+75, 15, 75, 25)] autorelease];
//        sDetailWeightUnwantedLabel.font = [UIFont systemFontOfSize:13];
//        sDetailWeightUnwantedLabel.textAlignment = UITextAlignmentCenter;
//        sDetailWeightUnwantedLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sDetailWeightUnwantedLabel.backgroundColor = [UIColor clearColor];
//        sDetailWeightUnwantedLabel.tag = TAG_DETAIL_VIEW_ROUND_WEIGHTUNWANTED_LABEL;
//        [self.mDetailViewForRecentRound addSubview:sDetailWeightUnwantedLabel];
//        
//        UILabel* sDetailDaysRemainsLabel = [[[UILabel alloc]initWithFrame:CGRectMake(75+75+75, 15, 75, 25)] autorelease];
//        sDetailDaysRemainsLabel.font = [UIFont systemFontOfSize:13];
//        sDetailDaysRemainsLabel.textAlignment = UITextAlignmentCenter;
//        sDetailDaysRemainsLabel.textColor = MAIN_BGCOLOR_MAINTEXT;
//        sDetailDaysRemainsLabel.backgroundColor = [UIColor clearColor];
//        sDetailDaysRemainsLabel.tag = TAG_DETAIL_VIEW_ROUND_DAYSREMAINS_LABEL;
//        [self.mDetailViewForRecentRound addSubview:sDetailDaysRemainsLabel];
//        
//        [self.mMainView addSubview:self.mDetailViewForRecentRound];
//
//        self.mNeedUpdateStatisticsForRecentMonth = YES;
//        self.mNeedUpdateStatisticsForRecentRound = YES;
//        [self updateInfoBoard];
//    }
//    else
//    {
//        
//    }
//}
//
//- (void) setPlot
//{
//    if (!self.mChildScrollViews)
//    {
//        self.mChildScrollViews = [[[NSMutableArray alloc]initWithCapacity:3] autorelease];
//    }
//
//    CGSize sPlotSize = self.mHorizontalScrollView.bounds.size;
//    
//    PlotView* sPlotView1 = [PlotView getARecentRegularPlotViewWithSize:sPlotSize];
//    [self.mChildScrollViews addObject:sPlotView1];
//    
//    PlotView* sPlotView2 = [PlotView getARecentRoundPlotViewWithSize:sPlotSize];
//    [self.mChildScrollViews addObject:sPlotView2];
//
//    return;
//    
//}
//
//
//#pragma mark -
//#pragma mark XLCycleScrollViewDatasource methods
//- (NSInteger)numberOfPages
//{
//    return self.mChildScrollViews.count;
//}
//
//- (UIView *)pageAtIndex:(NSInteger)index aIsCurPage:(BOOL)aIsCurPage;
//{
//    if (index < 0
//        || index >= self.mChildScrollViews.count)
//    {
//        return nil;
//    }
//    //rember to reset the origin of subviews, cos it has been modified by mSchrollView in XLCycleScrollView
//    PlotView* sChildScrollView = (PlotView*)[self.mChildScrollViews objectAtIndex:index];
//    [sChildScrollView setFrame:CGRectMake(0, 0, sChildScrollView.bounds.size.width, sChildScrollView.bounds.size.height)];    
// 
//    if (aIsCurPage
//        && self.mCurPlotViewType != sChildScrollView.mType)
//    {
//        self.mCurPlotViewType = sChildScrollView.mType;
//        [self updateInfoBoard];
//    }
//    return sChildScrollView;
//}
//
//- (void) updateInfoBoard
//{
//    switch (mCurPlotViewType) {
//        case ENUM_VIEW_TYPE_RECENT_WEIGHT:
//        {
//            [self updateStatisticsForRecenMonthIfNecessary];
//            [self.mBriefViewForRecentRound setHidden:YES];
//            [self.mDetailViewForRecentRound setHidden:YES];
//            [self.mBriefViewForRecentMonth setHidden:NO];
//            [self.mDetailViewForRecentMonth setHidden:NO];
//        }
//            break;
//        case ENUM_VIEW_TYPE_RECENT_ROUND:
//        {
//            [self updateStatisticsForRecenRoundIfNecessary];
//            [self.mBriefViewForRecentMonth setHidden:YES];
//            [self.mDetailViewForRecentMonth setHidden:YES];
//            [self.mBriefViewForRecentRound setHidden:NO];
//            [self.mDetailViewForRecentRound setHidden:NO];
// 
//        }
//        default:
//            break;
//    }
//}
//
//- (void) updateStatisticsForRecenMonthIfNecessary
//{
//    if (self.mNeedUpdateStatisticsForRecentMonth)
//    {
//        UILabel* sWeightStatusLabel = (UILabel*)[self.mBriefViewForRecentMonth viewWithTag:TAG_BRIEF_VIEW_MONTH_WEIGHTSTATUS_LABEL];
//        sWeightStatusLabel.text = NSLocalizedString(@"YourWeighIsNormal", nil);
//
//        PlotView* sMonthPlotView = (PlotView*)[self findPlotViewByType:ENUM_VIEW_TYPE_RECENT_WEIGHT];
//        NSString* sWeightLostStr;
//        if ([sMonthPlotView.mWeights count] >= 2)
//        {
//            CGFloat sFirstWeight = ((DateWeight*)[sMonthPlotView.mWeights objectAtIndex:0]).mWeight;
//            CGFloat sLastWeight = ((DateWeight*)[sMonthPlotView.mWeights objectAtIndex:sMonthPlotView.mWeights.count-1]).mWeight;
//            sWeightLostStr = [NSString stringWithFormat:@"%.1fkg", (sLastWeight-sFirstWeight)];
//        }
//        else
//        {
//            sWeightLostStr = NSLocalizedString(@"null", nil);
//        }
//        UILabel* sWeightLostLabel = (UILabel*)[self.mDetailViewForRecentMonth viewWithTag:TAG_DETAIL_VIEW_MONTH_WEIGHTLOSTTHISMONTH_LABEL];
//        sWeightLostLabel.text = sWeightLostStr;
//        
//        
//        UILabel* sStandardWeightLabel = (UILabel*)[self.mDetailViewForRecentMonth viewWithTag:TAG_DETAIL_VIEW_MONTH_STANDARDWEIGHT_LABEL];
//        sStandardWeightLabel.text = @"61kg";
//        
//        
//        self.mNeedUpdateStatisticsForRecentMonth = NO;
//        return;
//    }
//}
//
//- (void) updateStatisticsForRecenRoundIfNecessary
//{
//    if (self.mNeedUpdateStatisticsForRecentRound)
//    {
//        RecentRoundPlotView* sRoundPlotView = (RecentRoundPlotView*)[self findPlotViewByType:ENUM_VIEW_TYPE_RECENT_ROUND];
//        RoundInfo* sRoundInfo = sRoundPlotView.mRound;
//        NSMutableArray* sWeights = sRoundPlotView.mWeights;
//        
//        CGFloat sWeightLost;
//        CGFloat sFirstWeight = ((DateWeight*)[sWeights objectAtIndex:0]).mWeight;
//        CGFloat sLastWeight = ((DateWeight*)[sWeights objectAtIndex:sWeights.count-1]).mWeight;
//        sWeightLost = sFirstWeight - sLastWeight;
//                
//        CGFloat sTargetWeightLost = sFirstWeight - sRoundInfo.mTargetWeight ;
//
//        CGFloat sWeightNeedToBeLost = sLastWeight - sRoundInfo.mTargetWeight;
//        
//        
//        NSInteger sPercent;
//        if (sWeightLost <= 0)
//        {
//            sPercent = 0;
//        }
//        else
//        {
//            sPercent = (NSInteger)(100*sWeightLost/sTargetWeightLost);
//        }
//        
//        NSInteger sDaysOfRound = ([[sRoundInfo.mEndDate startDateOfTheDayinLocalTimezone] timeIntervalSince1970] - [[sRoundInfo.mStartDate startDateOfTheDayinLocalTimezone] timeIntervalSince1970])/SECONDS_FOR_ONE_DAY+1;
//        
//        NSInteger sDaysPassed = ([[[NSDate date] startDateOfTheDayinLocalTimezone] timeIntervalSince1970] - [[sRoundInfo.mStartDate startDateOfTheDayinLocalTimezone] timeIntervalSince1970])/SECONDS_FOR_ONE_DAY+1;
//
////        if (sDaysPassed >= sDaysOfRound)
////        {
////            sDaysPassed = sDaysOfRound;
////        }
//
//        NSInteger sDaysRemaind = sDaysOfRound-sDaysPassed;
//        
//        UIImageView* sUpDownImageView = (UIImageView*)[self.mBriefViewForRecentRound viewWithTag:TAG_BRIEF_VIEW_ROUND_UPDOWN_IMAGE_VIEW];
//        if (sWeightLost >= 0)
//        {
//            sUpDownImageView.image = [UIImage imageNamed:@"down12.png"];
//        }
//        else
//        {
//            sUpDownImageView.image = [UIImage imageNamed:@"up12.png"];
//        }
//        
//        UILabel* sWeightLostLabel = (UILabel*)[self.mBriefViewForRecentRound viewWithTag:TAG_BRIEF_VIEW_ROUND_WEIGHTLOST_LABEL];
//        sWeightLostLabel.text = [NSString stringWithFormat:@"%.1fkg", fabs(sWeightLost)];
//        
//        UILabel* sProgressLabel = (UILabel*)[self.mBriefViewForRecentRound viewWithTag:TAG_BRIEF_VIEW_ROUND_PROGRESS_LABEL];
//        sProgressLabel.text = [NSString stringWithFormat:@"%d%%", sPercent];
//        
//        UILabel* sDaysPassedLabel = (UILabel*)[self.mDetailViewForRecentRound viewWithTag:TAG_DETAIL_VIEW_ROUND_DAYSPASSED_LABEL];
//        if (sDaysPassed > sDaysOfRound)
//        {
//            sDaysPassedLabel.text = [NSString stringWithFormat:@"%d%@", sDaysOfRound, NSLocalizedString(@"day(s)", nil)];         
//        }
//        else
//        {
//            sDaysPassedLabel.text = [NSString stringWithFormat:@"%d%@", sDaysPassed, NSLocalizedString(@"day(s)", nil)];
//        }
//        
//        UILabel* sWeightLostLabel2 = (UILabel*)[self.mDetailViewForRecentRound viewWithTag:TAG_DETAIL_VIEW_ROUND_WEIGHTLOST_LABEL];
//        sWeightLostLabel2.text = sWeightLostLabel.text;
//        
//        UILabel* sWeightNeedToBeLostLabel = (UILabel*)[self.mDetailViewForRecentRound viewWithTag:TAG_DETAIL_VIEW_ROUND_WEIGHTUNWANTED_LABEL];
//        if (sWeightNeedToBeLost > 0)
//        {
//            sWeightNeedToBeLostLabel.text = [NSString stringWithFormat:@"%.1fkg", sWeightNeedToBeLost];
//        }
//        else
//        {
//            sWeightNeedToBeLostLabel.text = NSLocalizedString(@"GoalReached", nil);
//        }
//        
//        UILabel* sDaysRemainedLabel = (UILabel*)[self.mDetailViewForRecentRound viewWithTag:TAG_DETAIL_VIEW_ROUND_DAYSREMAINS_LABEL];
//        if (sDaysRemaind >= 0)
//        {
//            sDaysRemainedLabel.text = [NSString stringWithFormat:@"%d%@", sDaysRemaind, NSLocalizedString(@"day(s)", nil)];
//        }
//        else
//        {
//            sDaysRemainedLabel.text = NSLocalizedString(@"closed", nil);
//        }
//        
//        mNeedUpdateStatisticsForRecentRound = NO;
//        return;
//    }
//    
//}
//
//- (PlotView*) findPlotViewByType:(ENUM_CHILDVIEW_TYPE) aType
//{
//    for (PlotView* sPlotView in self.mChildScrollViews)
//    {
//        if (sPlotView.mType == aType)
//        {
//            return sPlotView;
//        }
//    }
//    return nil;
//}
//
//#pragma mark -
//#pragma mark XLCycleScrollViewDelegate methods
//- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
//{
//    
//}
//
//- (void) prepareWeightInputView
//{
//    UIView* sContainerViewForWeightInputView = [self getContainerViewForWeightInputView];
//
//    self.mWeightInputView = [[[WeightInputView alloc] initWithFrame:CGRectMake(0, sContainerViewForWeightInputView.bounds.size.height, 320, 280)] autorelease];
//    
//    self.mWeightInputView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
//    self.mWeightInputView.mDelegate = self;
//    
//    [sContainerViewForWeightInputView addSubview:self.mWeightInputView];
//    [sContainerViewForWeightInputView bringSubviewToFront:self.mWeightInputView];
//
//}
//
//- (void) logWeight
//{
//    UIView* sContainerViewForWeightInputView = [self getContainerViewForWeightInputView];
//
//    if (self.mWeightInputView
//        && self.mWeightInputView.frame.origin.y<sContainerViewForWeightInputView.bounds.size.height)
//    {
//        
//        [self hideWeightInputView];
//    }
//    else
//    {
//        if (!self.mWeightInputView)
//        {
//            [self prepareWeightInputView];
//        }
//        
//        [self.mWeightInputView resetDateForWeightInput: [NSDate date]];
//        [sContainerViewForWeightInputView bringSubviewToFront:self.mWeightInputView];
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            CGFloat sY = sContainerViewForWeightInputView.bounds.size.height-(self.mWeightInputView.bounds.size.height);
//
//            self.mWeightInputView.frame = CGRectMake(0, sY, self.mWeightInputView.frame.size.width, self.mWeightInputView.frame.size.height);
//            self.mMainView.alpha = 0.8;
//
//        } completion:^(BOOL finished) {
//            self.mMainView.userInteractionEnabled = NO;
//        }];
//        
//    }
//}
//
//#pragma mark -
//#pragma mark delegat methods for WeightInputAreaViewDelegate
//- (void) doneWithUpdates:(BOOL)aHasUpdates
//{
//    //refresh all info and hide mWeightInputView, or just hide mWeightInputView
//    if (aHasUpdates)
//    {
//        ATMHud* sHudForSaveSuccess = [[[ATMHud alloc] initWithDelegate:self] autorelease];
//        [sHudForSaveSuccess setAlpha:0.3];
//        [sHudForSaveSuccess setDisappearScaleFactor:1];
//        [sHudForSaveSuccess setShadowEnabled:YES];
//        [self.view addSubview:sHudForSaveSuccess.view];
//
//        [sHudForSaveSuccess setCaption:NSLocalizedString(@"you have saved you weight records", nil)];
//        [sHudForSaveSuccess show];
//        [sHudForSaveSuccess hideAfter:2.0];
//        [self hideWeightInputView];
//    }
//    else
//    {
//        [self hideWeightInputView];
//    }
//}
//
//- (void) hideWeightInputView
//{
//    UIView* sContainerViewForWeightInputView = [self getContainerViewForWeightInputView];
//    if (self.mWeightInputView
//        && self.mWeightInputView.frame.origin.y<sContainerViewForWeightInputView.bounds.size.height)
//    {
//        [UIView animateWithDuration:0.45 animations:^{
//            self.mWeightInputView.frame = CGRectMake(0, sContainerViewForWeightInputView.bounds.size.height, self.mWeightInputView.frame.size.width, self.mWeightInputView.frame.size.height);
//            self.mMainView.alpha = 1.0;
//            
//        } completion:^(BOOL finished) {
//            self.mMainView.userInteractionEnabled = YES;
////            [sContainerViewForWeightInputView sendSubviewToBack:self.mWeightInputView];
//            
//        }];
// 
//    }
//
//}
//
//- (UIView*) getContainerViewForWeightInputView
//{
//    UIView* sContainerViewForWeightInputView = [[UIApplication sharedApplication] keyWindow];
////    UIView* sContainerViewForWeightInputView = self.view;
//
//    return sContainerViewForWeightInputView;
//}
//
//@end
