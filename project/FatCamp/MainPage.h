//
//  MainPage.h
//  FatCamp
//
//  Created by Wen Shane on 12-11-13.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCycleScrollView.h"

typedef enum _ChildViewType
{
    ENUM_VIEW_TYPE_UNDEFINED,
    ENUM_VIEW_TYPE_RECENT_WEIGHT,
    ENUM_VIEW_TYPE_RECENT_ROUND
}ENUM_CHILDVIEW_TYPE;


@protocol InputViewDelegate <NSObject>

@optional
- (void) doneWithUpdates:(BOOL)aHasUpdates;

@required

@end


@interface MainPage : UIViewController<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,InputViewDelegate>

- (id) initWithTitle: (NSString*)aTitle;

@end
