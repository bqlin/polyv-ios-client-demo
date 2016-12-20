//
//  PvVideo.h
//  polyvSDK
//
//  Created by seanwong on 1/21/16.
//  Copyright © 2016 easefun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, PvLevel) {
	/// 自动码率/清晰度
	PvLevelAuto,
	/// 标清
	PvLevelStandard = 1,
	/// 高清
	PvLevelHigh,
	/// 超清
	PvLevelUltra
};

@interface PvVideo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic,copy) NSString *vid;
@property (nonatomic,copy) NSString *piclink;
@property (nonatomic,copy) NSString *duration;
@property NSArray* filesize;
@property int level;
@property int df_num;
@property int seed;
@property BOOL isInteractiveVideo;
@property int status;
@property int fullmp4;
@property NSArray *hlslinks;
@property NSArray *mp4links;
@property NSDictionary *videoSrts;
@property BOOL outflow;
@property BOOL timeoutflow;
@property BOOL teaserShow;

@property NSString*teaser_url;

-(BOOL)available;



@end
