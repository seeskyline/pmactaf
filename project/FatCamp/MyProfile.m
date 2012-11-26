//
//  SettingVC.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-8.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "MyProfile.h"
#import "SharedVariables.h"
#import "SharedStates.h"
#import "StoreManager.h"
#import "NSDate+MyDate.h"
#import "NSDateFormatter+MyDateFormatter.h"

#import "NameEditorViewController.h"
#import "GenderEditorViewController.h"
#import "HeightEditorViewController.h"
#import "WeightRecordsViewController.h"
#import "AboutViewController.h"

#import "UserInfo.h"
#import "CustomCellBackgroundView.h"
#import "WeightCaculator.h"
#import "KGModal.h"

#import "BMIReference.h"

#define NUM_OF_SECTIONS 2
#define TAG_FOR_DATE4WEIGHT_LABEL 1000

@interface MyProfile ()
{
    UserInfo* mUserInfo;
    BMIReference* mBMIReferenceView;
}
@property (nonatomic, retain) UserInfo* mUserInfo;
@property (nonatomic, retain) BMIReference* mBMIReferenceView;

@end

@implementation MyProfile

@synthesize mUserInfo;
@synthesize mBMIReferenceView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithTitle: (NSString*)aTitle
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.title = aTitle;
        self.view.backgroundColor = MAIN_BGCOLOR_TABPAGE;
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        [self loadUserInfo];
        self.mBMIReferenceView = [BMIReference getInstanceWithFrame:CGRectMake(0, 0, 280, 200)];
    }
    
    return self;
}

- (void) loadUserInfo
{
    self.mUserInfo = [StoreManager getUserInfo]; 
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

- (void) dealloc
{
    self.mUserInfo = nil;
    self.mBMIReferenceView = nil;
    
    [super dealloc];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadUserInfo];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark tableview's datasource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NUM_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 6;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sSection = [indexPath section];
    NSInteger sRow = [indexPath row];
  
    UITableViewCell* sCell = [tableView dequeueReusableCellWithIdentifier:@"common"];
    if (!sCell)
    {
        sCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"common"] autorelease];
        
        CustomCellBackgroundView* sBGView = [CustomCellBackgroundView backgroundCellViewWithFrame:sCell.frame Row:[indexPath row] totalRow:[tableView numberOfRowsInSection:[indexPath section]] borderColor:SELECTED_CELL_COLOR fillColor:SELECTED_CELL_COLOR tableViewStyle:tableView.style];
        sCell.selectedBackgroundView = sBGView;

        
        UILabel* sDate4WeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(48, 10, 100, self.tableView.rowHeight-20)];
        sDate4WeightLabel.backgroundColor = [UIColor clearColor];
        sDate4WeightLabel.textColor = [UIColor lightGrayColor];
        sDate4WeightLabel.font = [UIFont systemFontOfSize:15];
        sDate4WeightLabel.tag = TAG_FOR_DATE4WEIGHT_LABEL;
        [sCell.contentView addSubview:sDate4WeightLabel];
        [sDate4WeightLabel release];
        
    }
    else
    {
        UILabel* sDate4WeightLabel = (UILabel*)[sCell viewWithTag:TAG_FOR_DATE4WEIGHT_LABEL];
        if (sDate4WeightLabel)
        {
            sDate4WeightLabel.text = nil;
        }

    }

    switch (sSection) {
        case 0:
            {
               
                
                switch (sRow) {
                    case 0:
                    {
                        sCell.textLabel.text = NSLocalizedString(@"name", nil);
                        if (self.mUserInfo.mName.length >0)
                        {
                            sCell.detailTextLabel.text =self.mUserInfo.mName;            
                        }
                        else
                        {
                            sCell.detailTextLabel.text = NSLocalizedString(@"no name yet", nil);
                        }
                        sCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                    }
                        break;
                    case 1:
                    {
                        sCell.textLabel.text = NSLocalizedString(@"gender", nil);
                        if (self.mUserInfo.mIsFemale)
                        {
                            sCell.detailTextLabel.text = NSLocalizedString(@"female", nil);
                        }
                        else
                        {
                            sCell.detailTextLabel.text = NSLocalizedString(@"male", nil);
                        }
                        sCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                        break;
                    case 2:
                    {
                        sCell.textLabel.text = NSLocalizedString(@"height", nil);
                        if (self.mUserInfo.mHeight>0)
                        {
                            sCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", self.mUserInfo.mHeight];
                        }
                        else
                        {
                            sCell.detailTextLabel.text = NSLocalizedString(@"no record(s) yet", nil);
                        }
                        sCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                        break;
                    case 3:
                    {
                        sCell.textLabel.text = NSLocalizedString(@"weight", nil);
                        
                        if (self.mUserInfo.mNewDateWeight
                            && self.mUserInfo.mNewDateWeight.mWeight>0)
                        {
                            UILabel* sDate4WeightLabel = (UILabel*)[sCell viewWithTag:TAG_FOR_DATE4WEIGHT_LABEL];
                            if (sDate4WeightLabel)
                            {
                                NSDateFormatter* sDateFormatter = [[NSDateFormatter alloc] init];
                                sDate4WeightLabel.text = [sDateFormatter standardYMDFormatedStringLeadigZero:self.mUserInfo.mNewDateWeight.mDate];
                                [sDateFormatter release];
                            }
                            sCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f kg", self.mUserInfo.mNewDateWeight.mWeight];
                        }
                        else
                        {
                            sCell.detailTextLabel.text = NSLocalizedString(@"no record(s) yet", nil);
                        }
                        sCell.accessoryType = UITableViewCellAccessoryNone;

                        
                    }
                        break;
                    case 4:
                    {
                        sCell.textLabel.text = NSLocalizedString(@"BMI", nil);
                        if (self.mUserInfo.mHeight > 0
                            && self.mUserInfo.mNewDateWeight && self.mUserInfo.mNewDateWeight.mWeight > 0)
                        {
                            double sBMI = [WeightCaculator calculateBMIByWeightKG:self.mUserInfo.mNewDateWeight.mWeight HeightCM:self.mUserInfo.mHeight];
                            sCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f", sBMI];
                        }
                        else
                        {
                            sCell.detailTextLabel.text = NSLocalizedString(@"no record(s) yet", nil);
                        }
                        sCell.accessoryType = UITableViewCellAccessoryNone;
                        
                    }
                        break;
                    case 5:
                    {
                        sCell.textLabel.text = NSLocalizedString(@"weight log", nil);
                        sCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                        break;
                        
                    default:
                        break;
                }
                
                return sCell;
            }
            break;
        case 1:
            {
                switch (sRow)
                {
                    case 0:
                        sCell.textLabel.text = NSLocalizedString(@"about", nil);
                        sCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;

                        
                    default:
                        break;
                }
                
                return sCell;
            }
            break;

        default:
            return nil;
            break;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sSection = [indexPath section];
    NSInteger sRow = [indexPath row];

    
    switch (sSection) {
        case 0:
        {
            switch (sRow) {
                case 0:
                    [self changeName];
                    break;
                case 1:
                    [self changeGender];
                    break;
                case 2:
                    [self changeHeight];
                    break;
                case 4:
                {                    
                    [self presentBMIReferences];
                }
                    break;
                case 5:
                    [self enterWeightRecords];
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            if (0 == sRow)
            {
                [self presentAbout];
            }
 
        }
            break;
        default:
            break;
    }
}

- (void) changeName
{
    [self mofifyBackBarButtonOnPushedController];
    
    NameEditorViewController* sNameEditorViewController = [[NameEditorViewController alloc] initWithExistingName: self.mUserInfo.mName];
    sNameEditorViewController.hidesBottomBarWhenPushed = YES;
    sNameEditorViewController.title = NSLocalizedString(@"change nickname", nil);
    
    [self.navigationController pushViewController:sNameEditorViewController animated:YES];
    
    
    [sNameEditorViewController release];
}

- (void) changeGender
{
    [self mofifyBackBarButtonOnPushedController];
    
    GenderEditorViewController* sGenderSelectionViewController = [[GenderEditorViewController alloc] initWithExistingGenderIsFemale: self.mUserInfo.mIsFemale];
    sGenderSelectionViewController.hidesBottomBarWhenPushed = YES;
    sGenderSelectionViewController.title = NSLocalizedString(@"change gender", nil);
    
    [self.navigationController pushViewController:sGenderSelectionViewController animated:YES];
    
    
    [sGenderSelectionViewController release];
}

- (void) changeHeight
{
    [self mofifyBackBarButtonOnPushedController];

    HeightEditorViewController* sHeightEditorViewController = [[HeightEditorViewController alloc] initWithExistingHeight: self.mUserInfo.mHeight];
    sHeightEditorViewController.hidesBottomBarWhenPushed = YES;
    sHeightEditorViewController.title = NSLocalizedString(@"change height", nil);
    
    [self.navigationController pushViewController:sHeightEditorViewController animated:YES];
    
    
    [sHeightEditorViewController release];
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

- (void) enterWeightRecords
{
    [self restoreBackBarButtonOnPushedController];
    WeightRecordsViewController* sWeightRecordsViewController = [[WeightRecordsViewController alloc] init];
    sWeightRecordsViewController.hidesBottomBarWhenPushed = YES;
    sWeightRecordsViewController.title = NSLocalizedString(@"weight records", nil);
    
    [self.navigationController pushViewController:sWeightRecordsViewController animated:YES];
    
    
    [sWeightRecordsViewController release];

    
}


- (void) presentAbout
{
    [self restoreBackBarButtonOnPushedController];
    
    AboutViewController* sAboutViewController = [[AboutViewController alloc] init];
    
    sAboutViewController.navigationItem.title = NSLocalizedString(@"About", nil);
    sAboutViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:sAboutViewController animated:YES];
    
    
    [sAboutViewController release];
    return;
}


- (void) mofifyBackBarButtonOnPushedController
{
    UIBarButtonItem* sBackBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
    self.navigationItem.backBarButtonItem = sBackBarButtonItem;
    [sBackBarButtonItem release];
}

- (void) restoreBackBarButtonOnPushedController
{
    UIBarButtonItem* sBackBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.title style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
    self.navigationItem.backBarButtonItem = sBackBarButtonItem;
    [sBackBarButtonItem release];
}


//- (double) calculateBMIWithWeightKG:(double)aWeightKG andHeightCM:(double)aHeightCM
//{
//    double aHeightM = aHeightCM/100.0;
//    double sBMI = aWeightKG/(aHeightM*aHeightM);
//    
//    return sBMI;
//}

@end
