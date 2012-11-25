//
//  NSDateFormatter+MyDateFormatter.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-12.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (MyDateFormatter)

- (NSString*) year: (NSDate*)aDate;

- (NSString*) standardYMDFormatedString: (NSDate*)aDate;
- (NSString*) standardYMDFormatedStringLeadigZero: (NSDate*)aDate;


- (NSString*) standardMDFormatedString: (NSDate*)aDate;
- (NSString*) standardMDFormatedStringLeadigZero: (NSDate*)aDate;
- (NSString*) standardMDFormatedStringLeadigZeroCN: (NSDate*)aDate;
- (NSString*) standardYMDFormatedStringLeadigZeroCN: (NSDate*)aDate;

- (NSString*) standardMDFormatedStringCN: (NSDate*)aDate;
- (NSString*) standardMDFormatedStringCNMoreReadable: (NSDate*)aDate;


- (NSString*) standardYMDFormatedStringLeadigZeroMoreReadable: (NSDate*)aDate;

@end
