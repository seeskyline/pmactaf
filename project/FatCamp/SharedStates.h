//
//  SharedStates.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-8.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedStates : NSObject<UITabBarControllerDelegate, UINavigationControllerDelegate>
{
    UIWindow *window;
    UIImageView* tabBarArrow;
}

@property (nonatomic, retain) UIWindow* window;
@property (nonatomic, retain) UIImageView* tabBarArrow;

+ (SharedStates*)getInstance;
- (UITabBarController*) getMainTabController;
- (void) addTabViewControllerForWindow:(UIWindow*)aWindow;
+ (void) checkUpdateAutomatically;

+ (BOOL) isCurLanguageChinese;
@end
