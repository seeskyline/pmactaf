//
//  IntroPageVCViewController.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-20.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "GuidePageTest.h"
#import "DateWeight.h"
#import "NSDate+MyDate.h"

#import "StoreManager.h" //test

#import "SharedStates.h"
#import "SharedVariables.h"

#import "SVSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>
#import "WeightCaculator.h"

#import "MKInfoPanel.h"

#import "GuidePageTestResult.h"
#import "StoreManager.h"

#import "CopyrightView.h"

#import "MobClick.h"

@interface GuidePageTest ()
{
    SVSegmentedControl* mSegmentedControl;
    UITextField* mHeightTextField;
    UITextField* mWeightTextField;
    UIButton* mTestButton;
    
    UILabel* mBMILabel;
    UILabel* mStandardWeightLabel;
    UILabel* mNormalWeightRangeLabel;
    UILabel* mResultLabel;
}

@property (nonatomic, retain) SVSegmentedControl* mSegmentedControl;
@property (nonatomic, retain) UIButton* mTestButton;
@property (nonatomic, retain) UITextField* mHeightTextField;
@property (nonatomic, retain) UITextField* mWeightTextField;

@property (nonatomic, retain) UILabel* mBMILabel;
@property (nonatomic, retain) UILabel* mStandardWeightLabel;
@property (nonatomic, retain) UILabel* mNormalWeightRangeLabel;

@property (nonatomic, retain) UILabel* mResultLabel;
@end

@implementation GuidePageTest

@synthesize mSegmentedControl;
@synthesize mTestButton;
@synthesize mHeightTextField;
@synthesize mWeightTextField;

@synthesize mBMILabel;
@synthesize mStandardWeightLabel;
@synthesize mNormalWeightRangeLabel;
@synthesize mResultLabel;

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
        [self layoutViewsOnPage1];
    }
    
    return self;
}

- (void) dealloc
{
    self.mSegmentedControl = nil;
    
    self.mHeightTextField = nil;
    self.mWeightTextField = nil;
    self.mTestButton = nil;
    
    self.mBMILabel = nil;
    self.mStandardWeightLabel = nil;
    self.mNormalWeightRangeLabel = nil;
    self.mResultLabel = nil;
    [super dealloc];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];

}

- (void) layoutViewsOnPage1
{
    CGRect sFrame = [[UIScreen mainScreen] applicationFrame];

    CGFloat sX = 40;
    CGFloat sY = 75;
    CGFloat sWidth = sFrame.size.width-2*sX;

    
    UILabel* sLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX-30, sY-5, 20, 30)];
    sLabel.backgroundColor = [UIColor clearColor];
    sLabel.text = @"1.";
    sLabel.font = [UIFont fontWithName:@"Courier" size:25];
    sLabel.textColor = [UIColor grayColor];
    sLabel.shadowColor = [UIColor whiteColor];
    sLabel.shadowOffset = CGSizeMake(1.0, 0);

    [self.view addSubview:sLabel];
    [sLabel release];
    
    UIImageView* sWeightTestNoticeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weighttest132x20.png"]];
    [sWeightTestNoticeImageView setFrame:CGRectMake(sX, sY, 132, 20)];
    [self.view addSubview:sWeightTestNoticeImageView];
    [sWeightTestNoticeImageView release];

    sX = 30;
    sY += 20+15;
    CGFloat sHeight = 175;
    UIView* sInfoInputView = [[[UIView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight)] autorelease];
//    sInfoInputView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    sInfoInputView.layer.borderWidth = 0.8;
//    sInfoInputView.layer.cornerRadius = 4.0;

    [self.view addSubview:sInfoInputView];

    sX = 10;
    sY = 0;
    sWidth = 50;
    CGFloat sHeightInfoLine = 35;
    CGFloat sVerticalPadding = 5;

    UILabel* sGenderHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeightInfoLine)];
    UILabel* sHeightHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX, sY+sHeightInfoLine+sVerticalPadding, sWidth, sHeightInfoLine)];
    UILabel* sWeightHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX, sY+2*(sHeightInfoLine+sVerticalPadding), sWidth, sHeightInfoLine)];
    sGenderHeaderLabel.backgroundColor = [UIColor clearColor];
    sHeightHeaderLabel.backgroundColor = [UIColor clearColor];
    sWeightHeaderLabel.backgroundColor = [UIColor clearColor];
    sGenderHeaderLabel.textColor = [UIColor lightGrayColor];
    sHeightHeaderLabel.textColor = [UIColor lightGrayColor];
    sWeightHeaderLabel.textColor = [UIColor lightGrayColor];
    
    
    sGenderHeaderLabel.text = NSLocalizedString(@"gender", nil);
    sHeightHeaderLabel.text = NSLocalizedString(@"height", nil);
    sWeightHeaderLabel.text = NSLocalizedString(@"weight", nil);
    
    [sInfoInputView addSubview:sGenderHeaderLabel];
    [sGenderHeaderLabel release];
    [sInfoInputView addSubview:sHeightHeaderLabel];
    [sHeightHeaderLabel release];
    [sInfoInputView addSubview:sWeightHeaderLabel];
    [sWeightHeaderLabel release];
    
    sX += sWidth+5;
    sWidth = 150;
    
    SVSegmentedControl *sSegmentedControl = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:NSLocalizedString(@"male", nil), NSLocalizedString(@"female", nil), nil]];
    //    [sSegmentedControl addTarget:self action:@selector(sexSegmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
	sSegmentedControl.font = [UIFont boldSystemFontOfSize:19];
	sSegmentedControl.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 25);
    sSegmentedControl.center = CGPointMake(sX+sWidth/2, sY+sHeightInfoLine/2);
	sSegmentedControl.height = sHeightInfoLine;
	sSegmentedControl.thumb.tintColor = MAIN_BGCOLOR;
    sSegmentedControl.backgroundColor = [UIColor whiteColor];
    sSegmentedControl.selectedIndex = 1;
	[sInfoInputView addSubview:sSegmentedControl];
    
    self.mSegmentedControl = sSegmentedControl;
    [sSegmentedControl release];
    
    
    UITextField* sHeightTextField = [[UITextField alloc] initWithFrame:CGRectMake(sX, sY+sHeightInfoLine+sVerticalPadding, sWidth, sHeightInfoLine)];
    sHeightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    sHeightTextField.backgroundColor = [UIColor clearColor];
    sHeightTextField.borderStyle = UITextBorderStyleRoundedRect;
	sHeightTextField.font = [UIFont systemFontOfSize:19];
    sHeightTextField.textColor = MAIN_BGCOLOR;
    sHeightTextField.delegate = self;
    sHeightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    sHeightTextField.layer.cornerRadius = 4.0;
    //    [sHeightTextField becomeFirstResponder];
    [sInfoInputView addSubview:sHeightTextField];
    self.mHeightTextField = sHeightTextField;
    [sHeightTextField release];
    
    UILabel* sCMLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX+sWidth+2, sY+sHeightInfoLine+sVerticalPadding, 40, sHeightInfoLine)];
    sCMLabel.textColor = [UIColor lightGrayColor];
    sCMLabel.backgroundColor = [UIColor clearColor];
    sCMLabel.text = @"cm";
    [sInfoInputView addSubview:sCMLabel];
    [sCMLabel release];
    
    UITextField* sWeightTextField = [[UITextField alloc] initWithFrame:CGRectMake(sX, sY+2*(sHeightInfoLine+sVerticalPadding), sWidth, sHeightInfoLine)];
    sWeightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    sWeightTextField.backgroundColor = [UIColor clearColor];
    sWeightTextField.borderStyle = UITextBorderStyleRoundedRect;
	sWeightTextField.font = [UIFont systemFontOfSize:19];
    sWeightTextField.textColor = MAIN_BGCOLOR;
    sWeightTextField.delegate = self;
    sWeightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    sWeightTextField.layer.cornerRadius = 4.0;
    //    [sWeightTextField becomeFirstResponder];
    [sInfoInputView addSubview:sWeightTextField];
    
    self.mWeightTextField = sWeightTextField;
    [sWeightTextField release];
    
    UILabel* sKGLabel = [[UILabel alloc] initWithFrame:CGRectMake(sX+sWidth+2, sY+2*(sHeightInfoLine+sVerticalPadding), 40, sHeightInfoLine)];
    sKGLabel.textColor = [UIColor lightGrayColor];
    sKGLabel.backgroundColor = [UIColor clearColor];
    sKGLabel.text = @"kg";
    [sInfoInputView addSubview:sKGLabel];
    [sKGLabel release];
    
    
    
    sX += 25;
    sY += 3*(sHeightInfoLine+sVerticalPadding)+5;
    sWidth -= 2*25;
    sHeight = 44;
    
    UIButton* sTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sTestButton setFrame:CGRectMake(sX, sY, sWidth, sHeight)];
    [sTestButton setTitle:NSLocalizedString(@"Start Testing", nil) forState:UIControlStateNormal];
    //    [sTestButton setTintColor:MAIN_BGCOLOR];
    
    [[sTestButton layer] setCornerRadius:8.0f];
    [[sTestButton layer] setMasksToBounds:YES];
    [[sTestButton layer] setBorderWidth:0.7f];
    [[sTestButton layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [[sTestButton layer] setBackgroundColor:[MAIN_BGCOLOR CGColor]];
    [sTestButton addTarget:self action:@selector(startTesting) forControlEvents:UIControlEventTouchDown];
    self.mTestButton = sTestButton;
    [sInfoInputView addSubview:sTestButton];
    
    
    //coporation
    CopyrightView* sCopyRightView = [CopyrightView getView];
    
    sCopyRightView.center = CGPointMake(self.view.center.x, self.view.bounds.size.height-sCopyRightView.bounds.size.height/2);
    [self.view addSubview:sCopyRightView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *sTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [sTapGestureRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:sTapGestureRecognizer];
    [sTapGestureRecognizer release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) sexSegmentedControlChanged:(SVSegmentedControl*)segmentedControl
{
    
}

- (void) startTesting
{

    
    BOOL sIsFemale;
    double sHeight;
    double sWeight;
    
    sIsFemale = [self getCurIsFemale];
    sHeight = [self.mHeightTextField.text doubleValue];
    sWeight = [self.mWeightTextField.text doubleValue];
    
    
    //
    NSString* sGenderStr = nil;
    NSString* sHeightStr = nil;
    NSString* sWeightStr = nil;
    
    if (sIsFemale)
    {
        sGenderStr = @"F";
    }
    else
    {
        sGenderStr = @"M";
    }
    sHeightStr = [NSString stringWithFormat:@"%.1f", sHeight];
    sWeightStr = [NSString stringWithFormat:@"%.1f", sWeight];
    
    NSDictionary* sDict = [NSDictionary dictionaryWithObjectsAndKeys:
                           sGenderStr, @"Gender", sHeightStr, @"Height", sWeightStr, @"Weight", nil];
    [MobClick event:@"UEID_START_TEST" attributes: sDict];

    //
    
    BOOL isHeightValid = [WeightCaculator isHeightValid:sHeight];
    BOOL isWeightValid = [WeightCaculator isWeightValid:sWeight];

    //verify the input
    if (!isHeightValid
        || !isWeightValid)
    {
        NSString* sNoticeText = nil;
        if (!isHeightValid
            && !isWeightValid)
        {
            sNoticeText = NSLocalizedString(@"The value of height and weight are invalid", nil);
        }
        else if (!isHeightValid)
        {
            sNoticeText = NSLocalizedString(@"The value of height are invalid", nil);     
        }
        else
        {
            sNoticeText = NSLocalizedString(@"The value of weight are invalid", nil);         
        }
        [MKInfoPanel showPanelInViewNoOverlapping:self.view type:MKInfoPanelTypeInfo title:sNoticeText subtitle:nil hideAfter:3];
        
    }
    else
    {
        //1.store
        [StoreManager addOrUpdateWeight:sWeight aDate:[NSDate date]];
        [StoreManager addOrUpdateUserInfoWithMail:@"" aName:@"" aIsFemale:sIsFemale aAge:0 aHeight:sHeight aWeight:sWeight];
        
        //2.move to test result page
        GuidePageTestResult* sGuidePageTestResultViewController = [[GuidePageTestResult alloc] init];
        [self.navigationController pushViewController:sGuidePageTestResultViewController animated:YES];
        [sGuidePageTestResultViewController release];
        
        return;

    }
    
}


-(void)dismissKeyboard
{
    [self.mHeightTextField resignFirstResponder];
    [self.mWeightTextField resignFirstResponder];
    
//    [self.view removeGestureRecognizer:self.tap]
}

- (BOOL) getCurIsFemale
{
    NSInteger sSelectedIndex = self.mSegmentedControl.selectedIndex;
    switch (sSelectedIndex) {
        case 0:
            return NO;
            break;
        case 1:
            return YES;
        default:
            return YES;
            break;
    }
}


#pragma mark - methods from UITextFieldDelegate protocol
- (void)textFieldDidEndEditing:(UITextField *)textField
{
     [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

//-(void)textFieldDidBeginEditing:(UITextField *)sender
//{
//    if ([sender isEqual:mailTf])
//    {
//        //move the main view, so that the keyboard does not hide it.
//        if  (self.view.frame.origin.y >= 0)
//        {
//            [self setViewMovedUp:YES];
//        }
//    }
//}


#define kOFFSET_FOR_KEYBOARD 65.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];         
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


@end
