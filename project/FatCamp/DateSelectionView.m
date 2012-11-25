//
//  DatePickerView.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-28.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "DateSelectionView.h"
#import "NSDate+MyDate.h"
#import "NSDateFormatter+MyDateFormatter.h"

#import "SharedVariables.h"

@interface DateSelectionView()
{
    UINavigationBar* mNavBar;
    UIDatePicker* mDatePicker;
    NSDate* mDateSelected;
    NSDate* mInitDate;
}

@property (nonatomic, retain) UINavigationBar* mNavBar;
@property (nonatomic, retain) UIDatePicker* mDatePicker;
@property (nonatomic, retain) NSDate* mDateSelected;
@property (nonatomic, retain) NSDate* mInitDate;

@end


@implementation DateSelectionView

@synthesize mNavBar;
@synthesize mDatePicker;
@synthesize mInitDate;
@synthesize mDateSelected;
@synthesize mDelegate;

- (id)initWithFrame:(CGRect)frame InitDate:(NSDate*)aInitDate MinDate:(NSDate*)aMinDate MaxDate:(NSDate*)aMaxDate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mInitDate = aInitDate;
        [self prepareDatePickerWithInitDate:aInitDate MinDate:aMinDate MaxDate:aMaxDate];
    }
    return self;
}

- (void) dealloc
{
    self.mNavBar = nil;
    self.mDatePicker = nil;
    self.mDateSelected = nil;
    self.mInitDate = nil;

    [super dealloc];
}

- (void) resetInitDate:(NSDate*)aInitDate;
{
    self.mInitDate = aInitDate;
    if (self.mInitDate)
    {
        self.mDateSelected = self.mInitDate;
    }
    else
    {
        self.mDateSelected = [NSDate date];
    }
    
    [self.mDatePicker setDate:self.mDateSelected animated:NO];
    [self refreshNavBar];
}

- (void) prepareDatePickerWithInitDate:(NSDate*)aInitDate MinDate:(NSDate*)aMinDate MaxDate:(NSDate*)aMaxDate
{
//    CGFloat sHeightOfDatePicker = 216;

    //1. button bar
    CGFloat sHeightOfNavBar = 44;
    CGFloat sHeightOfDatePicker = self.bounds.size.height - sHeightOfNavBar;
    CGFloat sX = 0;
    CGFloat sY = 0;
    CGFloat sWidth = self.bounds.size.width;
    CGFloat sHeight = sHeightOfNavBar;
    self.mNavBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    self.mNavBar.barStyle = UIBarStyleDefault;
  
    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    
    
    UINavigationItem* sNavItem = [[[UINavigationItem alloc] initWithTitle: [sDateFormatter standardYMDFormatedStringLeadigZero:self.mInitDate] ] autorelease];
    sNavItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"confirm", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(cfmBtnPressed)] autorelease];
    sNavItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnPressed)] autorelease];
    
    
    [self.mNavBar pushNavigationItem:sNavItem animated:NO];
    [self addSubview:self.mNavBar];

    sY += sHeight;
    sHeight = sHeightOfDatePicker;
    
    //2. datepicker
    self.mDatePicker = [[[UIDatePicker alloc] initWithFrame:CGRectMake(0, sY, 100, sHeight)] autorelease];
    self.mDatePicker.timeZone = [NSTimeZone localTimeZone];
    self.mDatePicker.datePickerMode = UIDatePickerModeDate;
    self.mDatePicker.minimumDate = aMinDate;
    self.mDatePicker.maximumDate = aMaxDate;
    [self.mDatePicker setDate: self.mInitDate animated:NO];
    [self.mDatePicker addTarget:self action:@selector(datePickerValueChange) forControlEvents:UIControlEventValueChanged];
  
    
    CGFloat sSystemHeightOfPicker = self.mDatePicker.bounds.size.height;
    if (sSystemHeightOfPicker != sHeightOfDatePicker)
    {
        CGAffineTransform sTransform = CGAffineTransformMakeScale(1, sHeightOfDatePicker/sSystemHeightOfPicker);
        self.mDatePicker.transform = sTransform;
        self.mDatePicker.center = CGPointMake(self.mDatePicker.center.x, sY+sHeightOfDatePicker/2);
    }
    
    [self addSubview:self.mDatePicker];
}

- (void) datePickerValueChange
{
    self.mDateSelected = [self.mDatePicker date];
    [self refreshNavBar];
}

- (void) refreshNavBar
{
    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    self.mNavBar.topItem.title = [sDateFormatter standardYMDFormatedStringLeadigZero:self.mDateSelected];

}

- (void) cfmBtnPressed
{
    if ([self.mDateSelected isSameDayWith:self.mInitDate])
    {
        [self.mDelegate doneWithDate:self.mInitDate aIsDiffFromInitDate:NO];
    }
    else
    {
        [self.mDelegate doneWithDate:self.mDateSelected aIsDiffFromInitDate:YES];
    }
}

- (void) cancelBtnPressed
{
    [self.mDelegate doneWithDate:self.mInitDate aIsDiffFromInitDate:NO];
}
@end
