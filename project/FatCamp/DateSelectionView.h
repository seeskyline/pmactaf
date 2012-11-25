//
//  DatePickerView.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-28.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateSelectionDelegate <NSObject>

@optional
- (void) doneWithDate:(NSDate*)aDateSelected aIsDiffFromInitDate:(BOOL)aDateIsNew;

@end

@interface DateSelectionView : UIView
{
    id<DateSelectionDelegate> mDelegate;
}


@property (nonatomic, assign) id<DateSelectionDelegate> mDelegate;

- (id)initWithFrame:(CGRect)frame InitDate:(NSDate*)aInitDate MinDate:(NSDate*)aMinDate MaxDate:(NSDate*)aMaxDate;
- (void) resetInitDate:(NSDate*)aInitDate;
@end
