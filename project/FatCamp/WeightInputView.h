//
//  WeightInputAreaView.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateSelectionView.h"
#import "WeightSelectionView.h"
#import "MainPage.h"

@interface WeightInputView : UIView<DateSelectionDelegate, WeightelectionDelegate>
{
    id<InputViewDelegate> mDelegate;
}

@property (nonatomic, assign) id<InputViewDelegate> mDelegate;
- (void) resetDateForWeightInput:(NSDate*)aDate;
@end
