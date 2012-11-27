//
//  StoreManager.h
//  AboutSex
//
//  Created by Shane Wen on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "DateWeight.h"
#import "RoundInfo.h"
#import "UserInfo.h"

#import "Section.h"



@interface StoreManager : NSObject

+ (BOOL) openIfNecessary;
+ (void) close;
+ (NSString*) getPathForDBinDocunemtsDir;

//getter
+ (NSMutableArray*)getRecentWeightsForDays:(NSInteger)aNumOfDays aFirstWeight:(CGFloat*)aFirstWeight aOutMaxWeight:(CGFloat*)aOutMaxWeight aOutMinWeight:(CGFloat*)aOutMinWeight;

+ (NSMutableArray*) getWeightsFromStartDateSelfIncluded:(NSDate*)aStartDateSelfIncluded aEndDateSelfIncluded:(NSDate*)aEndDateSelfIncluded aFirstWeight:(CGFloat*)aFirstWeight aOutMaxWeight:(CGFloat*)aOutMaxWeight aOutMinWeight:(CGFloat*)aOutMinWeight;

+ (RoundInfo*) getLastRound;
+ (NSMutableArray*) getAllRounds;

+ (CGFloat) getWeightByDate:(NSDate*)aDate;
//+ (double) getLastWeightBeforeDate:(NSDate*)aDate; //the last weight before aDate or weight on the day of aDate.
+ (DateWeight*) getLastDateWeightBeforeDate:(NSDate*)aDate; //the last weight before aDate or weight on the day of aDate.
+ (DateWeight*) getMostRecentDateWeight;
+ (CGFloat) getMostRecentWeight;
+ (DateWeight*) getFirstDateWeighSinceDate:(NSDate*)aDateIncluded;



//setter
//if there exists an item in users table, then update the item, otherwise insert it into users table. mind you, there cannot be more than one item in users table.
+ (BOOL) addOrUpdateUserInfoWithMail: (NSString*)aMail aName:(NSString*)aName aIsFemale:(BOOL)aIsFemale aAge:(NSInteger)aAge aHeight:(CGFloat)aHeight aWeight:(CGFloat)aWeight;

+ (BOOL) addOrUpdateUserInfoEmail:(NSString*)aEmail;
+ (BOOL) addOrUpdateUserInfoHeight:(CGFloat)aHeight;
+ (BOOL) addOrUpdateUserInfoIsFemale:(BOOL)aIsFemale;
+ (BOOL) addOrUpdateUserInfoName:(NSString*)aName;


+ (UserInfo*) getUserInfo;



//if there exists an item of the same day(computed from aDate), then update it, otherwise add it into database.
+ (BOOL) addOrUpdateWeight:(CGFloat)aWeight aDate:(NSDate*)aDate;

+ (BOOL) updateRoundInfoWithStartTime: (NSDate*)aStartTime aEndTime:(NSDate*)aEndtime aTargetWeight:(CGFloat)aTargetWeight aStatus:(NSInteger)aStatus ForRoundID:(NSInteger)aRoundID;

+ (BOOL) addRoundInfoWithStartTime:(NSDate*)aStartTime aEndTime:(NSDate*)aEndtime aTargetWeight:(CGFloat)aTargetWeight aStatus:(NSInteger)aStatus;
+ (BOOL) UpdateROundStatus:(ENUM_ROUND_STATUS)aStatus RoundID:(NSInteger)aRoundID;

////////////////////////////////////////////////////////////////////////////////
+ (Section*) getSectionByName: (NSString*) aName;
+ (BOOL) updateSectionOffset:(CGFloat)aOffset ForSection:(NSInteger)aSectionID;


@end
