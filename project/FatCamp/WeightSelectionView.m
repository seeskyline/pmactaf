//
//  WeightSelectionView.m
//  FatCamp
//
//  Created by Wen Shane on 12-11-15.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "WeightSelectionView.h"
#import "StoreManager.h"

@interface WeightSelectionView()
{
    UINavigationBar* mBtnBar;
    UIPickerView* mWeightDataPicker;
    
    NSMutableArray* mWeightDataValueInteger;
    NSMutableArray* mWeightDataValueDigit;
    
    double mInitWeight;
    double mCurWeight;
    
    BOOL mInitWeightComparisonNotification;
}

@property (nonatomic, retain) UINavigationBar* mBtnBar;
@property (nonatomic, retain) UIPickerView* mWeightDataPicker;
@property (nonatomic, retain) NSMutableArray* mWeightDataValueInteger;
@property (nonatomic, retain) NSMutableArray* mWeightDataValueDigit;

@property (nonatomic, assign) double mInitWeight;
@property (nonatomic, assign) double mCurWeight;

@property (nonatomic, assign) BOOL mInitWeightComparisonNotification;
@end

@implementation WeightSelectionView

@synthesize mDelegate;
@synthesize mBtnBar;
@synthesize mWeightDataPicker;
@synthesize mWeightDataValueInteger;
@synthesize mWeightDataValueDigit;
@synthesize mInitWeight;
@synthesize mCurWeight;
@synthesize mInitWeightComparisonNotification;



- (id)initWithFrame:(CGRect)frame InitWeight:(double)aInitWeight
{
    return [self initWithFrame:frame InitWeight:aInitWeight Title:nil];
}


- (id)initWithFrame:(CGRect)frame InitWeight:(double)aInitWeight Title:(NSString*)aTitle
{
    return [self initWithFrame:frame InitWeight:aInitWeight Title:aTitle InitWeightComparisionNotice:NO];
}

- (id)initWithFrame:(CGRect)frame InitWeight:(double)aInitWeight Title:(NSString*)aTitle InitWeightComparisionNotice:(BOOL)aInitWeightComparisionNotice
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mInitWeight = aInitWeight;
        self.mInitWeightComparisonNotification = aInitWeightComparisionNotice;
        [self prepareDataForWeightPicker];
        [self constructSubviewsWithTitle:aTitle];
        [self resetInitWeight:self.mInitWeight];
    }
    return self;
}

- (void) dealloc
{
    self.mBtnBar = nil;
    self.mWeightDataPicker = nil;
    self.mWeightDataValueInteger = nil;
    self.mWeightDataValueDigit = nil;
    
    
    [super dealloc];
}

- (void)constructSubviewsWithTitle:(NSString*)aTitle
{
    //the minmum height of picker is 162
//    CGFloat sHeightOfPicker = 162;
    
    CGFloat sHeightOfBtnBar = 44;

    //
    CGFloat sX = 0;
    CGFloat sY = 0;
    CGFloat sWidth = 320;
    CGFloat sHeight = sHeightOfBtnBar;
    
    UINavigationBar* sBtnBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    sBtnBar.barStyle = UIBarStyleDefault;
    
    UINavigationItem* sNavItem = [[[UINavigationItem alloc] initWithTitle:aTitle ] autorelease];
    sNavItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"save", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(saveBtnPressed)] autorelease];
    sNavItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnPressed)] autorelease];
    
    [sBtnBar pushNavigationItem:sNavItem animated:NO];
    [self addSubview:sBtnBar];
    self.mBtnBar = sBtnBar;
    [sBtnBar release];
 
    
    CGFloat sHeightOfPicker = self.bounds.size.height-sHeightOfBtnBar;
    sX = 0;
    sY += sHeight;
    sWidth = 320;
    sHeight = sHeightOfPicker;

    
    UIPickerView* sWeightDataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    sWeightDataPicker.dataSource = self;
    sWeightDataPicker.delegate = self;
    sWeightDataPicker.showsSelectionIndicator = YES;
    
    CGFloat sSystemHeightOfPicker = sWeightDataPicker.bounds.size.height;
    if (sSystemHeightOfPicker != sHeightOfPicker)
    {
        CGAffineTransform sTransform = CGAffineTransformMakeScale(1, sHeightOfPicker/sSystemHeightOfPicker);
        sWeightDataPicker.transform = sTransform;
        sWeightDataPicker.center = CGPointMake(sWeightDataPicker.center.x, sY+sHeightOfPicker/2);
    }

    
    [self addSubview:sWeightDataPicker];
    
    self.mWeightDataPicker = sWeightDataPicker;
    [sWeightDataPicker release];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) prepareDataForWeightPicker
{
    self.mWeightDataValueInteger = [[[NSMutableArray alloc] initWithCapacity:121] autorelease];
    for (NSInteger i=30; i<=150; i++)
    {
        [self.mWeightDataValueInteger addObject:[NSNumber numberWithInteger:i]];
    }
    
    self.mWeightDataValueDigit = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    for (NSInteger i=0; i<=9; i++)
    {
        [self.mWeightDataValueDigit addObject:[NSNumber numberWithFloat:i*0.1]];
    }
    
    return;
}

- (BOOL) isValueValid:(CGFloat)aValue
{
    if (aValue<30.0
        || aValue>150.9)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    
}

- (CGFloat) getValueFromWeightPikerByRowIndex0: (NSInteger)aRowIndex0 aRowIndex1:(NSInteger)aRowIndex1
{
    NSInteger sValueInteger = ((NSNumber*)[self.mWeightDataValueInteger objectAtIndex:aRowIndex0]).integerValue;
    CGFloat sValueDigit = ((NSNumber*)[self.mWeightDataValueDigit objectAtIndex:aRowIndex1]).floatValue;
    
    return (sValueInteger+sValueDigit);
}

- (void) getFromPickerRowIndex0:(NSInteger*)aRowIndex0 RowIndex1:(NSInteger*)aRowIndex1 ByValue:(CGFloat)aValue
{
    NSInteger sValueInteger = (NSInteger)aValue;
    NSInteger sValueDigit = aValue*10-sValueInteger*10;
    
    if (sValueInteger<30
        || sValueInteger>150)
    {
        *aRowIndex0 = -1;
    }
    else
    {
        *aRowIndex0 = sValueInteger-30;
    }
    
    if (sValueDigit<0
        || sValueDigit >9)
    {
        *aRowIndex1 = -1;
    }
    else
    {
        *aRowIndex1 = sValueDigit;
    }
    
    return;
    
}

- (void) saveBtnPressed
{    
    NSInteger sSelectedRowInCompoent0 = [self.mWeightDataPicker selectedRowInComponent:0];
    NSInteger sSelecteRowInComponent1 = [self.mWeightDataPicker selectedRowInComponent:1];
    CGFloat sNewWeight = [self getValueFromWeightPikerByRowIndex0:sSelectedRowInCompoent0 aRowIndex1:sSelecteRowInComponent1];

    [self.mDelegate doneWithWeightSelected:sNewWeight];
}

- (void) cancelBtnPressed
{
    [self.mDelegate doneWithoutSelection];
}

- (void) resetInitWeight:(double)aInitWeight
{
    self.mInitWeight = aInitWeight;

    if ([self isValueValid:self.mInitWeight])
    {
        self.mCurWeight = self.mInitWeight;
    }
    else
    {
        CGFloat sLastNewWeight = [StoreManager getMostRecentWeight];
        if ([self isValueValid:sLastNewWeight])
        {
            self.mCurWeight = (NSInteger)sLastNewWeight;
        }
        else
        {
            self.mCurWeight = [self getValueFromWeightPikerByRowIndex0:0 aRowIndex1:0];
        }
    }
    
    //refresh weight picker
    NSInteger sRowSelected0;
    NSInteger sRowSelected1;
    
    [self getFromPickerRowIndex0:&sRowSelected0 RowIndex1:&sRowSelected1 ByValue:self.mCurWeight];

//    if ([self isValueValid:aInitWeight])
//    {
//        [self getFromPickerRowIndex0:&sRowSelected0 RowIndex1:&sRowSelected1 ByValue:aInitWeight];
//    }
//    else
//    {
//        CGFloat sLastNewWeight = [StoreManager getMostRecentWeight];
//        if ([self isValueValid:sLastNewWeight])
//        {
//            [self getFromPickerRowIndex0:&sRowSelected0 RowIndex1:&sRowSelected1 ByValue:sLastNewWeight];
//            //cos most of the time user will ignore the digit info, so 0 is prefered here.
//            sRowSelected1 = 0;
//        }
//        else
//        {
//            sRowSelected0 = 0;
//            sRowSelected1 = 0;
//        }
//    }
    
    
    [self.mWeightDataPicker selectRow:sRowSelected0 inComponent:0 animated:NO];
    [self.mWeightDataPicker selectRow:sRowSelected1 inComponent:1 animated:NO];
    [self refreshBtnBar];
    
}

- (void) refreshBtnBar
{
    if (self.mInitWeightComparisonNotification)
    {
        if (self.mCurWeight == self.mInitWeight)
        {
            self.mBtnBar.topItem.rightBarButtonItem.enabled = NO;
        }
        else
        {
            self.mBtnBar.topItem.rightBarButtonItem.enabled = YES;
        }
     
    }
}

#pragma mark -
#pragma mark delegate methods for UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [self.mWeightDataValueInteger count];
    }
    else if (component == 1)
    {
        return [self.mWeightDataValueDigit count];
    }
    else
    {
        return 0;
    }
}



#pragma mark -
#pragma mark delegate methods for UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [NSString stringWithFormat:@"%d", ((NSNumber*)[self.mWeightDataValueInteger objectAtIndex:row]).integerValue];
    }
    else if (component == 1)
    {
        return [NSString stringWithFormat:@"%.1f", ((NSNumber*)[self.mWeightDataValueDigit objectAtIndex:row]).floatValue];
    }
    else
    {
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    CGFloat sNewValue = -1;
    if (0 == component)
    {
        NSInteger sSelectedRowInCompoent1 = [pickerView selectedRowInComponent:1];
        sNewValue = [self getValueFromWeightPikerByRowIndex0:row aRowIndex1:sSelectedRowInCompoent1];
    }
    else if (1 == component)
    {
        NSInteger sSelectedRowInCompoent0 = [pickerView selectedRowInComponent:0];
        sNewValue = [self getValueFromWeightPikerByRowIndex0:sSelectedRowInCompoent0 aRowIndex1:row];
    }
    else
    {
        //nothing done here.
    }
    if (-1 != sNewValue)
    {
        self.mCurWeight = sNewValue;
        [self.mDelegate weightInSelectionStatus:sNewValue];
        [self refreshBtnBar];
    }
    return;
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 10;
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}


@end
