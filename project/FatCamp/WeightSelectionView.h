//
//  WeightSelectionView.h
//  FatCamp
//
//  Created by Wen Shane on 12-11-15.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WeightelectionDelegate <NSObject>

@optional
- (void) doneWithWeightSelected:(double)aWeight;
- (void) doneWithoutSelection;
- (void) weightInSelectionStatus:(double)aWeight;

@end


@interface WeightSelectionView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>
{
    id<WeightelectionDelegate> mDelegate;
}

@property (nonatomic, assign) id<WeightelectionDelegate> mDelegate;

- (id)initWithFrame:(CGRect)frame InitWeight:(double)aInitWeight;
- (id)initWithFrame:(CGRect)frame InitWeight:(double)aInitWeight Title:(NSString*)aTitle;
- (id)initWithFrame:(CGRect)frame InitWeight:(double)aInitWeight Title:(NSString*)aTitle InitWeightComparisionNotice:(BOOL)aInitWeightComparisionNotice;

- (void) resetInitWeight:(double)aInitWeight;

@end
