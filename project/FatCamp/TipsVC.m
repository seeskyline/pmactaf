//
//  TipsVC.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-8.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "TipsVC.h"
#import "SharedVariables.h"
#import "Section.h"
#import "Item.h"
#import "StoreManager.h"
#import "ContentViewController.h"

#define SECTION_NAME @"tips"

@interface TipsVC ()
{
    Section* mSection;
    NSString* mSectionName;

}

@property (nonatomic, retain) NSString* mSectionName;
@property (nonatomic, retain) Section* mSection;

@end


@implementation TipsVC

@synthesize mSection;
@synthesize mSectionName;


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
    self = [super init];
    if (self)
    {
        self.title = aTitle;
        self.mSectionName = SECTION_NAME;
        [self loadData];
        self.view.backgroundColor = MAIN_BGCOLOR_TABPAGE;
//        self.tableView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundColor:[UIColor clearColor]];

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView reloadData];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.contentOffset = CGPointMake(0, self.mSection.mOffset);
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.mSection.mOffset = self.tableView.contentOffset.y;
    
    [StoreManager updateSectionOffset:self.mSection.mOffset ForSection:self.mSection.mSectionID];
    
}


- (void) loadData
{
    self.mSection = [StoreManager getSectionByName: self.mSectionName];

    return;
}

- (Item*) getItemByIndexPath:(NSIndexPath*)aIndexPath
{
    NSInteger sSection = [aIndexPath section];
    NSInteger sRow = [aIndexPath row];
    
    Item* sItem = [self.mSection getItemByIndex:sRow InCategory:sSection];

    return sItem;
}


#pragma mark -
#pragma mark DataSource interface for UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sNumOfSectionsInTable = [self.mSection.mCategories count];
    return sNumOfSectionsInTable;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section<0
        || section >= self.mSection.mCategories.count)
    {
        return -1;
    }
    
    Category* sCat = (Category*)[self.mSection.mCategories objectAtIndex:section];
    NSInteger sNumOfRowsInSection = [sCat.mItems count];
    
    return sNumOfRowsInSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section<0
        || section >= self.mSection.mCategories.count)
    {
        return @"";
    }

    NSString* sSectionTitle;
    Category* sCat = (Category*)[self.mSection.mCategories objectAtIndex:section];
    if (0 == section)
    {
        sSectionTitle = [NSString stringWithFormat: @"%@", sCat.mName];       
    }
    else
    {
        NSString* sSectionStr = [NSString stringWithFormat:@"%d", section];
        NSString* sSerialNO = NSLocalizedString(sSectionStr, nil);
        sSectionTitle = [NSString stringWithFormat: @"%@%@",sSerialNO, sCat.mName];
    }
    return sSectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* sCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!sCell)
    {
        sCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
        UIView* sBGView = [[UIView alloc] initWithFrame:sCell.frame];
        sBGView.backgroundColor = SELECTED_CELL_COLOR;
        sCell.selectedBackgroundView = sBGView;
        [sBGView release];
        sCell.backgroundColor = MAIN_BGCOLOR_TABPAGE;
        sCell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    
    Item* sItem = [self getItemByIndexPath:indexPath];
    
    NSString* sTitle = [NSString stringWithFormat:@"%d.%@", [indexPath row]+1, sItem.mName];
    
    sCell.textLabel.text = sTitle;
    
    return sCell;

}


#pragma mark -
#pragma mark UITableViewDelegate interface for UITableView
#pragma mark - Table view delegate
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel* sUILabel = [[[UILabel alloc]init] autorelease];
//    sUILabel.backgroundColor = MAIN_BGCOLOR_TRANSPARENT;
//    sUILabel.textColor = [UIColor whiteColor];
//    switch (section)
//    {
//        case 0:
//            sUILabel.text = @">>>basics";
//            break;
//        case 1:
//            sUILabel.text =  @">>>diet";
//            break;
//        case 2:
//            sUILabel.text =  @">>>sports";
//            break;
//        default:
//            break;
//    }
//
//    return sUILabel;
//}
//
//#pragma mark - UITableView Delegate methods
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 25;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel* sLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width-5, [self tableView:tableView heightForHeaderInSection:section])] autorelease];
//    sLabel.backgroundColor = SELECTED_CELL_COLOR;
////    sLabel.layer.cornerRadius = 2.0;
//    sLabel.text = [self tableView:tableView titleForHeaderInSection:section];
//    sLabel.textAlignment = UITextAlignmentLeft;
//    sLabel.textColor = [UIColor blackColor];
////    sLabel.font = [UIFont boldSystemFontOfSize:13];
//    return sLabel;
//}
//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSInteger sRow = [indexPath row];
    Item* sItem = [self getItemByIndexPath:indexPath];
    NSString* sTitle = sItem.mName;
    NSString* sLocV = sItem.mLocation;
    
    
    NSString* sBundlePath = [[NSBundle mainBundle] bundlePath];
    NSString* sLoc = [sBundlePath stringByAppendingPathComponent:sLocV];
    
    
    //    NSString* sLoc = [APP_DIR stringByAppendingString: sLocV];
    
    ContentViewController* sContentViewController;
    sContentViewController = [[ContentViewController alloc]init];
    sContentViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:sContentViewController animated:YES];
    
    [sContentViewController setTitle:sTitle AndContentLoc:sLoc AndWithCollectionSupport:NO];
    
    [sContentViewController release];
    
    //refresh the corresponding item's isRead status if necessary.
//    [self markItemOfSeletedRowAsReaded];
    
    
    return;
}



@end
