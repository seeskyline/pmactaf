//
//  PlanSettingView.m
//  FatCamp
//
//  Created by Wen Shane on 12-11-14.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "PlanInputView.h"
#import "NSDateFormatter+MyDateFormatter.h"
#import "SharedVariables.h"
#import "RoundInfo.h"
#import "StoreManager.h"
#import "CustomTableViewCell.h"
#import "CustomCellBackgroundView.h"
#import "NSDate+MyDate.h"
#import "WeightCaculator.h"
#import "CMPopTipView.h"

#define MAX_NUM_MONTH_FOR_PLAN          12
#define DURATION_TIME_POP_VIEW_HIDING   0.45

@interface PlanInputView()
{
    UILabel* mNoticeLabel;
    UITableView* mTableView;
    
    NSDate* mInitTargetDate;
    double mInitTargetWeight;
    
    NSDate* mTargetDate;
    double mTargetWeight;
    
    UIView* mCurPopView;
    DateSelectionView* mDateSelectionView;
    WeightSelectionView* mWeightSelectionView;
    
    CMPopTipView* mPopTipView;

}
@property (nonatomic, retain) UILabel* mNoticeLabel;
@property (nonatomic, retain) UITableView* mTableView;
@property (nonatomic, retain) NSDate* mInitTargetDate;
@property (nonatomic, assign) double mInitTargetWeight;
@property (nonatomic, retain) NSDate* mTargetDate;
@property (nonatomic, assign) double mTargetWeight;

@property (nonatomic, assign) UIView* mCurPopView;
@property (nonatomic, retain) DateSelectionView* mDateSelectionView;
@property (nonatomic, retain) WeightSelectionView* mWeightSelectionView;

@property (nonatomic, retain) CMPopTipView* mPopTipView;
@end

@implementation PlanInputView
@synthesize mDelegate;

@synthesize mNoticeLabel;
@synthesize mTableView;

@synthesize mInitTargetDate;
@synthesize mInitTargetWeight;

@synthesize mTargetDate;
@synthesize mTargetWeight;

@synthesize mCurPopView;
@synthesize mDateSelectionView;
@synthesize mWeightSelectionView;

@synthesize mPopTipView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self constructSubviews];
        [self updateInitialStatus];
    }
    return self;
}

- (void) dealloc
{
    self.mNoticeLabel = nil;
    self.mTableView = nil;
    
    self.mInitTargetDate = nil;
    self.mTargetDate = nil;
    
    self.mDateSelectionView = nil;
    self.mWeightSelectionView = nil;
    
    self.mPopTipView = nil;
    
    [super dealloc];
}

- (void) constructSubviews
{
    //1.button bar
    CGFloat sHeightOfBtnBar = 44;
    CGFloat sX = 0;
    CGFloat sY = 0;
    CGFloat sWidth = 320;
    CGFloat sHeight = sHeightOfBtnBar;
    
    UINavigationBar* sBtnBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    sBtnBar.barStyle = UIBarStyleDefault;
    
    UINavigationItem* sNavItem = [[[UINavigationItem alloc] initWithTitle:NSLocalizedString(@"set plan", nil) ] autorelease];
    
    sNavItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"confirm", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(confirmBtnPressed)] autorelease];
    sNavItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnPressed)] autorelease];
    
    [sBtnBar pushNavigationItem:sNavItem animated:NO];
    
    [self addSubview:sBtnBar];
    [sBtnBar release];
    
    
   
    //2. notice label
    sY += sHeight;
    sHeight = 25;
    
    UILabel* sLabel =[[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    sLabel.backgroundColor = [UIColor lightGrayColor];
    sLabel.textColor = [UIColor whiteColor];
    sLabel.font = [UIFont systemFontOfSize:13];
    sLabel.text = NSLocalizedString(@"Your last plan will be overidden if you modify", nil);
    sLabel.textAlignment = UITextAlignmentCenter;
    
    [self addSubview: sLabel];
    self.mNoticeLabel = sLabel;
    [sLabel release];

     //3.
    sY += sHeight+10;
//    sHeight = self.bounds.size.height-sY;
    sHeight = 100;
    UITableView* sTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, sY, 320, sHeight) style:UITableViewStyleGrouped];
    sTableView.dataSource = self;
    sTableView.delegate = self;
    sTableView.bounces = NO;
    [sTableView setBackgroundView:nil];
    [sTableView setBackgroundColor:[UIColor clearColor]];
    sTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self addSubview:sTableView];
    self.mTableView = sTableView;
    [sTableView release];
    
    CMPopTipView* sPopTipView = [[CMPopTipView alloc] initWithMessage:@"tips"];
    sPopTipView.center = CGPointMake(sPopTipView.center.x+30, sPopTipView.center.y-30);
    sPopTipView.textColor = [UIColor grayColor];
    sPopTipView.backgroundColor = [UIColor whiteColor];
    sPopTipView.disableTapToDismiss = YES;
    sPopTipView.animation = CMPopTipAnimationPop;
    
    self.mPopTipView = sPopTipView;
    [sPopTipView release];
    

    
    [self prepareDateSelectionView];
    [self prepareWeightSelectionView];

}

- (void) prepareDateSelectionView
{
    self.mDateSelectionView = [[[DateSelectionView alloc] initWithFrame:CGRectMake(320, 0, self.bounds.size.width, self.bounds.size.height) InitDate:[NSDate date] MinDate:[NSDate date] MaxDate:[[NSDate date] monthOffset:MAX_NUM_MONTH_FOR_PLAN]] autorelease];
    
    //test
//    self.mDateSelectionView = [[[DateSelectionView alloc] initWithFrame:CGRectMake(320, 0, self.bounds.size.width, self.bounds.size.height) InitDate:[NSDate date] MinDate:[[NSDate date] dateByAddingTimeInterval: -SECONDS_FOR_ONE_DAY*10 ] MaxDate:[[NSDate date] monthOffset:MAX_NUM_MONTH_FOR_PLAN]] autorelease];

    
    self.mDateSelectionView.mDelegate = self;
    
    [self addSubview:self.mDateSelectionView];
    
}

- (void) prepareWeightSelectionView
{
    self.mWeightSelectionView = [[[WeightSelectionView alloc] initWithFrame:CGRectMake(320, 0, self.bounds.size.width, self.bounds.size.height) InitWeight:self.mTargetWeight Title:NSLocalizedString(@"set target weight", nil)] autorelease];
    self.mWeightSelectionView.mDelegate = self;
    
    [self addSubview:self.mWeightSelectionView];
    
}


- (void) updateInitialStatus
{
    RoundInfo* sLastRound = [StoreManager getLastRound];
    if (sLastRound
        && [sLastRound isUnderway])
    {
        self.mNoticeLabel.hidden = NO;
        self.mInitTargetDate = sLastRound.mEndDate;
        self.mInitTargetWeight = sLastRound.mTargetWeight;
    }
    else
    {
        self.mNoticeLabel.hidden = YES;
        self.mInitTargetDate = nil;
        self.mInitTargetWeight = -1;
    }
    
    self.mTargetDate = self.mInitTargetDate;
    self.mTargetWeight = self.mInitTargetWeight;
        
    [self refresh];
}

- (void) refresh
{
    [self refreshInfoBoard];
    [self.mTableView reloadData];
    
    

}

- (void) refreshInfoBoard
{
    if ([self newTargetValid])
    {
        NSTimer* sTimer = [[NSTimer alloc]initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:DURATION_TIME_POP_VIEW_HIDING]  interval:1 target:self selector:@selector(displayTipView) userInfo:nil repeats:NO];
        
        [[NSRunLoop currentRunLoop] addTimer:sTimer forMode:NSDefaultRunLoopMode];
        [sTimer release];
    }
    else
    {
        self.mPopTipView.hidden = YES;
    }
}

- (void) displayTipView
{
    NSDate* sNow = [NSDate date];
    NSInteger sTargetDays = [self.mTargetDate ceilingDaysSinceStartingOfDate:sNow];
    double sWeight = [StoreManager getMostRecentWeight];
    double sTargetLost = self.mTargetWeight - sWeight;
    double sTargetRate = 7*(sTargetLost/sTargetDays); //kg lost per week
    
    self.mPopTipView.hidden = NO;
    
    NSString* sTargetDaysStr = [NSString stringWithFormat:@"%d%@", sTargetDays, NSLocalizedString(@"day(s)", nil)];
    NSString* sTargetLostStr = [WeightCaculator formatWeightDiffWithPlusOrNegtiveSign:sTargetLost];
    NSString* sTargetRateStr = [NSString stringWithFormat:@"%@/%@", [WeightCaculator formatWeightDiffWithPlusOrNegtiveSignTwoDigits:sTargetRate],  NSLocalizedString(@"week(s)", nil)];
    
    self.mPopTipView.message = [NSString stringWithFormat:NSLocalizedString(@"Duration Time:%@ Target Lost:%@ Target Rate:%@", nil), sTargetDaysStr, sTargetLostStr, sTargetRateStr];
    [self.mPopTipView presentPointingAtView:self.mTableView inView:self animated:YES];
}


- (BOOL) newTargetValid
{
    if (self.mTargetDate
        && self.mTargetWeight>0)
    {
        if (!self.mInitTargetDate
            || self.mInitTargetWeight<=0
            || [self.mTargetDate timeIntervalSince1970] != [self.mInitTargetDate timeIntervalSince1970]
            || self.mTargetWeight != self.mInitTargetWeight)
        {
            return YES;
        }
    }
    return NO;
}

- (void) confirmBtnPressed
{
    if ([self newTargetValid])
    {
       if (self.mInitTargetWeight != -1)
       {
           RoundInfo* sLastRound = [StoreManager getLastRound];
           if (sLastRound.mStatus == ENUM_ROUND_STATUS_UNDERWAY)
           {
               [StoreManager UpdateROundStatus:ENUM_ROUND_STATUS_DONE_CANCELED RoundID:sLastRound.mRoundID];
           }
       }
       
       BOOL sStored = [StoreManager addRoundInfoWithStartTime:[NSDate date] aEndTime:self.mTargetDate aTargetWeight:self.mTargetWeight aStatus:ENUM_ROUND_STATUS_UNDERWAY];
        
        //test
//        BOOL sStored = [StoreManager addRoundInfoWithStartTime:[self.mTargetDate dateByAddingTimeInterval:-SECONDS_FOR_ONE_DAY*15] aEndTime:self.mTargetDate aTargetWeight:self.mTargetWeight aStatus:ENUM_ROUND_STATUS_UNDERWAY];

        
       
       [self.mDelegate doneWithUpdates:sStored];
    }
    else
    {
        [self.mDelegate doneWithUpdates:NO];      
    }
}

- (void) cancelBtnPressed
{
    [self.mDelegate doneWithUpdates:NO];
}

- (void) presentPopView
{
    if (self.mCurPopView)
    {
//        [self.mPopTipView dismissAnimated:YES];
        self.mPopTipView.hidden = YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.mCurPopView.frame = self.bounds;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void) hidePopView
{
    if (self.mCurPopView)
    {
        [UIView animateWithDuration:DURATION_TIME_POP_VIEW_HIDING animations:^{
            self.mCurPopView.frame = CGRectMake(320, self.mCurPopView.frame.origin.y, self.frame.size.width, self.frame.size.height);
            
        } completion:^(BOOL finished) {
        }];
        
    }
    
}


#pragma mark -
#pragma mark tableview's datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 2;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* sCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (!sCell)
    {
        sCell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
        sCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        sCell.backgroundColor = [UIColor clearColor];
        sCell.textLabel.textColor = COLOR_TRIVAL_TEXT;
        sCell.detailTextLabel.textColor = MAIN_BGCOLOR_SHALLOWer;
        
        CustomCellBackgroundView* sBGView = [CustomCellBackgroundView backgroundCellViewWithFrame:sCell.frame Row:[indexPath row] totalRow:[tableView numberOfRowsInSection:[indexPath section]] borderColor:SELECTED_CELL_COLOR fillColor:SELECTED_CELL_COLOR tableViewStyle:tableView.style];
        sCell.selectedBackgroundView = sBGView;

    }
    
    NSInteger sRow = [indexPath row];
    
    switch (sRow) {
        case 0:
        {
//            sCell.detailTextLabel.font = [UIFont systemFontOfSize:20];
//            sCell.backgroundColor = [UIColor clearColor];

            sCell.textLabel.text = NSLocalizedString(@"target date", nil);
            NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
            NSString* sDateStr = [sDateFormatter standardYMDFormatedStringLeadigZeroCN: self.mTargetDate];
            
            
            if (self.mTargetDate)
            {
                if([self.mTargetDate timeIntervalSince1970] == [self.mInitTargetDate timeIntervalSince1970])
                {
                    sCell.detailTextLabel.textColor = COLOR_WARTER_MARK;
                }
                else
                {
                    sCell.detailTextLabel.textColor = MAIN_BGCOLOR;
                }
                sCell.detailTextLabel.text = sDateStr;
            }
            else
            {
                sCell.detailTextLabel.textColor = COLOR_WARTER_MARK;
                sCell.detailTextLabel.text = NSLocalizedString(@"no record(s) yet", nil);
            }
            
        }
            break;
        case 1:
        {
//            sCell.backgroundColor = [UIColor whiteColor];
            
            sCell.textLabel.text = NSLocalizedString(@"target weight", nil);
            sCell.detailTextLabel.font = [UIFont boldSystemFontOfSize:30];

            
            if (-1 != self.mTargetWeight)
            {
                if(self.mTargetWeight == self.mInitTargetWeight)
                {
                    sCell.detailTextLabel.textColor = COLOR_WARTER_MARK;
                }
                else
                {
                    sCell.detailTextLabel.textColor = MAIN_BGCOLOR;
                }
                sCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fkg", self.mTargetWeight];
            }
            else
            {
                sCell.detailTextLabel.textColor = COLOR_WARTER_MARK;
                sCell.detailTextLabel.text = NSLocalizedString(@"no record(s) yet", nil);
            }
        }
            break;
        default:
            break;
    }
    
    return sCell;
}


#pragma mark -
#pragma mark tableview delegate methods

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger sRow = [indexPath row];
//    
//    CGFloat sRowHeight;
//    switch (sRow) {
//        case 0:
//        {
//            sRowHeight = 43;
//        }
//            break;
//        case 1:
//        {
//            sRowHeight = 65;
//        }
//            break;
//        default:
//        {
//            sRowHeight = 0;
//        }
//            break;
//    }
//    
//    return sRowHeight;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sRow = [indexPath row];
    
    switch (sRow) {
        case 0:
        {
            [self.mDateSelectionView resetInitDate:self.mTargetDate];
            self.mCurPopView = self.mDateSelectionView;
            [self presentPopView];
        }
            break;
        case 1:
        {
            [self.mWeightSelectionView resetInitWeight:self.mTargetWeight];
            self.mCurPopView = self.mWeightSelectionView;
            [self presentPopView];
        }
            break;
        default:
            break;
    }
}


#pragma mark -
#pragma mark delegate methods for DateInputDelegate
- (void) doneWithDate:(NSDate*)aDateSelected aIsDiffFromInitDate:(BOOL)aDateIsNew;
{
    if (aDateIsNew)
    {
        self.mTargetDate = aDateSelected;
    }
    [self hidePopView];
    
    [self refresh];
}

#pragma mark -
#pragma mark delegate methods for WeightelectionDelegate
- (void) doneWithWeightSelected:(double)aWeight
{
    self.mTargetWeight = aWeight;
    [self hidePopView];
    
    [self refresh];
}

- (void) doneWithoutSelection
{
    [self hidePopView];
    return;
}

- (void) weightInSelectionStatus:(double)aWeight
{
    return;
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
