//
//  HeightEditorViewController.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-30.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralValuePicker.h"

@interface HeightEditorViewController : UIViewController<ValueChangedNotifier>

- (id) initWithExistingHeight:(CGFloat) aExistingHeight;
@end
