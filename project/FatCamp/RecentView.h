//
//  RecentView.h
//  FatCamp
//
//  Created by Wen Shane on 12-11-13.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPage.h"
#import "CoreData.h"

@interface RecentView : UIView
{
    CoreData* mCoreData;
    ENUM_CHILDVIEW_TYPE mType;
}

@property (nonatomic, assign) CoreData* mCoreData;
@property (nonatomic, assign) ENUM_CHILDVIEW_TYPE mType;

- (void) update;
@end
