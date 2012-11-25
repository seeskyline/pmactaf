//
//  GeneralValuePicker.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-31.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "GeneralValuePicker.h"

@interface GeneralValuePicker()
{
    
    NSMutableArray* mIntegerValue;
    NSMutableArray* mDigitValue;
    
    NSInteger mMinInt;
    NSInteger mMaxInt;
    
    UIPickerView* mPickerView;

    
}

@property (nonatomic, retain) NSMutableArray* mIntegerValue;
@property (nonatomic, retain) NSMutableArray* mDigitValue;
@property (nonatomic, assign) NSInteger mMinInt;
@property (nonatomic, assign) NSInteger mMaxInt;
@property (nonatomic, retain) UIPickerView* mPickerView;

@end

@implementation GeneralValuePicker

@synthesize mIntegerValue;
@synthesize mDigitValue;
@synthesize mMinInt;
@synthesize mMaxInt;
@synthesize mPickerView;
@synthesize mDelegate;


- (id)initWithFrame:(CGRect)frame AndIntegerValueMin:(NSInteger)aIntMin AndIntegerValueMax:(NSInteger)aIntMax
{
    if (aIntMin > aIntMax)
    {
        return nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.mMinInt = aIntMin;
        self.mMaxInt = aIntMax;
        [self preparePickerData];
        [self prepareSubviews];
    }
    return self;
}


- (void) preparePickerData
{
    if (self.mMinInt > self.mMaxInt)
    {
        return;
    }
    
    NSMutableArray* sInts = [[NSMutableArray alloc] initWithCapacity:self.mMaxInt-self.mMinInt+1];
    for (NSInteger i=self.mMinInt; i<=self.mMaxInt; i++)
    {
        [sInts addObject:[NSNumber numberWithInteger:i]];
    }
    
    NSMutableArray* sDigits = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSInteger i=0; i<=9; i++)
    {
        [sDigits addObject:[NSNumber numberWithFloat:i*0.1]];
    }
    
    self.mIntegerValue = sInts;
    [sInts release];
    
    self.mDigitValue = sDigits;
    [sDigits release];
    
    return;

}

- (void) prepareSubviews
{
    UIPickerView* sPickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
    sPickerView.dataSource = self;
    sPickerView.delegate = self;
    //            self.mWeightDataPicker.center = CGPointMake(self.mWeightInputView.bounds.size.width/2, self.mWeightDataPicker.center.y);
    sPickerView.showsSelectionIndicator = YES;

    self.mPickerView = sPickerView;
    [sPickerView release];
    
    [self addSubview:self.mPickerView];
}

- (void) dealloc
{
    self.mIntegerValue = nil;
    self.mDigitValue = nil;
    
    self.mPickerView = nil;
    
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (CGFloat) getValueFromWeightPikerByRowIndex0: (NSInteger)aRowIndex0 aRowIndex1:(NSInteger)aRowIndex1
{
    NSInteger sValueInteger = ((NSNumber*)[self.mIntegerValue objectAtIndex:aRowIndex0]).integerValue;
    CGFloat sValueDigit = ((NSNumber*)[self.mDigitValue objectAtIndex:aRowIndex1]).floatValue;
    
    return (sValueInteger+sValueDigit);
}

- (void) getFromPickerRowIndex0:(NSInteger*)aRowIndex0 RowIndex1:(NSInteger*)aRowIndex1 ByValue:(CGFloat)aValue
{
    NSInteger sValueInteger = (NSInteger)aValue;
    NSInteger sValueDigit = aValue*10-sValueInteger*10;
    
    if (sValueInteger<self.mMinInt
        || sValueInteger>self.mMaxInt)
    {
        *aRowIndex0 = -1;
    }
    else
    {
        *aRowIndex0 = sValueInteger-self.mMinInt;
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

- (BOOL)setValue:(CGFloat)aNewValue
{
    NSInteger sRowIndex0;
    NSInteger sRowIndex1;
    
    [self getFromPickerRowIndex0:&sRowIndex0 RowIndex1:&sRowIndex1 ByValue:aNewValue];
    
    if (sRowIndex0 == -1
        || sRowIndex1 == -1)
    {
        return NO;
    }
    
    [self.mPickerView selectRow:sRowIndex0 inComponent:0 animated:NO];
    [self.mPickerView selectRow:sRowIndex1 inComponent:1 animated:NO];
    
    return YES;
}

#pragma mark -
#pragma mark delegate methods for
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [self.mIntegerValue count];
    }
    else if (component == 1)
    {
        return [self.mDigitValue count];
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
        return [NSString stringWithFormat:@"%d", ((NSNumber*)[self.mIntegerValue objectAtIndex:row]).integerValue];
    }
    else if (component == 1)
    {
        return [NSString stringWithFormat:@"%.1f", ((NSNumber*)[self.mDigitValue objectAtIndex:row]).floatValue];
    }
    else
    {
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component)
    {
        NSInteger sSelectedRowInCompoent1 = [pickerView selectedRowInComponent:1];
        CGFloat sNewValue = [self getValueFromWeightPikerByRowIndex0:row aRowIndex1:sSelectedRowInCompoent1];
        [self.mDelegate valueChangedTo:sNewValue];
//        [self refreshWeightInputBoxWithValue:sNewValue aIsInitWeight:NO];
    }
    else if (1 == component)
    {
        NSInteger sSelectedRowInCompoent0 = [pickerView selectedRowInComponent:0];
        CGFloat sNewValue = [self getValueFromWeightPikerByRowIndex0:sSelectedRowInCompoent0 aRowIndex1:row];
        [self.mDelegate valueChangedTo:sNewValue];

//        [self refreshWeightInputBoxWithValue:sNewValue aIsInitWeight:NO];
        
    }
    else
    {
        //nothing done here.
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
