//
//  NameEditorViewController.m
//  FatCamp
//
//  Created by Wen Shane on 12-10-30.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "NameEditorViewController.h"
#import "SharedVariables.h"
#import "StoreManager.h"
#import "ATMHud.h"

#import <QuartzCore/QuartzCore.h>


#define MAX_LEN_OF_NAME 20

@interface NameEditorViewController ()
{
    UITextField* mTextField;
    UILabel* mMaxNameLengthNoticeLabel;
    NSString* mExistingName;
    
}

@property (nonatomic, retain) UITextField* mTextField;
@property (nonatomic, retain) UILabel* mMaxNameLengthNoticeLabel;
@property (nonatomic, copy) NSString* mExistingName;

@end


@implementation NameEditorViewController

@synthesize mTextField;
@synthesize mExistingName;
@synthesize mMaxNameLengthNoticeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithExistingName:(NSString*)aExisitingName
{
    self = [super init];
    if (self)
    {        
        UIBarButtonItem* sRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:   NSLocalizedString(@"save", nil) style: UIBarButtonItemStylePlain target:self action:@selector(saveBtnPressed)];
        self.navigationItem.rightBarButtonItem = sRightBarButtonItem;
        [sRightBarButtonItem release];
        
        self.mExistingName = aExisitingName;

    }
    return self;
}

- (void) loadView
{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    UIView* sView = [[UIView alloc] initWithFrame:applicationFrame];
    sView.backgroundColor = MAIN_BGCOLOR_TABPAGE;
    self.view = sView;
    
    [sView release];
    
//    CGFloat sX = TOP_LINE_RECT.origin.x;
//    CGFloat sY = TOP_LINE_RECT.origin.y;
//    CGFloat sWidth = TOP_LINE_RECT.size.width;
//    CGFloat sHeight = TOP_LINE_RECT.size.height;
    
    UITextField* sTextField = [[UITextField alloc] initWithFrame:TOP_LINE_RECT];
    sTextField.backgroundColor = [UIColor clearColor];
    sTextField.borderStyle = UITextBorderStyleRoundedRect;
	sTextField.font = [UIFont systemFontOfSize:19];
    sTextField.delegate = self;
//    sTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;// does not work 
    sTextField.textAlignment = UITextAlignmentCenter;
    sTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    sTextField.text = self.mExistingName;
    sTextField.layer.cornerRadius = 4.0;
    
    [sTextField becomeFirstResponder];
    self.mTextField = sTextField;
    [sTextField release];
    [self.view addSubview:self.mTextField];
    
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

- (void) dealloc
{
    self.mTextField = nil;
    self.mMaxNameLengthNoticeLabel = nil;
    self.mExistingName = nil;
    
    [super dealloc];
}

- (void) saveBtnPressed
{
    NSString* sCurName = self.mTextField.text;
    if (![sCurName isEqualToString:self.mExistingName])
    {
        [StoreManager addOrUpdateUserInfoName:sCurName];       
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissKeyboard
{
    [self.mTextField resignFirstResponder];
}


#pragma mark - methods from UITextFieldDelegate protocol
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    if (newLength > MAX_LEN_OF_NAME)
    {
        if (!self.mMaxNameLengthNoticeLabel)
        {
            UILabel* sLabel = [[UILabel alloc] initWithFrame:CGRectMake(TOP_LINE_RECT.origin.x+TOP_LINE_RECT.size.width-200, TOP_LINE_RECT.origin.y+50, 200, 20)];
            sLabel.text = [NSString stringWithFormat:NSLocalizedString(@"name cannot be longer than %d characters", nil), MAX_LEN_OF_NAME];
            sLabel.textColor = [UIColor lightGrayColor];
            sLabel.font = [UIFont systemFontOfSize:15];
            sLabel.textAlignment = UITextAlignmentRight;
            sLabel.backgroundColor = [UIColor clearColor];
            self.mMaxNameLengthNoticeLabel = sLabel;
            [self.view addSubview:self.mMaxNameLengthNoticeLabel];
            [sLabel release];
        }
        else
        {
            self.mMaxNameLengthNoticeLabel.hidden = NO;     
        }        
    }
    else
    {
        if (self.mMaxNameLengthNoticeLabel)
        {
            self.mMaxNameLengthNoticeLabel.hidden = YES;
        }
    }
    
    return newLength <= MAX_LEN_OF_NAME || returnKey;
}

@end
