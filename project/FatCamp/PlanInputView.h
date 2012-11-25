//
//  PlanSettingView.h
//  FatCamp
//
//  Created by Wen Shane on 12-11-14.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPage.h"
#import "DateSelectionView.h"
#import "WeightSelectionView.h"

@interface PlanInputView : UIView<UITableViewDataSource, UITableViewDelegate, DateSelectionDelegate, WeightelectionDelegate>
{
    id<InputViewDelegate> mDelegate;
}

@property (nonatomic, assign)  id<InputViewDelegate> mDelegate;
- (void) updateInitialStatus;
@end
