//
//  GuidePageTestResultViewController.m
//  FatCamp
//
//  Created by Wen Shane on 12-11-22.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "GuidePageTestResult.h"
#import "SharedVariables.h"
#import "WeightCaculator.h"
#import "SharedStates.h"
#import "UserInfo.h"
#import "StoreManager.h"
#import "MKInfoPanel.h"
#import "CMPopTipView.h"
#import "BMIReference.h"
#import "KGModal.h"
#import "CopyrightView.h"

#import <QuartzCore/QuartzCore.h>


#define TAG_CELL_LABEL1     101
#define TAG_CELL_LABEL2     102
#define TAG_CELL_LABEL3     103
#define TAG_CELL_LABEL4     104

@interface GuidePageTestResult ()
{
    UILabel* mBMILabel;
    UILabel* mStandardWeightLabel;
    UILabel* mNormalWeightRangeLabel;
    UILabel* mWeightTestResultNoticeLabel;
    UILabel* mResultLabel;
    
    BMIReference* mBMIReferenceView;

}
@property (nonatomic, retain) UILabel* mBMILabel;
@property (nonatomic, retain) UILabel* mStandardWeightLabel;
@property (nonatomic, retain) UILabel* mNormalWeightRangeLabel;

@property (nonatomic, retain) UILabel* mWeightTestResultNoticeLabel;
@property (nonatomic, retain) UILabel* mResultLabel;

@property (nonatomic, retain) BMIReference* mBMIReferenceView;
@end

@implementation GuidePageTestResult

@synthesize mBMILabel;
@synthesize mStandardWeightLabel;
@synthesize mNormalWeightRangeLabel;
@synthesize mWeightTestResultNoticeLabel;
@synthesize mResultLabel;

@synthesize mBMIReferenceView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = MAIN_BGCOLOR_TABPAGE;
        self.mBMIReferenceView = [BMIReference getInstanceWithFrame:CGRectMake(0, 0, 280, 200)];
        
        [self layoutViewsOnPage2];
        [self updateResults];

    }
    
    return self;
}
- (void) dealloc
{
    
    self.mBMILabel = nil;
    self.mStandardWeightLabel = nil;
    self.mNormalWeightRangeLabel = nil;
    self.mWeightTestResultNoticeLabel = nil;
    self.mResultLabel = nil;
    
    self.mBMIReferenceView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) layoutViewsOnPage2
{
    CGRect sFrame = [[UIScreen mainScreen] applicationFrame];
    
    CGFloat sX = 10;
    CGFloat sY = 75;
     
    UILabel* sLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX, sY-5, 20, 30)];
    sLabel.backgroundColor = [UIColor clearColor];
    sLabel.text = @"2.";
    sLabel.font = [UIFont fontWithName:@"Courier" size:25];
    sLabel.textColor = [UIColor grayColor];
    sLabel.shadowColor = [UIColor whiteColor];
    sLabel.shadowOffset = CGSizeMake(1.0, 0);
    
    [self.view addSubview:sLabel];
    [sLabel release];

    
    UIImageView* sWeightTestResultNoticeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testresult88x21.png"]];
    [sWeightTestResultNoticeImageView setFrame:CGRectMake(sX+30, sY, 88, 21)];
    [self.view addSubview:sWeightTestResultNoticeImageView];
    [sWeightTestResultNoticeImageView release];
    
    sY += 21+15;

    UILabel* sWeightTestResultNoticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX+80, sY, 200, 21)];
    sWeightTestResultNoticeLabel.backgroundColor = [UIColor clearColor];
    sWeightTestResultNoticeLabel.textColor = MAIN_BGCOLOR;
    sWeightTestResultNoticeLabel.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:sWeightTestResultNoticeLabel];
    self.mWeightTestResultNoticeLabel = sWeightTestResultNoticeLabel;
    [sWeightTestResultNoticeLabel release];
    
    sX = 10;
    sY += 21+14;
    CGFloat sWidth = sFrame.size.width-2*10;
    CGFloat sHeight = 60;
    //1.inforoutputview
    UIView* sInfoOutputView = [[[UIView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
    sInfoOutputView.backgroundColor = [UIColor clearColor];
    sInfoOutputView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sInfoOutputView.layer.borderWidth = 0.8;
    sInfoOutputView.layer.cornerRadius = 4.0;
    
    [self.view addSubview:sInfoOutputView];
    
    //sBMIHeaderControl    
    sX = 0;
    CGFloat sYOfInfoLine = 3;
    sWidth = 100;
    CGFloat sHeightOfInfoLine = 26;
    
    UIControl* sBMIHeaderControl = [[UIControl alloc] initWithFrame:CGRectMake(sX+10, sYOfInfoLine, sWidth-10, sHeightOfInfoLine)];
    [sBMIHeaderControl addTarget:self action:@selector(presentBMIReferences) forControlEvents:UIControlEventTouchDown];
    
    UILabel* sBMIHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 54, sHeightOfInfoLine)];
    sBMIHeaderLabel.text = NSLocalizedString(@"BMI", nil);
    sBMIHeaderLabel.textColor = [UIColor lightGrayColor];
    sBMIHeaderLabel.font = [UIFont systemFontOfSize:14];
    sBMIHeaderLabel.backgroundColor = [UIColor clearColor];
    sBMIHeaderLabel.textAlignment = UITextAlignmentLeft;
//    [sBMIHeaderLabel sizeToFit];
    [sBMIHeaderControl addSubview:sBMIHeaderLabel];
    [sBMIHeaderLabel release];
    UIImageView* sImageView = [[UIImageView alloc] initWithFrame:CGRectMake(sBMIHeaderLabel.frame.size.width, 0, 16, 16)];
    [sImageView setImage:[UIImage imageNamed:@"questionmark16.png"]];
    [sBMIHeaderControl addSubview:sImageView];
    [sImageView release];

    [sInfoOutputView addSubview:sBMIHeaderControl];
    [sBMIHeaderControl release];
 
    //sStandardWeightHeaderLabel
    UILabel* sStandardWeightHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX+sWidth, sYOfInfoLine, sWidth, sHeightOfInfoLine)];
    sStandardWeightHeaderLabel.text = NSLocalizedString(@"Standard Weight", nil);
    sStandardWeightHeaderLabel.textColor = [UIColor lightGrayColor];
    sStandardWeightHeaderLabel.font = [UIFont systemFontOfSize:14];
    sStandardWeightHeaderLabel.backgroundColor = [UIColor clearColor];
    sStandardWeightHeaderLabel.textAlignment = UITextAlignmentLeft;
    [sInfoOutputView addSubview:sStandardWeightHeaderLabel];
    [sStandardWeightHeaderLabel release];
    
    
    UILabel* sNormalWeightHeaderRange = [[UILabel alloc] initWithFrame:CGRectMake(sX+2*sWidth, sYOfInfoLine, sWidth, sHeightOfInfoLine)];
    sNormalWeightHeaderRange.text = NSLocalizedString(@"Normal Weight Range", nil);
    sNormalWeightHeaderRange.textColor = [UIColor lightGrayColor];
    sNormalWeightHeaderRange.font = [UIFont systemFontOfSize:14];
    sNormalWeightHeaderRange.backgroundColor = [UIColor clearColor];
    sNormalWeightHeaderRange.textAlignment = UITextAlignmentCenter;
    [sInfoOutputView addSubview:sNormalWeightHeaderRange];
    [sNormalWeightHeaderRange release];
    
    UILabel* sBMILabel = [[UILabel alloc] initWithFrame:CGRectMake(sX+15, sYOfInfoLine+sHeightOfInfoLine, sWidth-15, sHeightOfInfoLine)];
    sBMILabel.backgroundColor = [UIColor clearColor];
    sBMILabel.textAlignment = UITextAlignmentLeft;
    sBMILabel.textColor = MAIN_BGCOLOR;
    [sInfoOutputView addSubview:sBMILabel];
    self.mBMILabel = sBMILabel;
    [sBMILabel release];
    
    UILabel* sStandardWeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX+sWidth, sYOfInfoLine+sHeightOfInfoLine, sWidth, sHeightOfInfoLine)];
    sStandardWeightLabel.backgroundColor = [UIColor clearColor];
    sStandardWeightLabel.textAlignment = UITextAlignmentLeft;
    sStandardWeightLabel.textColor = MAIN_BGCOLOR;
    [sInfoOutputView addSubview:sStandardWeightLabel];
    self.mStandardWeightLabel = sStandardWeightLabel;
    [sStandardWeightLabel release];
    
    
    UILabel* sNormalWeightRangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX+2*sWidth, sYOfInfoLine+sHeightOfInfoLine, sWidth, sHeightOfInfoLine)];
    sNormalWeightRangeLabel.backgroundColor = [UIColor clearColor];
    sNormalWeightRangeLabel.textAlignment = UITextAlignmentCenter;
    sNormalWeightRangeLabel.textColor = MAIN_BGCOLOR;
    [sInfoOutputView addSubview:sNormalWeightRangeLabel];
    self.mNormalWeightRangeLabel = sNormalWeightRangeLabel;
    [sNormalWeightRangeLabel release];
    
    
    
    
    //2.result view
    sX = 10;
    sY += sHeight+10;
    sWidth = sFrame.size.width-2*10;
    sHeight = 50;
    
    UILabel* sResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    sResultLabel.center = CGPointMake(160, sResultLabel.center.y);
    sResultLabel.textAlignment = UITextAlignmentLeft;
    sResultLabel.numberOfLines = 0;
    sResultLabel.font = [UIFont systemFontOfSize:15];
    sResultLabel.textColor = [UIColor grayColor];
    sResultLabel.backgroundColor = [UIColor clearColor];
    
//    sResultLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    sResultLabel.layer.borderWidth = 0.8;
//    sResultLabel.layer.cornerRadius = 8.0;
    [self.view addSubview:sResultLabel];
    
    self.mResultLabel = sResultLabel;
    [sResultLabel release];
    
    
    
    //2.enter button
    sX = 145;
    sY += sHeight+15;
    sWidth = 64;
    sHeight = 64;
    
    UIButton* sEnterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sEnterButton setFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    sEnterButton.center = CGPointMake(self.view.bounds.size.width/2-20, sEnterButton.center.y);
    [sEnterButton setImage:[UIImage imageNamed:@"right64.png"] forState:UIControlStateNormal];
    [sEnterButton addTarget:self action:@selector(enterButtonClicked) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:sEnterButton];
    
    UILabel* sGoLabel = [[UILabel alloc] initWithFrame:CGRectMake(sEnterButton.frame.origin.x+sEnterButton.frame.size.width, sY, 20, 80)];
    sGoLabel.backgroundColor = [UIColor clearColor];
    sGoLabel.text = @"由此开始！";
    sGoLabel.font = [UIFont fontWithName:@"Courier" size:10];
    sGoLabel.textColor = [UIColor lightGrayColor];
    [sGoLabel sizeToFit];
    sGoLabel.center = CGPointMake(sGoLabel.center.x, sEnterButton.center.y-3);
    
    [self.view addSubview:sGoLabel];
    [sGoLabel release];

    
    
    //coporation
    CopyrightView* sCopyRightView = [CopyrightView getView];
    
    sCopyRightView.center = CGPointMake(self.view.center.x, self.view.bounds.size.height-sCopyRightView.bounds.size.height/2);
    [self.view addSubview:sCopyRightView];

}

- (void) updateResults
{
    //1. fetch statistics from db.
    UserInfo* sUserInfo = [StoreManager getUserInfo];

    DateWeight* sDateWeight = [StoreManager getMostRecentDateWeight];
    
    //2. compute BMI and standard weight and prepare the layout for the next page.
    double sBMI = [WeightCaculator calculateBMIByWeightKG:sDateWeight.mWeight  HeightCM:sUserInfo.mHeight];
    double sStandardWeight = [WeightCaculator getStandardWeightByHeight:sUserInfo.mHeight IsFemale:sUserInfo.mIsFemale];
    ENUM_WEIGHT_STATUS_TYPE sWeightStatus = [WeightCaculator getWeightStatusByBMI:sBMI];
    NSArray* sNormalWeightRange = [WeightCaculator getNormalWeightRange:sUserInfo.mHeight];
    double sNormalWeightRangeLow = ((NSNumber*)[sNormalWeightRange objectAtIndex:0]).doubleValue;
    double sNormalWeightRangeHeigh = ((NSNumber*)[sNormalWeightRange objectAtIndex:1]).doubleValue;
    
    //???
    self.mBMILabel.text = [NSString stringWithFormat:@"%.1f", sBMI];
    self.mStandardWeightLabel.text =[NSString stringWithFormat:@"%.1fkg", sStandardWeight];
    self.mNormalWeightRangeLabel.text =[ NSString stringWithFormat:@"%.1f~%.1fkg", sNormalWeightRangeLow, sNormalWeightRangeHeigh];
    
    NSString* sWeightNotice = nil;
    NSString* sWeightTips = nil;
    switch (sWeightStatus) {
        case ENUM_WEIGHT_STATUS_TYPE_NORAML:
        {
            sWeightNotice = NSLocalizedString(@"NormalWeightNotice", nil);
            sWeightTips = NSLocalizedString(@"NormalWeightAdvice", nil);
        }
            break;
        case ENUM_WEIGHT_STATUS_TYPE_UNDER_WEIGHT:
        {
            sWeightNotice = NSLocalizedString(@"UnderWeightNotice", nil);
            sWeightTips = NSLocalizedString(@"UnderWeightAdvice", nil);
        }
            break;
        case ENUM_WEIGHT_STATUS_TYPE_OVER_WEIGHT:
        {
            sWeightNotice = NSLocalizedString(@"OverweightNotice", nil);
            sWeightTips = NSLocalizedString(@"OverweightAdvice", nil);
        }
            break;
        case ENUM_WEIGHT_STATUS_TYPE_OBESE:
        {
            sWeightNotice = NSLocalizedString(@"ObeseNotice", nil);
            sWeightTips = NSLocalizedString(@"ObeseAdvice", nil);
        }
            break;
        default:
            break;
    }
    self.mWeightTestResultNoticeLabel.text = sWeightNotice;
    self.mResultLabel.text = sWeightTips;
    

}

- (void)enterButtonClicked
{
    UITabBarController* sTabBarController = [[SharedStates getInstance] getMainTabController];
    sTabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)])
    {
        [self presentViewController:sTabBarController animated:YES completion:nil];       
    }
    else if ([self respondsToSelector:@selector(presentModalViewController:animated:)])
    {
        [self presentModalViewController:sTabBarController animated:YES];
    }
    else
    {
        return;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) presentBMIReferences
{
    if (!self.mBMIReferenceView)
    {
        self.mBMIReferenceView = [BMIReference getInstanceWithFrame:CGRectMake(0, 0, 280, 200)];
    }
    
    KGModal* sKGModal = [KGModal sharedInstance];
    
    [sKGModal setMBackgroundColor:MAIN_BGCOLOR_TABPAGE];
    [sKGModal setMBorderWidth:1.0];
    [sKGModal setMBorderColor:MAIN_BGCOLOR];
    [sKGModal setMCornerRadius:8.0];
    
    [sKGModal showWithContentView:self.mBMIReferenceView andAnimated:YES];
    
    return;
    
}

@end
