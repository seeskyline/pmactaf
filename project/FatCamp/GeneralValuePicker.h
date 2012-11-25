//
//  GeneralValuePicker.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-31.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ValueChangedNotifier <NSObject>


- (void) valueChangedTo:(CGFloat)aNewValue;

@end

@interface GeneralValuePicker : UIView< UIPickerViewDataSource, UIPickerViewDelegate>
{
    id<ValueChangedNotifier> mDelegate;
}
@property (nonatomic, assign) id<ValueChangedNotifier> mDelegate;

- (id)initWithFrame:(CGRect)frame AndIntegerValueMin:(NSInteger)aIntMin AndIntegerValueMax:(NSInteger)aIntMax;
- (BOOL)setValue:(CGFloat)aNewValue;
@end
