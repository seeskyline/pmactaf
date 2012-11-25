//
//  GenderSelectionViewController.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-30.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "GenderEditorViewController.h"

#import "SharedVariables.h"
#import "StoreManager.h"


#import "SVSegmentedControl.h"


@interface GenderEditorViewController ()
{
    BOOL mExistingIsFemale;
    SVSegmentedControl* mSegmentedControl;
}

@property (nonatomic, assign) BOOL mExistingIsFemale;
@property (nonatomic, retain) SVSegmentedControl* mSegmentedControl;
@end

@implementation GenderEditorViewController
@synthesize mExistingIsFemale;
@synthesize mSegmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithExistingGenderIsFemale: (BOOL)aIsFemale
{
    self = [super init];
    if (self)
    {
        UIBarButtonItem* sRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:   NSLocalizedString(@"save", nil) style: UIBarButtonItemStylePlain target:self action:@selector(saveBtnPressed)];
        self.navigationItem.rightBarButtonItem = sRightBarButtonItem;
        [sRightBarButtonItem release];

        self.mExistingIsFemale = aIsFemale;
    }
    return self;
}

- (void) dealloc
{
    self.mSegmentedControl = nil;
    [super dealloc];
}

- (void) loadView
{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    UIView* sView = [[UIView alloc] initWithFrame:applicationFrame];
    sView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
    self.view = sView;
    [sView release];
    
    SVSegmentedControl *sSegmentedControl = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:NSLocalizedString(@"male", nil), NSLocalizedString(@"female", nil), nil]];
    [sSegmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    sSegmentedControl.frame = applicationFrame;
	sSegmentedControl.font = [UIFont boldSystemFontOfSize:19];
    sSegmentedControl.textColor = [UIColor lightGrayColor];
	sSegmentedControl.titleEdgeInsets = UIEdgeInsetsMake(30, 30, 30, 30);
	sSegmentedControl.height = 40;
    sSegmentedControl.center = CGPointMake(160, 30+20);
	sSegmentedControl.thumb.tintColor =  [UIColor grayColor];
    self.mSegmentedControl = sSegmentedControl;
    [self setIsFemale:self.mExistingIsFemale];
	[sSegmentedControl release];
    
	[self.view addSubview:self.mSegmentedControl];
    

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

- (void)segmentedControlValueChanged:(SVSegmentedControl*)segmentedControl
{
	NSLog(@"segmentedControl %i did select index %i (via UIControl method)", segmentedControl.tag, segmentedControl.selectedIndex);
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

- (void) setIsFemale:(BOOL)aIsFemale
{
    if (self.mExistingIsFemale)
    {
        self.mSegmentedControl.selectedIndex = 1;
    }
    else
    {
        self.mSegmentedControl.selectedIndex = 0;
    }
    [self.mSegmentedControl setNeedsDisplay];
}

- (void) saveBtnPressed
{
    BOOL sIsFemale = [self getCurIsFemale];
    if (sIsFemale != self.mExistingIsFemale)
    {
        [StoreManager addOrUpdateUserInfoIsFemale:sIsFemale];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
