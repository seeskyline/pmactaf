//
//  CustomTableViewCell.m
//  FatCamp
//
//  Created by Wen Shane on 12-11-15.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "CustomTableViewCell.h"

#import <QuartzCore/QuartzCore.h>


@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    [super layoutSubviews];
//    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x,
//                                      self.frame.origin.y,
//                                      self.textLabel.frame.size.width,
//                                      self.textLabel.frame.size.height);
//    self.textLabel.center = CGPointMake(self.textLabel.center.x, self.bounds.size.height/2.0f);
   
    self.detailTextLabel.center = CGPointMake(self.detailTextLabel.center.x-20, self.detailTextLabel.center.y);
//    self.detailTextLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.detailTextLabel.layer.borderWidth = 0.8;
//    self.detailTextLabel.layer.cornerRadius = 7.0;

//    self.detailTextLabel.backgroundColor = [UIColor redColor];
}


@end
