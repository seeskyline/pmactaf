//
//  WeightRecordsViewController.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-30.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "WeightRecordsViewController.h"
#import "SharedVariables.h"

#import "StoreManager.h"

#import "NSDate+MyDate.h"
#import "SharedStates.h"

@interface WeightRecordsViewController ()
{
    BOOL mSundayFirst;
    TKCalendarMonthView* mMonthView;
}

@property (nonatomic, assign) BOOL mSundayFirst;
@property (nonatomic, retain) TKCalendarMonthView* mMonthView;

@end

@implementation WeightRecordsViewController

@synthesize mSundayFirst;
@synthesize mMonthView;


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
    if ([SharedStates isCurLanguageChinese])
    {
        return [self initWithSunday:NO];
    }
    else
    {
        return [self initWithSunday:YES];
    }
}

- (id) initWithSunday:(BOOL)aSundayFirst
{
    self = [super init];
    if (self)
    {
        self.mSundayFirst = aSundayFirst;
        UIBarButtonItem* sRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:   NSLocalizedString(@"today", nil) style: UIBarButtonItemStylePlain target:self action:@selector(todayBtnPressed)];
        self.navigationItem.rightBarButtonItem = sRightBarButtonItem;
        [sRightBarButtonItem release];

    }
	return self;
}



- (void) loadView{
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    UIView* sView = [[UIView alloc] initWithFrame:applicationFrame];
    sView.backgroundColor = [UIColor whiteColor];
    self.view = sView;
    [sView release];
        
	TKCalendarMonthView* sMonthView = [[TKCalendarMonthView alloc] initWithSundayAsFirst:self.mSundayFirst];
	sMonthView.delegate = self;
	sMonthView.dataSource = self;
    sMonthView.backgroundColor = [UIColor whiteColor];
//    sMonthView.frame = CGRectMake(0, 10, 320, applicationFrame.size.height-10);
    
    self.mMonthView = sMonthView;
    [sMonthView release];
    
    
	[self.view addSubview:self.mMonthView];
	[self.mMonthView reload];
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewDidUnload {
	self.mMonthView = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    self.mMonthView = nil;
    [super dealloc];
}

- (void) todayBtnPressed
{
    [self.mMonthView selectDate:[NSDate date]];
}

#pragma mark - delegate methods for TKCalendarMonthViewDelegate.


#pragma mark - delegate methods for TKCalendarMonthViewDataSource.
- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate
{
    NSInteger sDays = [lastDate ceilingDaysSinceStartingOfDate:startDate];
    
    
    NSMutableArray* sWeights = [StoreManager getWeightsFromStartDateSelfIncluded:startDate aEndDateSelfIncluded:lastDate aFirstWeight:nil aOutMaxWeight:nil aOutMinWeight:nil];
    
    NSMutableArray* sMarks = [NSMutableArray arrayWithCapacity:sDays];
    NSDate* sDate = startDate;
    NSInteger sIndexOfWeights=0;
    for (NSInteger i=1; i<=sDays; i++)
    {
        if (sIndexOfWeights >= sWeights.count)
        {
            [sMarks addObject:[NSString string]];
        }
        else
        {
            DateWeight* sDateWeight = (DateWeight*)[sWeights objectAtIndex:sIndexOfWeights];
            if ([sDateWeight.mDate isSameDayWith:sDate])
            {
                [sMarks addObject:[NSString stringWithFormat:@"%.1f", sDateWeight.mWeight]];
                sIndexOfWeights++;
            }
            else
            {
                [sMarks addObject:[NSString string]];
            }
        }
        sDate = [sDate dateByAddingTimeInterval:SECONDS_FOR_ONE_DAY];
    }
    
	return sMarks;
}



@end
