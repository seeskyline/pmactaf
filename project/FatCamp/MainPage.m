//
//  MainPage.m
//  FatCamp
//
//  Created by Wen Shane on 12-11-13.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "MainPage.h"
#import "WeightInputView.h"
#import "PlanInputView.h"

#import "RecentWeightView.h"
#import "RecentRoundView.h"
#import "SharedVariables.h"
#import "ATMHud.h"
#import "PageControlEx.h"


#define TAG_FOR_TITLE_LABEL_IN_NAVI_TITLEVIEW       101
#define TAG_FRO_PAGE_CONTROL_IN_NAVI_TITLEVIEW      102

@interface MainPage ()
{
    UIView* mMainView;
    
    UILabel* mDayMonthLabel;
    UILabel* mYearLabel;

    XLCycleScrollView* mHorizontalScrollView;
    NSMutableArray* mChildViews;
    NSInteger mIndexOfDisplayedChildView;
    
    UIBarButtonItem* mAddWeightBarButtonItem;
    UIBarButtonItem* mModifyPlanBarButtonItem;

    UIView* mCurPopView;
    WeightInputView* mWeightInputView;
    PlanInputView* mPlanSettingView;
}

@property (nonatomic, retain) UILabel* mDayMonthLabel;
@property (nonatomic, retain) UILabel* mYearLabel;

@property (nonatomic, retain) XLCycleScrollView* mHorizontalScrollView;
@property (nonatomic, retain) NSMutableArray* mChildViews;
@property (nonatomic, assign) NSInteger mIndexOfDisplayedChildView;
@property (nonatomic, retain) UIView* mMainView;

@property (nonatomic, retain) UIBarButtonItem* mAddWeightBarButtonItem;
@property (nonatomic, retain) UIBarButtonItem* mModifyPlanBarButtonItem;

@property (nonatomic, assign) UIView* mCurPopView;
@property (nonatomic, retain) WeightInputView* mWeightInputView;
@property (nonatomic, retain) PlanInputView* mPlanSettingView;
@end

@implementation MainPage

@synthesize mDayMonthLabel;
@synthesize mYearLabel;
@synthesize mHorizontalScrollView;
@synthesize mChildViews;
@synthesize mIndexOfDisplayedChildView;
@synthesize mMainView;
@synthesize mAddWeightBarButtonItem;
@synthesize mModifyPlanBarButtonItem;
@synthesize mCurPopView;
@synthesize mWeightInputView;
@synthesize mPlanSettingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithTitle: (NSString*)aTitle
{
    return [self init];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.mIndexOfDisplayedChildView = -1;
    }
    
    return self;
}

- (void) dealloc
{
    self.mDayMonthLabel = nil;
    self.mYearLabel = nil;
    self.mHorizontalScrollView = nil;
    self.mChildViews = nil;
    self.mMainView = nil;
    self.mAddWeightBarButtonItem = nil;
    self.mModifyPlanBarButtonItem = nil;
    self.mWeightInputView = nil;
    self.mPlanSettingView = nil;
    
    [super dealloc];
}

- (void) loadView
{
    CGRect sFrame = [[UIScreen mainScreen] applicationFrame];
    sFrame.size = CGSizeMake(sFrame.size.width, sFrame.size.height-self.navigationController.navigationBar.bounds.size.height-self.tabBarController.tabBar.bounds.size.height);
    
    UIView* sView = [[UIView alloc] initWithFrame:sFrame];
    self.view = sView;
    [sView release];
    
    
    UIView* sBGView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
    sBGView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sBGView];
    
    self.mMainView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
    self.mMainView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
    [self.view addSubview:self.mMainView];

    //1.
    mHorizontalScrollView = [[[XLCycleScrollView alloc]initWithFrame:self.view.bounds IsRepeating:NO NeedPageControl:NO] autorelease];
  
    //2. you should setPlot to prepare the subviews before set datasouce for mHorizontalScrollView
    [self prepareChildViews];
  
    NSDate* sNow = [NSDate date];
    //3. left bar button item
    UIView* sDateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    UILabel* sDayMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 67, 15)];
    NSDateFormatter* sDateForamtter = [[NSDateFormatter alloc] init];
    sDayMonthLabel.text = [sDateForamtter standardMDFormatedStringLeadigZeroCN: sNow];
//    sDateLabel.textColor = MAIN_BGCOLOR_SHALLOWer;
    sDayMonthLabel.textColor = [UIColor whiteColor];
    sDayMonthLabel.textAlignment = UITextAlignmentCenter;

    sDayMonthLabel.font = [UIFont systemFontOfSize:14];
    sDayMonthLabel.backgroundColor = [UIColor clearColor];
    [sDateView addSubview:sDayMonthLabel];
    self.mDayMonthLabel = sDayMonthLabel;
    [sDayMonthLabel release];
    
    UILabel* sYearLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 67, 15)];
    sYearLable.text = [sDateForamtter year:sNow];
    sYearLable.textColor = [UIColor lightGrayColor];
    sYearLable.textAlignment = UITextAlignmentCenter;
    sYearLable.font = [UIFont systemFontOfSize:11];
    sYearLable.backgroundColor = [UIColor clearColor];
    [sDateView addSubview:sYearLable];
    self.mYearLabel = sYearLable;
    [sYearLable release];
    [sDateForamtter release];
    
    UIBarButtonItem* sLeftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sDateView];
    [sDateView release];
    self.navigationItem.leftBarButtonItem = sLeftButtonItem;
    [sLeftButtonItem release];

    
    //4.
    self.navigationItem.titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)] autorelease];
    
    UILabel* sTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 32)];
    sTitleLabel.backgroundColor = [UIColor clearColor];
    sTitleLabel.textColor = [UIColor whiteColor];
    sTitleLabel.textAlignment = UITextAlignmentCenter;
    sTitleLabel.font = [UIFont boldSystemFontOfSize:[UIFont  buttonFontSize]+2];
    sTitleLabel.shadowColor = [UIColor grayColor];
    sTitleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    sTitleLabel.tag = TAG_FOR_TITLE_LABEL_IN_NAVI_TITLEVIEW;
    [self.navigationItem.titleView addSubview:sTitleLabel];
    [sTitleLabel release];
    
    PageControlEx* sPageControl = [[PageControlEx alloc] initWithFrame:CGRectMake(0, 32, 100, 9)];
    sPageControl.userInteractionEnabled = NO;
    sPageControl.dotColorCurrentPage = [UIColor lightGrayColor];
    sPageControl.dotColorOtherPage = MAIN_BGCOLOR_SHALLOW;
    sPageControl.backgroundColor = [UIColor clearColor];
    sPageControl.numberOfPages = self.mChildViews.count;
    sPageControl.tag = TAG_FRO_PAGE_CONTROL_IN_NAVI_TITLEVIEW;
    [self.navigationItem.titleView addSubview:sPageControl];
    [sPageControl release];
    
    //4.
    mHorizontalScrollView.datasource = self;
    mHorizontalScrollView.delegate = self;
    mHorizontalScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mHorizontalScrollView];

    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateCurDateLabel];
    [self updateChildViews];
}


- (BOOL) prepareChildViews
{
    if (!self.mHorizontalScrollView)
    {
        return NO;
    }
    
    
    if (!self.mChildViews)
    {
        self.mChildViews = [[[NSMutableArray alloc]initWithCapacity:5] autorelease];
    }
        
    UIView* sRecentWeightView = [[RecentWeightView alloc] initWithFrame:self.mHorizontalScrollView.bounds];
    [self.mChildViews addObject:sRecentWeightView];
    [sRecentWeightView release];
    
    UIView* sRecentRoundView = [[RecentRoundView alloc] initWithFrame:self.mHorizontalScrollView.bounds];
    [self.mChildViews addObject:sRecentRoundView];
    [sRecentRoundView release];
    
    return YES;
}

- (void) childViewChanged
{
    if (self.mIndexOfDisplayedChildView>=0
        && self.mIndexOfDisplayedChildView <self.mChildViews.count)
    {
        ENUM_CHILDVIEW_TYPE sTypeOfCurChildView = ((RecentView*)[self.mChildViews objectAtIndex:self.mIndexOfDisplayedChildView]).mType;
        
        UILabel* sTitleLabel = (UILabel*)[self.navigationItem.titleView viewWithTag:TAG_FOR_TITLE_LABEL_IN_NAVI_TITLEVIEW];

        switch (sTypeOfCurChildView) {
            case ENUM_VIEW_TYPE_UNDEFINED:
            {
                sTitleLabel.text = NSLocalizedString(@"MainPage", nil);
            }
                break;
            case ENUM_VIEW_TYPE_RECENT_WEIGHT:
            {
                sTitleLabel.text = NSLocalizedString(@"Recent Weight", nil);
                if (!self.mAddWeightBarButtonItem)
                {
                    UIBarButtonItem* sAddWeightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(logWeight)];
                    
                    self.mAddWeightBarButtonItem = sAddWeightBarButtonItem;
                    [sAddWeightBarButtonItem release];
                }
                
                self.navigationItem.rightBarButtonItem = self.mAddWeightBarButtonItem;
                
            }
                break;
            case ENUM_VIEW_TYPE_RECENT_ROUND:
            {
                sTitleLabel.text = NSLocalizedString(@"Recent Round", nil);
                
                if (!self.mModifyPlanBarButtonItem)
                {
                    UIBarButtonItem* sModifyPlanBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(modifyPlan)];
                    self.mModifyPlanBarButtonItem = sModifyPlanBarButtonItem;
                    [sModifyPlanBarButtonItem release];
                }
                
                self.navigationItem.rightBarButtonItem = self.mModifyPlanBarButtonItem;
            }
                break;
            default:
                break;
        }//switch-case
        
        PageControlEx* sPageControl = (PageControlEx*)[self.navigationItem.titleView viewWithTag:TAG_FRO_PAGE_CONTROL_IN_NAVI_TITLEVIEW];
        if (sPageControl)
        {
            sPageControl.currentPage = self.mIndexOfDisplayedChildView;
        }
    }//if
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateCurDateLabel
{
    NSDate* sNow = [NSDate date];
    NSDateFormatter* sDateForamtter = [[NSDateFormatter alloc] init];

    if (self.mDayMonthLabel)
    {
        self.mDayMonthLabel.text = [sDateForamtter standardMDFormatedStringLeadigZeroCN: sNow];
    }
    if (self.mYearLabel)
    {
        self.mYearLabel.text = [sDateForamtter year:sNow];
    }
    [sDateForamtter release];
}

- (void) logWeight
{
    if (!self.mWeightInputView)
    {
        UIView* sContainerViewForPopView = [self getContainerViewForPopView];
        
        self.mWeightInputView = [[[WeightInputView alloc] initWithFrame:CGRectMake(0, sContainerViewForPopView.bounds.size.height, 320, 280)] autorelease];
        
        self.mWeightInputView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
        self.mWeightInputView.mDelegate = self;
        
        [sContainerViewForPopView addSubview:self.mWeightInputView];
        [sContainerViewForPopView bringSubviewToFront:self.mWeightInputView];
    }
   
    if (self.mWeightInputView.frame.origin.y >= [self getContainerViewForPopView].bounds.size.height)
    {
        [self.mWeightInputView resetDateForWeightInput: [NSDate date]];
    }
    
        
    self.mCurPopView = self.mWeightInputView;
    
    [self showOrHidePopView];
}

- (void) modifyPlan
{
    if (!self.mPlanSettingView)
    {
        UIView* sContainerViewForPopView = [self getContainerViewForPopView];
        
        self.mPlanSettingView = [[[PlanInputView alloc] initWithFrame:CGRectMake(0, sContainerViewForPopView.bounds.size.height, 320, 280)] autorelease];
        
        self.mPlanSettingView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
        self.mPlanSettingView.mDelegate = self;
        
        [sContainerViewForPopView addSubview:self.mPlanSettingView];
        [sContainerViewForPopView bringSubviewToFront:self.mPlanSettingView];

    }
    if (self.mPlanSettingView.frame.origin.y >= [self getContainerViewForPopView].bounds.size.height)
    {
        [self.mPlanSettingView updateInitialStatus];
    }

    self.mCurPopView = self.mPlanSettingView;
    
    [self showOrHidePopView];
}

- (UIView*) getContainerViewForPopView
{
    UIView* sContainerViewForPoptView = [[UIApplication sharedApplication] keyWindow];
    //    UIView* sContainerViewForPoptView = self.view;
    
    return sContainerViewForPoptView;
}

- (void) showOrHidePopView
{
    UIView* sContainerViewForPopView = [self getContainerViewForPopView];
    
    if (self.mCurPopView
        && self.mCurPopView.frame.origin.y<sContainerViewForPopView.bounds.size.height)
    {
        
        [self hidePopView];
    }
    else
    {
        if (!self.mCurPopView)
        {
            return;
        }
        [sContainerViewForPopView bringSubviewToFront:self.mCurPopView];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat sY = sContainerViewForPopView.bounds.size.height-(self.mCurPopView.bounds.size.height);
            
            self.mCurPopView.frame = CGRectMake(0, sY, self.mCurPopView.frame.size.width, self.mCurPopView.frame.size.height);
            self.mMainView.alpha = 0.8;   
        } completion:^(BOOL finished) {
            self.mHorizontalScrollView.userInteractionEnabled = NO;
        }];
        
    }
    
}

- (void) hidePopView
{
    UIView* sContainerViewForView = [self getContainerViewForPopView];
    if (self.mCurPopView
        && self.mCurPopView.frame.origin.y<sContainerViewForView.bounds.size.height)
    {
        [UIView animateWithDuration:0.45 animations:^{
            self.mCurPopView.frame = CGRectMake(0, sContainerViewForView.bounds.size.height, self.mCurPopView.frame.size.width, self.mCurPopView.frame.size.height);
            self.mMainView.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.mHorizontalScrollView.userInteractionEnabled = YES;
            self.mCurPopView = nil;
            //            [sContainerViewForView sendSubviewToBack:self.mCurPopView];
            
        }];
        
    }
    
}

- (void) updateChildViews
{
    for (RecentView* sRecentView in self.mChildViews) {
        [sRecentView update];
    }
}

#pragma mark -
#pragma mark XLCycleScrollViewDatasource methods
- (NSInteger)numberOfPages
{
    if (self.mChildViews)
    {
        return [self.mChildViews count];
    }
    else
    {
        return 0;
    }
}

- (UIView *)pageAtIndex:(NSInteger)index aIsCurPage:(BOOL)aIsCurPage;
{
    if (index < 0
        || index >= self.mChildViews.count)
    {
        return nil;
    }
    //rember to reset the origin of subviews, cos it has been modified by mSchrollView in XLCycleScrollView
    RecentView* sChildScrollView = (RecentView*)[self.mChildViews objectAtIndex:index];
    [sChildScrollView setFrame:CGRectMake(0, 0, sChildScrollView.bounds.size.width, sChildScrollView.bounds.size.height)];
    
    if (aIsCurPage
        && (self.mIndexOfDisplayedChildView == -1
            || ((RecentView*)[self.mChildViews objectAtIndex:self.mIndexOfDisplayedChildView]).mType != sChildScrollView.mType))
    {
        self.mIndexOfDisplayedChildView = index;
        [self childViewChanged];
    }
    return sChildScrollView;
}

#pragma mark -
#pragma mark XLCycleScrollViewDelegate methods
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    
}


#pragma mark -
#pragma mark delegat methods for WeightInputAreaViewDelegate
- (void) doneWithUpdates:(BOOL)aHasUpdates
{
    //refresh all info and hide mWeightInputView, or just hide mWeightInputView
    if (aHasUpdates)
    {
        [self updateChildViews];
        
        ATMHud* sHudForSaveSuccess = [[[ATMHud alloc] initWithDelegate:self] autorelease];
        [sHudForSaveSuccess setAlpha:0.3];
        [sHudForSaveSuccess setDisappearScaleFactor:1];
        [sHudForSaveSuccess setShadowEnabled:YES];
        [self.view addSubview:sHudForSaveSuccess.view];
        
        NSString* sNotice = nil;
        if (self.mCurPopView == self.mWeightInputView)
        {
            sNotice = NSLocalizedString(@"you have saved you weight records", nil);
        }
        else if (self.mCurPopView == self.mPlanSettingView)
        {
            sNotice = NSLocalizedString(@"your plan has been saved", nil);
        }
        else
        {
            //nothing done here.
        }
        [sHudForSaveSuccess setCaption:sNotice];
        [sHudForSaveSuccess show];
        [sHudForSaveSuccess hideAfter:1.0];
        
    }

    
    [self hidePopView];
    
}



@end
