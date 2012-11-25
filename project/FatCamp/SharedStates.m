//
//  SharedStates.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-8.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "SharedStates.h"
#import "MainPageVC.h"
#import "MainPage.h"
#import "TipsVC.h"
#import "MyProfile.h"
#import "SharedVariables.h"

#import "MobClick.h"


static SharedStates* singleton = nil;
static UITabBarController* MTabBarController = nil;


@implementation SharedStates

@synthesize tabBarArrow;
@synthesize window;

+(SharedStates*)getInstance
{
    @synchronized([SharedStates class]){
        if(singleton ==nil){
            singleton = [[self alloc]init];
        }
    }
    return singleton;
}


- (UITabBarController*) getMainTabController
{
    if (nil == MTabBarController)
    {
        MTabBarController = [[[UITabBarController alloc] init] autorelease];
        
        NSString* sTitle = nil;
        UITabBarItem* sTabBarItem = nil;
        
        
        // mainpage vc
        
        sTitle = NSLocalizedString(@"MainPage", "new message type of which may be dictations");
        UINavigationController* sNavOfMainPageVC = [[UINavigationController alloc] initWithRootViewController:[[[MainPage alloc]initWithTitle:sTitle] autorelease]];
//        MainPageVC* sNavOfMainPageVC = [[MainPageVC alloc] initWithTitle:sTitle];
        sTabBarItem = [[UITabBarItem alloc]initWithTitle:sTitle image:nil tag:0];
        //        sTabBarItem.badgeValue = @"N";
        sTabBarItem.image = [UIImage imageNamed:@"home30.png"];
        sNavOfMainPageVC.tabBarItem = sTabBarItem;
        [sTabBarItem release];
        
        //library vc
        sTitle = NSLocalizedString(@"Tips", "Library where user get whatever he/she wants on sex");
        UINavigationController* sNavOfTipsVC =  [[UINavigationController alloc] initWithRootViewController:[[[TipsVC alloc]initWithTitle:sTitle] autorelease]];
//        TipsVC* sNavOfTipsVC = [[TipsVC alloc]initWithTitle:sTitle];
        sNavOfTipsVC.delegate = self;
        sTabBarItem = [[UITabBarItem alloc]initWithTitle:sTitle image:nil tag:0];
        sTabBarItem.image = [UIImage imageNamed:@"tips30.png"];
        sNavOfTipsVC.tabBarItem = sTabBarItem;
        
        [sTabBarItem release];
        
        //setting vc
        sTitle = NSLocalizedString(@"Me", nil);
        UINavigationController* sNavOfSettingVC =  [[UINavigationController alloc] initWithRootViewController:[[[MyProfile alloc]initWithTitle:sTitle] autorelease]];
        sNavOfSettingVC.delegate = self;
//        MeVC* sNavOfSettingVC = [[MeVC alloc]initWithTitle:sTitle];
        sTabBarItem = [[UITabBarItem alloc]initWithTitle:sTitle image:nil tag:0];
        sTabBarItem.image = [UIImage imageNamed:@"profile30.png"];
        
        sNavOfSettingVC.tabBarItem = sTabBarItem;
        [sTabBarItem release];
        
        
        NSArray* sControllers;
        sControllers = [NSArray arrayWithObjects:sNavOfMainPageVC, sNavOfTipsVC,sNavOfSettingVC, nil];
        
        MTabBarController.viewControllers = sControllers;
        MTabBarController.selectedIndex = 0;
        MTabBarController.delegate = self;
        
       [self configApperance:MTabBarController];
        
        
        [sNavOfMainPageVC release];
        [sNavOfTipsVC release];
        [sNavOfSettingVC release];
    }
    return MTabBarController;
}

- (void) configApperance: (UITabBarController*)aTabBarController
{
    for (UINavigationController* sChildViewController in aTabBarController.viewControllers)
    {
        if ([sChildViewController respondsToSelector:@selector(navigationBar)]
            && [sChildViewController.navigationBar respondsToSelector:@selector(setTintColor:)])
        {
            sChildViewController.navigationBar.tintColor = MAIN_BGCOLOR;
        }
    }
    
    if ([aTabBarController.tabBar respondsToSelector:@selector(setTintColor:)])
    {
        aTabBarController.tabBar.tintColor =  MAIN_BGCOLOR_SHALLOW;
    }
    else
    {
        //it does not work on ios5, why?
        CGRect sFrame = CGRectMake(0, 0, aTabBarController.tabBar.bounds.size.width,  aTabBarController.tabBar.bounds.size.height);
        UIView *sBGView = [[UIView alloc] initWithFrame:sFrame];
        sBGView.backgroundColor = MAIN_BGCOLOR_SHALLOW;
        [aTabBarController.tabBar insertSubview:sBGView atIndex:0];
        [sBGView release];
    }
    
    [self addTabBarArrow];
    
}


- (void) addTabViewControllerForWindow:(UIWindow*)aWindow
{
    self.window = aWindow;
//    [[SharedStates getInstance]getMainTabController].delegate = self;
    self.window.rootViewController = [[SharedStates getInstance] getMainTabController];
//    [self addTabBarArrow];
}

- (void) addTabBarArrow
{
    UIImage* tabBarArrowImage = [UIImage imageNamed:@"TabBarNipple.png"];
    self.tabBarArrow = [[[UIImageView alloc] initWithImage:tabBarArrowImage] autorelease];
    // To get the vertical location we start at the bottom of the window, go up by height of the tab bar, go up again by the height of arrow and then come back down 2 pixels so the arrow is slightly on top of the tab bar.
//    CGFloat verticalLocation = self.window.frame.size.height - [[SharedStates getInstance]getMainTabController].tabBar.frame.size.height - tabBarArrowImage.size.height + 2;
    
    CGFloat verticalLocation =[[UIScreen mainScreen] bounds].size.height - [[SharedStates getInstance]getMainTabController].tabBar.frame.size.height - tabBarArrowImage.size.height + 2;

    tabBarArrow.frame = CGRectMake([self horizontalLocationFor:0], verticalLocation, tabBarArrowImage.size.width, tabBarArrowImage.size.height);
    
    [[[SharedStates getInstance]getMainTabController].view addSubview:tabBarArrow];
}

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    // A single tab item's width is the entire width of the tab bar divided by number of items
    CGFloat tabItemWidth = [[SharedStates getInstance]getMainTabController].tabBar.frame.size.width / [[SharedStates getInstance]getMainTabController].tabBar.items.count;
    // A half width is tabItemWidth divided by 2 minus half the width of the arrow
    CGFloat halfTabItemWidth = (tabItemWidth / 2.0) - (tabBarArrow.frame.size.width / 2.0);
    
    // The horizontal location is the index times the width plus a half width
    return (tabIndex * tabItemWidth) + halfTabItemWidth;
}

- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController
{
    [self.window bringSubviewToFront:self.tabBarArrow];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame = tabBarArrow.frame;
    frame.origin.x = [self horizontalLocationFor:[[SharedStates getInstance]getMainTabController].selectedIndex];
    tabBarArrow.frame = frame;
    [UIView commitAnimations];  
    
}


#pragma mark -
#pragma mark delegate methods for UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController* sViewController = (UIViewController*)[navigationController.viewControllers objectAtIndex:0];

    if (viewController != sViewController)
    {
        self.tabBarArrow.hidden = YES;
    }

    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController* sViewController = (UIViewController*)[navigationController.viewControllers objectAtIndex:0];
    if (viewController == sViewController)
    {
        self.tabBarArrow.hidden = NO;
    }
}


+ (void) checkUpdateAutomatically
{
    [MobClick checkUpdate:NSLocalizedString(@"New Version Found", nil) cancelButtonTitle:NSLocalizedString(@"Skip", nil) otherButtonTitles:NSLocalizedString(@"Update now", nil)];
}

+ (BOOL) isCurLanguageChinese
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage isEqualToString:@"zh-Hans"]
        || [currentLanguage isEqualToString:@"zh-Hant"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
