//
//  WeightInputAreaView.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "WeightInputView.h"
#import "SharedVariables.h"
#import "NSDateFormatter+MyDateFormatter.h"
#import "NSDate+MyDate.h"
#import "UIButtonLarge.h"
#import "StoreManager.h"

@interface WeightInputView()
{
    UILabel* mWeightInputNoticeLabel;
    UILabel* mWeightInputBoxLabel;
    NSDate* mDateForWeightInput;
    CGFloat mInitWeightForCurDate;
    
    DateSelectionView* mDateSelectionView;
    WeightSelectionView* mWeightSelectionView;
    
    BOOL mWeightModified;
    
}

@property (nonatomic, retain) UILabel* mWeightInputNoticeLabel;
@property (nonatomic, retain) UILabel* mWeightInputBoxLabel;
@property (nonatomic, retain) NSDate* mDateForWeightInput;
@property (nonatomic, assign) CGFloat mInitWeightForCurDate;

@property (nonatomic, retain) DateSelectionView* mDateSelectionView;
@property (nonatomic, retain) WeightSelectionView* mWeightSelectionView;

@property (nonatomic, assign) BOOL mWeightModified;


@end

@implementation WeightInputView

@synthesize mWeightInputNoticeLabel;
@synthesize mWeightInputBoxLabel;
@synthesize mDateForWeightInput;
@synthesize mDelegate;
@synthesize mDateSelectionView;
@synthesize mWeightSelectionView;
@synthesize mInitWeightForCurDate;
@synthesize mWeightModified;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mDateForWeightInput = [NSDate date];
        self.mWeightModified = NO;

        [self prepareSubViews];
        [self prepareDateInputView];
        
        [self resetDateForWeightInput:self.mDateForWeightInput];
    }
    return self;
}

- (void) dealloc
{
    self.mWeightInputNoticeLabel = nil;
    self.mWeightInputBoxLabel = nil;
    self.mDateForWeightInput = nil;
    
    self.mDateSelectionView = nil;
    
    [super dealloc];
}


- (void) prepareSubViews
{
    
    CGFloat sWidth = 320;
    CGFloat sHeight = 20;
    CGFloat sX = 0;
    CGFloat sY = 5;
    self.mWeightInputNoticeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    self.mWeightInputNoticeLabel.textAlignment = UITextAlignmentCenter;
    self.mWeightInputNoticeLabel.font = [UIFont systemFontOfSize:15];
    self.mWeightInputNoticeLabel.textColor = COLOR_TRIVAL_TEXT;
    self.mWeightInputNoticeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mWeightInputNoticeLabel];
    
    //
    sX = 0;
    sY += sHeight;
    sWidth = 320;
    sHeight = 40;
    self.mWeightInputBoxLabel = [[[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    self.mWeightInputBoxLabel.textAlignment = UITextAlignmentCenter;
    self.mWeightInputBoxLabel.textColor = MAIN_BGCOLOR;
    self.mWeightInputBoxLabel.font = [UIFont boldSystemFontOfSize:30];
    self.mWeightInputBoxLabel.backgroundColor = MAIN_BGCOLOR_TABPAGE;
    [self addSubview:self.mWeightInputBoxLabel];
    
    //
//    UIImageView* sCalImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cal20.png"]] autorelease];
    UIButtonLarge* sCalButton = [UIButtonLarge buttonWithType:UIButtonTypeCustom];
    [sCalButton setImage:[UIImage imageNamed:@"cal20.png"] forState:UIControlStateNormal];
    [sCalButton setFrame:CGRectMake(265, 5, 20, 26)];
    sCalButton.mMarginInsets = UIEdgeInsetsMake(5, 20, 12, 0);
    sCalButton.showsTouchWhenHighlighted = YES;
    [sCalButton addTarget:self action:@selector(calBtnPressed) forControlEvents:UIControlEventTouchUpInside];
//    [sButton setFrame:CGRectMake(265, 5, 50, 36)];

    [self addSubview:sCalButton];
    
    UIButtonLarge* sButtonNext = [UIButtonLarge buttonWithType:UIButtonTypeCustom];
    [sButtonNext setImage:[UIImage imageNamed:@"next12.png"] forState:UIControlStateNormal];
    [sButtonNext setFrame:CGRectMake(285, 5, 12, 26)];
    sButtonNext.mMarginInsets = UIEdgeInsetsMake(5, 0, 12, 33);
    sButtonNext.showsTouchWhenHighlighted = YES;
    [sButtonNext addTarget:self action:@selector(calBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    //    [sButton setFrame:CGRectMake(265, 5, 50, 36)];
    
    [self addSubview:sButtonNext];
 
    CGFloat sHeightOfWeightSelectionView = 206;
    //
    sX = 0;
    sY = self.bounds.size.height - sHeightOfWeightSelectionView;
    sWidth = 320;
    sHeight = sHeightOfWeightSelectionView;

    WeightSelectionView* sWeightSelectionView = [[WeightSelectionView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight) InitWeight:-1 Title:nil InitWeightComparisionNotice:YES];
    sWeightSelectionView.mDelegate = self;
    
    [self addSubview:sWeightSelectionView];
    self.mWeightSelectionView = sWeightSelectionView;
    [sWeightSelectionView release];
}

- (void) prepareDateInputView
{
    self.mDateSelectionView = [[[DateSelectionView alloc] initWithFrame:CGRectMake(320, 0, self.bounds.size.width, self.bounds.size.height) InitDate:self.mDateForWeightInput MinDate:[[NSDate date] beginningOfLastYearInLocalZone] MaxDate:[NSDate date]] autorelease];
    self.mDateSelectionView.mDelegate = self;
    
    [self addSubview:self.mDateSelectionView];

}

- (void) resetDateForWeightInput:(NSDate*)aDate
{
    self.mDateForWeightInput = aDate;
    //1. refresh notice
    [self refreshWeightInputNoticeLabel];
    
    self.mInitWeightForCurDate = [StoreManager getWeightByDate:self.mDateForWeightInput];
    
    //2. refresh input box
    [self refreshWeightInputBoxWithValue:self.mInitWeightForCurDate aIsInitWeight:YES];
   
    //3. refresh weight selection view.
    [self.mWeightSelectionView resetInitWeight:self.mInitWeightForCurDate];
}

- (void) refreshWeightInputNoticeLabel
{
    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    NSString* sDateStr = [sDateFormatter standardYMDFormatedStringLeadigZeroMoreReadable:self.mDateForWeightInput];
    
    self.mWeightInputNoticeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"save weight for someday %@", nil), sDateStr];
}

- (void) refreshWeightInputBoxWithValue:(CGFloat)aWeightValue aIsInitWeight:(BOOL)aIsInitWeight
{
    if (aIsInitWeight
        || aWeightValue == self.mInitWeightForCurDate)
    {
        self.mWeightInputBoxLabel.textColor = COLOR_WARTER_MARK;
        self.mWeightModified = NO;
//        self.mBtnBar.topItem.rightBarButtonItem.enabled = NO;
    }
    else
    {
        self.mWeightInputBoxLabel.textColor = MAIN_BGCOLOR;
        self.mWeightModified = YES;
//        self.mBtnBar.topItem.rightBarButtonItem.enabled = YES;
    }

    CGFloat sWeightValue = aWeightValue;
    if (aWeightValue < 0)
    {
        sWeightValue = 0.0;
    }
    NSString* sText = [NSString stringWithFormat:@"%.1f kg", sWeightValue];
    self.mWeightInputBoxLabel.text = sText;
    
}

- (void) calBtnPressed
{
    [self presentDateSelectionView];
}

- (void) presentDateSelectionView
{    
    if (!self.mDateSelectionView)
    {
        [self prepareDateInputView];
    }
    [self.mDateSelectionView resetInitDate:self.mDateForWeightInput];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mDateSelectionView.frame = self.bounds;        
    } completion:^(BOOL finished) {
    }];

    
}

- (void) hideDateSelectionView
{
    if (self.mDateSelectionView)
    {
        [UIView animateWithDuration:0.45 animations:^{
            self.mDateSelectionView.frame = CGRectMake(320, self.mDateSelectionView.frame.origin.y, self.frame.size.width, self.frame.size.height);
            
        } completion:^(BOOL finished) {
        }];
    
    }

}


#pragma mark -
#pragma mark delegate methods for DateSelectionDelegate
- (void) doneWithDate:(NSDate*)aDateSelected aIsDiffFromInitDate:(BOOL)aDateIsNew;
{
    if (aDateIsNew)
    {
        [self resetDateForWeightInput:aDateSelected];
    }
    [self hideDateSelectionView];

}

#pragma mark -
#pragma mark delegate methods for WeightelectionDelegate
- (void) doneWithWeightSelected:(double)aWeight
{
    if (self.mWeightModified)
    {
        if ([StoreManager addOrUpdateWeight:aWeight aDate:self.mDateForWeightInput])
        {
            [self.mDelegate doneWithUpdates:YES];
        }
        else
        {
            [self.mDelegate doneWithUpdates:NO];
        }

    }
    [self.mDelegate doneWithUpdates:NO];
}

- (void) doneWithoutSelection
{
    [self.mDelegate doneWithUpdates:NO];
}

- (void) weightInSelectionStatus:(double)aWeight
{
    [self refreshWeightInputBoxWithValue:aWeight aIsInitWeight:NO];
   
}

@end
