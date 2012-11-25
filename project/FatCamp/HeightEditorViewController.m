//
//  HeightEditorViewController.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-30.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "HeightEditorViewController.h"
#import "SharedVariables.h"
#import "StoreManager.h"
#import "GeneralValuePicker.h"
#import "WeightCaculator.h"

#define INIT_HEIGHT_IF_NOT_SET  (165.0f)

@interface HeightEditorViewController ()
{
    CGFloat mExistingHeight;
    CGFloat mCurHeight;
    UILabel* mInputBox;
}
@property (nonatomic, assign) CGFloat mExistingHeight;
@property (nonatomic, assign) CGFloat mCurHeight;
@property (nonatomic, retain) UILabel* mInputBox;
@end

@implementation HeightEditorViewController
@synthesize mExistingHeight;
@synthesize mCurHeight;
@synthesize mInputBox;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithExistingHeight:(CGFloat) aExistingHeight
{
    self = [super init];
    if (self)
    {
        UIBarButtonItem* sRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:   NSLocalizedString(@"save", nil) style: UIBarButtonItemStylePlain target:self action:@selector(saveBtnPressed)];
        self.navigationItem.rightBarButtonItem = sRightBarButtonItem;
        [sRightBarButtonItem release];

        self.mExistingHeight = aExistingHeight;
        self.mCurHeight = self.mExistingHeight;
        
    }
    return self;
}

- (void) dealloc
{
    self.mInputBox = nil;
    [super dealloc];
}
- (void) loadView
{
    CGRect sApplicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    UIView* sView = [[UIView alloc] initWithFrame:sApplicationFrame];
    sView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
    self.view = sView;
    
    [sView release];
    
    CGFloat sX = TOP_LINE_RECT.origin.x;
    CGFloat sY = TOP_LINE_RECT.origin.y;
    CGFloat sWidth = TOP_LINE_RECT.size.width;
    CGFloat sHeight = TOP_LINE_RECT.size.height;
    
    
    UILabel* sLabel = [[UILabel alloc] initWithFrame:TOP_LINE_RECT];
    sLabel.center = CGPointMake(self.view.center.x, sLabel.center.y);
    sLabel.textAlignment = UITextAlignmentCenter;
    sLabel.font = [UIFont systemFontOfSize:19];
    sLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sLabel.layer.borderWidth = 0.8;
    sLabel.layer.cornerRadius = 4.0;

    CGFloat sInitSetHeight = self.mExistingHeight;
    if (sInitSetHeight <=0 )
    {
        sInitSetHeight = INIT_HEIGHT_IF_NOT_SET;
        self.mCurHeight = sInitSetHeight;
    }
    
    sLabel.text = [NSString stringWithFormat:@"%.1f cm", sInitSetHeight];
    sLabel.backgroundColor = [UIColor clearColor];
    self.mInputBox = sLabel;
    [self.view addSubview:sLabel];
    [sLabel release];
    
    sX = 0;
    sY += sHeight+130;
    sWidth = 320;
    sHeight = sApplicationFrame.size.height-sY;

    GeneralValuePicker* sPickerView = [[GeneralValuePicker alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight) AndIntegerValueMin:[WeightCaculator getMinHeight] AndIntegerValueMax:[WeightCaculator getMaxHeight]];
    sPickerView.backgroundColor = [UIColor grayColor];
    sPickerView.mDelegate = self;
    [sPickerView setValue:sInitSetHeight];
    [self.view addSubview:sPickerView];
    [sPickerView release];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveBtnPressed
{
    if (self.mCurHeight != self.mExistingHeight)
    {
        [StoreManager addOrUpdateUserInfoHeight:self.mCurHeight];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - delegate methods for ValueChangedNotifier
- (void) valueChangedTo:(CGFloat)aNewValue
{
    self.mCurHeight = aNewValue;
    self.mInputBox.text = [NSString stringWithFormat:@"%.1f cm", self.mCurHeight];
    return;
}

@end
