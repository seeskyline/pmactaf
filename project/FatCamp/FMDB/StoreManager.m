//
//  StoreManager.m
//  AboutSex
//
//  Created by Shane Wen on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoreManager.h"
#import "SharedVariables.h"

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMResultSet.h"
#import "NSDateFormatter+MyDateFormatter.h"
#import "NSDate+MyDate.h"

#define DB_FILE_FULL_NAME         @"fatcamp.db"
#define DB_FILE_NAME              @"fatcamp"
#define DB_FILE_EXT_NAME          @"db"
#define TABLE_NAME_USERS          @"users"
#define TABLE_NAME_WEIGHTS        @"weights"
#define TABLE_NAME_ROUNDS         @"rounds"

#ifdef DEBUG
//#define REMOVE_EXISTING_DB_ON_LAUNCH
#endif

FMDatabase* ssFMDatabase;

@implementation StoreManager

+ (NSString*) getPathForDBinDocunemtsDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0];   
    
    NSString* sPathForDB = [documentsDirectory stringByAppendingPathComponent:DB_FILE_FULL_NAME];

//    NSString* sPathForDB = [[NSBundle mainBundle]pathForResource:@"aboutsex" ofType:@"db" inDirectory:nil];

    return sPathForDB;
}

//when db file exists in documents directory under bin, remove it if REMOVE_EXISTING_DB_ON_LAUNCH is defined.
+ (BOOL) removeExistingDatabaseFileIfNecessary
{
#ifdef REMOVE_EXISTING_DB_ON_LAUNCH
    {
        NSString* sPathForDBinDocumensDir = [self getPathForDBinDocunemtsDir];

        if ([[NSFileManager defaultManager]fileExistsAtPath:sPathForDBinDocumensDir])
        {
            NSError* sErr = nil;
            [[NSFileManager defaultManager] removeItemAtPath:sPathForDBinDocumensDir error:&sErr];            
            return YES;
        }
    }
#endif
    return FALSE;
}

+ (BOOL) openIfNecessary
{
    //return if it has been opened already.
    if (ssFMDatabase)
    {
        return YES;
    }
    
    //remove the existing database file in Documents if necessary().
    [self removeExistingDatabaseFileIfNecessary];

    //copy Database file from bundle to Documents directory if there is no database file in Documents directory.
    NSString* sPathForDBinDocumensDir = [self getPathForDBinDocunemtsDir];
    BOOL sIsDBFileExistent = [[NSFileManager defaultManager]fileExistsAtPath:sPathForDBinDocumensDir];
    if (!sIsDBFileExistent)
    {
        {
            NSString* sPathForDBinBundle = [[NSBundle mainBundle]pathForResource:DB_FILE_NAME ofType:DB_FILE_EXT_NAME inDirectory:nil];
            sIsDBFileExistent = [[NSFileManager defaultManager]fileExistsAtPath:sPathForDBinBundle];
            if (!sIsDBFileExistent)
            {
#ifdef DEBUG
                NSLog(@"database %@ does not exist!", sPathForDBinBundle);
#endif
                return NO;
            }

            NSData *sDBFileData = [NSData dataWithContentsOfFile:sPathForDBinBundle]; 
            [[NSFileManager defaultManager] createFileAtPath:sPathForDBinDocumensDir 
                                                    contents:sDBFileData 
                                                    attributes:nil]; 
        }
        
        sIsDBFileExistent = [[NSFileManager defaultManager]fileExistsAtPath:sPathForDBinDocumensDir];

        if (!sIsDBFileExistent)
        {
#ifdef DEBUG
            NSLog(@"database %@ does not exist!", sPathForDBinDocumensDir);
#endif
            return NO;
        }
    }
    ssFMDatabase = [FMDatabase databaseWithPath:sPathForDBinDocumensDir];

    if (![ssFMDatabase open])
    {
#ifdef DEBUG
        NSLog(@"database %@ cannot be opened", [ssFMDatabase databasePath]);
#endif
        return NO;
    }

    [ssFMDatabase retain];
    
    return YES;
}

+ (void) close
{
    if (ssFMDatabase)
    {
        [ssFMDatabase close];
        [ssFMDatabase release];
        ssFMDatabase = nil;
    }
    return;
}

//aHeight and aWeight, of type double, is stored not precisely. when you store 50.1, you will get 50.0999984741211.
+ (BOOL) addOrUpdateUserInfoWithMail: (NSString*)aMail aName:(NSString*)aName aIsFemale:(BOOL)aIsFemale aAge:(NSInteger)aAge aHeight:(CGFloat)aHeight aWeight:(CGFloat)aWeight
{
    [StoreManager openIfNecessary];
    NSString* sSQLStr = @"SELECT COUNT(*) FROM users";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];
    
    //update if it exists, add otherwise.
    if ([rs next])
    {
        NSInteger sNumOfUser = [rs intForColumnIndex:0];
        [rs close];
        
        if (1 == sNumOfUser)
        {
            sSQLStr = @"UPDATE users SET mail=?, name=?, female=?, age=?, height=?, weight=? WHERE userID=1";
            
            return [ssFMDatabase executeUpdate:sSQLStr, aMail, aName, [NSNumber numberWithBool:aIsFemale], [NSNumber numberWithInteger:aAge], [NSNumber numberWithDouble:aHeight], [NSNumber numberWithDouble:aWeight]];
        }
        else if (0 == sNumOfUser)
        {            
            sSQLStr = @"INSERT INTO users(mail, name, female, age, height, weight) VALUES(?, ?, ?, ?, ?, ?)";
            return [ssFMDatabase executeUpdate:sSQLStr, aMail, aName, [NSNumber numberWithBool:aIsFemale], [NSNumber numberWithInteger:aAge], [NSNumber numberWithDouble:aHeight], [NSNumber numberWithDouble:aWeight]];
        }
        else
        {
            return NO;
        }

    }
    return NO;
}

+ (BOOL) addOrUpdateUserInfoName:(NSString*)aName
{
    [StoreManager openIfNecessary];
    NSString* sSQLStr = @"SELECT COUNT(*) FROM users";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];
    
    //update if it exists, add otherwise.
    if ([rs next])
    {
        NSInteger sNumOfUser = [rs intForColumnIndex:0];
        [rs close];
        
        if (1 == sNumOfUser)
        {
            sSQLStr = @"UPDATE users SET name=? WHERE userID=1";
            
            return [ssFMDatabase executeUpdate:sSQLStr, aName];
        }
        else if (0 == sNumOfUser)
        {
            sSQLStr = @"INSERT INTO users(name) VALUES(?)";
            return [ssFMDatabase executeUpdate:sSQLStr, aName];
        }
        else
        {
            return NO;
        }
        
    }
    return NO;

}

+ (BOOL) addOrUpdateUserInfoIsFemale:(BOOL)aIsFemale
{
    [StoreManager openIfNecessary];
    NSString* sSQLStr = @"SELECT COUNT(*) FROM users";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];
    
    //update if it exists, add otherwise.
    if ([rs next])
    {
        NSInteger sNumOfUser = [rs intForColumnIndex:0];
        [rs close];
        
        if (1 == sNumOfUser)
        {
            sSQLStr = @"UPDATE users SET female=? WHERE userID=1";
            
            return [ssFMDatabase executeUpdate:sSQLStr, [NSNumber numberWithBool:aIsFemale]];
        }
        else if (0 == sNumOfUser)
        {
            sSQLStr = @"INSERT INTO users(female) VALUES(?)";
            return [ssFMDatabase executeUpdate:sSQLStr, [NSNumber numberWithBool:aIsFemale]];
        }
        else
        {
            return NO;
        }
        
    }
    return NO;

}

+ (BOOL) addOrUpdateUserInfoHeight:(CGFloat)aHeight
{
    [StoreManager openIfNecessary];
    NSString* sSQLStr = @"SELECT COUNT(*) FROM users";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];
    
    //update if it exists, add otherwise.
    if ([rs next])
    {
        NSInteger sNumOfUser = [rs intForColumnIndex:0];
        [rs close];
        
        if (1 == sNumOfUser)
        {
            sSQLStr = @"UPDATE users SET height=? WHERE userID=1";
            
            return [ssFMDatabase executeUpdate:sSQLStr, [NSNumber numberWithDouble:aHeight]];
        }
        else if (0 == sNumOfUser)
        {
            sSQLStr = @"INSERT INTO users(height) VALUES(?)";
            return [ssFMDatabase executeUpdate:sSQLStr, [NSNumber numberWithDouble:aHeight]];
        }
        else
        {
            return NO;
        }
        
    }
    return NO;
}

+ (BOOL) addOrUpdateUserInfoEmail:(NSString*)aEmail
{
    [StoreManager openIfNecessary];
    NSString* sSQLStr = @"SELECT COUNT(*) FROM users";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];
    
    //update if it exists, add otherwise.
    if ([rs next])
    {
        NSInteger sNumOfUser = [rs intForColumnIndex:0];
        [rs close];
        
        if (1 == sNumOfUser)
        {
            sSQLStr = @"UPDATE users SET mail=? WHERE userID=1";
            
            return [ssFMDatabase executeUpdate:sSQLStr, aEmail];
        }
        else if (0 == sNumOfUser)
        {
            sSQLStr = @"INSERT INTO users(mail) VALUES(?)";
            return [ssFMDatabase executeUpdate:sSQLStr, aEmail];
        }
        else
        {
            return NO;
        }
        
    }
    return NO;

    
}





+ (UserInfo*) getUserInfo
{
    
    [StoreManager openIfNecessary];
    NSString* sSQLStr = @"SELECT * FROM users LIMIT 1";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];
    
    UserInfo* sUserInfo = [[[UserInfo alloc] init] autorelease];
    sUserInfo.mNewDateWeight = [self getMostRecentDateWeight];

    //update if it exists, add otherwise.
    if ([rs next])
    {
        sUserInfo.mUserID = [rs intForColumn:@"userID"];
        sUserInfo.mName = [rs stringForColumn:@"name"];
        sUserInfo.mEmail = [rs stringForColumn:@"mail"];
        sUserInfo.mIsFemale = [rs boolForColumn:@"female"];
        sUserInfo.mAge = [rs intForColumn:@"age"];
        sUserInfo.mHeight = [rs doubleForColumn:@"height"];
    }
    [rs close];

    return sUserInfo;
}

//if there exists an item of the same day(computed from aDate), then update it, otherwise add it into database.
+ (BOOL) addOrUpdateWeight:(CGFloat)aWeight aDate:(NSDate*)aDate
{
    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
    NSString* sDateStr = [sDateFormatter standardYMDFormatedStringLeadigZero:aDate];
    
    [StoreManager openIfNecessary];
    //necessary to use 'localtime' argument?
    NSString* sSQLStr = @"SELECT COUNT(*) FROM weights WHERE date(time, 'unixepoch', 'localtime') = ?";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr, sDateStr];
    
    //update if it exists, add otherwise.
    if ([rs next])
    {
        NSInteger sNumOfItemOnSameDay = [rs intForColumnIndex:0];
        [rs close];
        if (1 == sNumOfItemOnSameDay)
        {
            sSQLStr = @"UPDATE weights SET weight=? WHERE date(time, 'unixepoch', 'localtime') = ?";
            
            return [ssFMDatabase executeUpdate:sSQLStr, [NSNumber numberWithDouble:aWeight], sDateStr];
        }
        else if (0 == sNumOfItemOnSameDay)
        {
            sSQLStr = @"INSERT INTO weights(time ,weight) VALUES(?, ?)";
            return [ssFMDatabase executeUpdate:sSQLStr, aDate, [NSNumber numberWithDouble:aWeight]];
        }
        else
        {
            return NO;
        }

    }
    return NO;
}

+ (CGFloat) getWeightByDate:(NSDate*)aDate
{
    NSDateFormatter* sDateFormatter = [[[NSDateFormatter alloc]init] autorelease];
    NSString* sDateStr = [sDateFormatter standardYMDFormatedStringLeadigZero:aDate];
    
    [StoreManager openIfNecessary];
    //necessary to use 'localtime' argument?
    NSString* sSQLStr = @"SELECT * FROM weights WHERE date(time, 'unixepoch', 'localtime') = ?";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr, sDateStr];
    
    CGFloat sWeight = -1;
    if ([rs next])
    {
         sWeight = [rs doubleForColumn:@"weight"];
    }
    [rs close];
    
    return sWeight;
}

+ (double) getLastWeightBeforeDate:(NSDate*)aDate
{
    [StoreManager openIfNecessary];
    
    NSString* sSQLStr = @"SELECT * FROM weights WHERE time = (SELECT MAX(time) FROM weights WHERE time <= ?)";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr, aDate];
    
    CGFloat sWeight = -1;
    if ([rs next])
    {
        sWeight = [rs doubleForColumn:@"weight"];
    }
    
    [rs close];
    
    return sWeight;

}

+ (DateWeight*) getLastDateWeightBeforeDate:(NSDate*)aDate
{
    [StoreManager openIfNecessary];
    
    NSString* sSQLStr = @"SELECT * FROM weights WHERE time = (SELECT MAX(time) FROM weights WHERE time <= ?)";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr, aDate];
    
    DateWeight* sDateWeight = nil;
    
    if ([rs next])
    {
        sDateWeight = [[[DateWeight alloc] init] autorelease];
        sDateWeight.mWeight = [rs doubleForColumn:@"weight"];
        sDateWeight.mDate = [rs dateForColumn:@"time"];
    }
    
    [rs close];
    
    return sDateWeight;
}


+ (CGFloat) getMostRecentWeight
{
    DateWeight* sDateWeight = [self getMostRecentDateWeight];
    if (!sDateWeight)
    {
        return -1;
    }
    else
    {
        return sDateWeight.mWeight;
    }
}

+ (DateWeight*) getMostRecentDateWeight
{
    [StoreManager openIfNecessary];
    
    NSString* sSQLStr = @"SELECT * FROM weights WHERE time = (SELECT MAX(time) FROM weights)";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];
    
    DateWeight* sDateWeight = nil;
    if ([rs next])
    {
        sDateWeight = [[[DateWeight alloc] init] autorelease];
        sDateWeight.mDWID = [rs intForColumn:@"weightID"];
        sDateWeight.mDate = [rs dateForColumn:@"time"];
        sDateWeight.mWeight = [rs doubleForColumn:@"weight"];
    }
    
    [rs close];

    return sDateWeight;
}

+ (DateWeight*) getFirstDateWeighSinceDate:(NSDate*)aDateIncluded
{
    [StoreManager openIfNecessary];
    
    NSString* sSQLStr = @"SELECT * FROM weights WHERE time = (SELECT MIN(time) FROM weights WHERE time>=?)";
    FMResultSet *sResultSet = [ssFMDatabase executeQuery:sSQLStr, aDateIncluded];
    
    DateWeight* sDateWeight = nil;
    if ([sResultSet next])
    {
        sDateWeight = [[[DateWeight alloc] init] autorelease];
        sDateWeight.mDWID = [sResultSet intForColumn:@"weightID"];
        sDateWeight.mDate = [sResultSet dateForColumn:@"time"];
        sDateWeight.mWeight = [sResultSet doubleForColumn:@"weight"];
    }
    
    [sResultSet close];
    
    return sDateWeight;
}

+ (BOOL) updateRoundInfoWithStartTime: (NSDate*)aStartTime aEndTime:(NSDate*)aEndtime aTargetWeight:(CGFloat)aTargetWeight aStatus:(NSInteger)aStatus ForRoundID:(NSInteger)aRoundID
{
    [StoreManager openIfNecessary];

    NSString* sSQLStr = @"UPDATE rounds SET startTime=?, endTime=?, targetWeight=?, status=? WHERE roundID = ?";
    
    return [ssFMDatabase executeUpdate:sSQLStr, aStartTime, aEndtime, [NSNumber numberWithDouble:aTargetWeight], [NSNumber numberWithInteger:aStatus], [NSNumber numberWithInteger:aRoundID]];

}

+ (BOOL) addRoundInfoWithStartTime:(NSDate*)aStartTime aEndTime:(NSDate*)aEndtime aTargetWeight:(CGFloat)aTargetWeight aStatus:(NSInteger)aStatus
{
    [StoreManager openIfNecessary];

    NSString* sSQLStr = @"INSERT INTO rounds(startTime, endTime, targetWeight, status) VALUES(?, ?, ?, ?)";
    return [ssFMDatabase executeUpdate:sSQLStr, aStartTime, aEndtime, [NSNumber numberWithDouble:aTargetWeight], [NSNumber numberWithInteger:aStatus]];

}

+ (BOOL) UpdateROundStatus:(ENUM_ROUND_STATUS)aStatus RoundID:(NSInteger)aRoundID
{
    [StoreManager openIfNecessary];
    
    NSString* sSQLStr = @"UPDATE rounds SET status=? WHERE roundID = ?";
    
    return [ssFMDatabase executeUpdate:sSQLStr, [NSNumber numberWithInteger:aStatus], [NSNumber numberWithInteger:aRoundID]];

}

//+ (NSMutableArray*)getRecentWeights:(NSInteger)aNumOfDays
//{
//    return [self getRecentWeights:aNumOfDays aOutMaxWeight:nil aOutMinWeight:nil];
//}

+ (NSMutableArray*)getRecentWeightsForDays:(NSInteger)aNumOfDays aFirstWeight:(CGFloat*)aFirstWeight aOutMaxWeight:(CGFloat*)aOutMaxWeight aOutMinWeight:(CGFloat*)aOutMinWeight;
{    
    if (aNumOfDays < 1)
    {
        return nil;
    }
    
    NSDate* sNowDate = [NSDate date];
    NSDate* sStartDate = [[sNowDate dateByAddingTimeInterval:-((aNumOfDays-1)*SECONDS_FOR_ONE_DAY)] startDateOfTheDayinLocalTimezone];
    
    return [StoreManager getWeightsFromStartDateSelfIncluded:sStartDate aEndDateSelfIncluded:sNowDate aFirstWeight:aFirstWeight aOutMaxWeight:aOutMaxWeight aOutMinWeight:aOutMinWeight];
}

+ (NSMutableArray*) getWeightsFromStartDateSelfIncluded:(NSDate*)aStartDateSelfIncluded aEndDateSelfIncluded:(NSDate*)aEndDateSelfIncluded aFirstWeight:(CGFloat*)aFirstWeight aOutMaxWeight:(CGFloat*)aOutMaxWeight aOutMinWeight:(CGFloat*)aOutMinWeight
{
    [StoreManager openIfNecessary];
    
    if (aFirstWeight
        && aOutMaxWeight
        && aOutMinWeight)
    {
        (*aFirstWeight) = -1;
        (*aOutMinWeight) = CGFLOAT_MAX;
        (*aOutMaxWeight) = CGFLOAT_MIN;
    }
    
    NSString* sSQLStr = @"SELECT * FROM weights WHERE time >=? AND time <=? ORDER BY time ASC";
    FMResultSet *sResultSet = [ssFMDatabase executeQuery:sSQLStr, aStartDateSelfIncluded, aEndDateSelfIncluded];
    
    NSMutableArray* sDateWeightArray = [[[NSMutableArray alloc]init] autorelease];
    
    while ([sResultSet next]) {
        DateWeight* sDW = [[DateWeight alloc]init];
        
        sDW.mDate = [sResultSet dateForColumn:@"time"];
        sDW.mWeight = [sResultSet doubleForColumn:@"weight"];
        
        [sDateWeightArray addObject:sDW];
        
        if (aOutMaxWeight
            && aOutMinWeight)
        {
            if (sDW.mWeight > 0)
            {
                if (sDW.mWeight > (*aOutMaxWeight))
                {
                    (*aOutMaxWeight)  = sDW.mWeight;
                }
                if (sDW.mWeight < (*aOutMinWeight))
                {
                    (*aOutMinWeight) = sDW.mWeight;
                }
            }
            
        }
        
        
        [sDW release];
    }
    [sResultSet close];
    
    if (aFirstWeight
        && [sDateWeightArray count]>0)
    {
        (*aFirstWeight) = ((DateWeight*)[sDateWeightArray objectAtIndex:0]).mWeight;
    }
    
    return sDateWeightArray;

}

+ (RoundInfo*) getLastRound
{
    [StoreManager openIfNecessary];
    
    NSString* sSQLStr = @"SELECT * FROM rounds WHERE startTime = (SELECT MAX(startTime) FROM rounds)";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];
    
    RoundInfo* sRoundInfo = nil;
    if ([rs next])
    {
        sRoundInfo = [[[RoundInfo alloc] init]autorelease];
        sRoundInfo.mRoundID = [rs intForColumn:@"roundID"];
        sRoundInfo.mStartDate = [rs dateForColumn:@"startTime"];
        sRoundInfo.mEndDate = [rs dateForColumn:@"endTime"];
        sRoundInfo.mTargetWeight = [rs doubleForColumn:@"targetWeight"];
        sRoundInfo.mStatus = [rs intForColumn:@"status"];        
    }

    [rs close];
    
    if (sRoundInfo)
    {
        [sRoundInfo updateStatusIfNecessary];
    }
    
    return sRoundInfo;    
}

+ (NSMutableArray*) getAllRounds
{
    [StoreManager openIfNecessary];

    NSString* sSQLStr = @"SELECT * FROM rounds";
    FMResultSet *rs = [ssFMDatabase executeQuery:sSQLStr];

    NSMutableArray* sRounds = [[[NSMutableArray alloc]init ] autorelease];
    while ([rs next])
    {
        RoundInfo* sRoundInfo = [[RoundInfo alloc] init];
        sRoundInfo.mRoundID = [rs intForColumn:@"roundID"];
        sRoundInfo.mStartDate = [rs dateForColumn:@"startTime"];
        sRoundInfo.mEndDate = [rs dateForColumn:@"endTime"];
        sRoundInfo.mTargetWeight = [rs doubleForColumn:@"targetWeight"];
        sRoundInfo.mStatus = [rs intForColumn:@"status"];
        
        [sRoundInfo updateStatusIfNecessary];
        
        [sRounds addObject:sRoundInfo];
        [sRoundInfo release];
    }    
    [rs close];
    
    return sRounds;
}


#pragma mark -
#pragma mark methods for content store
+ (Section*) getSectionByName: (NSString*) aName
{
    [StoreManager openIfNecessary];
    
    NSString* sSQLStr = @"SELECT * FROM sections WHERE sections.sectionName = ?";
    FMResultSet* sRetSet = [ssFMDatabase executeQuery:sSQLStr, aName];
    
    Section* sSection = nil;
    if ([sRetSet next]) {
        sSection = [[[Section alloc]init] autorelease];
        sSection.mSectionID = [sRetSet intForColumn:@"sectionID"];
        sSection.mName = [sRetSet stringForColumn:@"sectionName"];
        sSection.mOffset = [sRetSet doubleForColumn:@"sectionOffset"];
        sSection.mCategories = nil;
    }
    else
    {
        return nil;
    }
    
    [sRetSet close];
    
    // assignment for sSection.mCategories
    sSQLStr = @"SELECT * FROM categories WHERE categories.refSectionID = ?";
    FMResultSet * sRetSetCats = [ssFMDatabase executeQuery:sSQLStr, [NSNumber numberWithInteger: sSection.mSectionID]];
    NSMutableArray* sCategories = [[NSMutableArray alloc]init];
    while ([sRetSetCats next])
    {
        Category* sCat = [[Category alloc]init];
        sCat.mCategoryID = [sRetSetCats intForColumn:@"categoryID"];
        sCat.mName = [sRetSetCats stringForColumn:@"categoryName"];
        sCat.mItems = nil;
        [sCategories addObject:sCat];
        [sCat release];
    }
    [sRetSetCats close];
    sSection.mCategories = sCategories;
    [sCategories release];
    
//    sSQLStr = @"SELECT * FROM items WHERE items.refCategoryID = ? ORDER BY releasedTime DESC";
    sSQLStr = @"SELECT * FROM items WHERE items.refCategoryID = ?";
    for (Category* sCat in sSection.mCategories)
    {
        //assignment for sCat.mItems
        FMResultSet* sRetSetItems = [ssFMDatabase executeQuery:sSQLStr, [NSNumber numberWithInteger:sCat.mCategoryID]];
        NSMutableArray* sItems = [[NSMutableArray alloc]init];
        while ([sRetSetItems next])
        {
            Item* sItem = [[Item alloc]init];
            sItem.mItemID = [sRetSetItems intForColumn:@"itemID"];
            sItem.mName = [sRetSetItems stringForColumn:@"itemName"];
            sItem.mLocation = [sRetSetItems stringForColumn:@"location"];
            sItem.mIsRead = [sRetSetItems boolForColumn:@"isRead"];
            sItem.mIsMarked = [sRetSetItems boolForColumn:@"isMarked"];
            sItem.mReleasedTime = [sRetSetItems dateForColumn:@"releasedTime"];
            sItem.mMarkedTime = [sRetSetItems dateForColumn:@"markedTime"];
            sItem.mCategory = sCat;
            sItem.mSection = sSection;
            
            [sItems addObject:sItem];
            [sItem release];
        }
        [sRetSetItems close];
        sCat.mItems = sItems;
        [sItems release];
        
    }
    
    [sSection initIndexOfTheFirstItemForEachCategory];
    return sSection;
}

+ (BOOL) updateSectionOffset:(CGFloat)aOffset ForSection:(NSInteger)aSectionID
{
    [StoreManager openIfNecessary];
    
    NSString* sSQLStr = @"UPDATE sections SET sectionOffset=? WHERE sections.sectionID=?";
    BOOL sIsSuccess = [ssFMDatabase executeUpdate:sSQLStr, [NSNumber numberWithDouble:aOffset],[NSNumber numberWithInteger:aSectionID]];
    
    return sIsSuccess;
}



@end


