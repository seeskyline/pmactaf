//
//  RoundInfo.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-24.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ENUM_ROUND_STATUS {
	ENUM_ROUND_STATUS_UNSTARTED,
	ENUM_ROUND_STATUS_UNDERWAY,
	ENUM_ROUND_STATUS_DONE_FAILURE,
	ENUM_ROUND_STATUS_DONE_SUCCESS,
    ENUM_ROUND_STATUS_DONE_CANCELED,
}
ENUM_ROUND_STATUS;


@interface RoundInfo : NSObject

@property (nonatomic, assign) NSInteger mRoundID;
@property (nonatomic, retain) NSDate* mStartDate;
@property (nonatomic, retain) NSDate* mEndDate;
@property (nonatomic, assign) double mTargetWeight;
@property (nonatomic, assign) ENUM_ROUND_STATUS mStatus;

- (BOOL) isUnderway;
- (BOOL) updateStatusIfNecessary;
@end
