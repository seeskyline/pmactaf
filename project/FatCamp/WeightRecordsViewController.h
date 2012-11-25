//
//  WeightRecordsViewController.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-30.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CKCalendarView.h"
#import "TapkuLibrary.h"

//1. cannot display month and weekday names in English, when prefered launage is set as English, why?
//2. topbar(on which there are left-arrow,month-year info, right-arrow) too narrow, user cannot locate arrows with buttons on navi bar easily.
@interface WeightRecordsViewController : UIViewController<TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource>

@end
