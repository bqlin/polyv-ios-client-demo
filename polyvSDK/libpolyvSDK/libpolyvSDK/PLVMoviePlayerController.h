//
//  MPMoviePlayerController+plv.h
//  hlsplay
//
//  Created by seanwong on 4/14/15.
//  Copyright (c) 2015 easefun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PvVideo.h"

@class PLVMoviePlayerController;

@protocol PLVMoviePlayerDelegate <NSObject>
@optional

/// 视频元数据已加载
- (void)moviePlayer:(PLVMoviePlayerController *)player didLoadVideoInfo:(PvVideo *)video;

@end

@interface PLVMoviePlayerController: MPMoviePlayerController

/// 代理属性
@property (nonatomic, weak) id<PLVMoviePlayerDelegate> delegate;

/// 视频 id
@property (nonatomic, copy, getter=getVid) NSString *vid;
/// 视频元数据，已弃用，请使用 video 属性
@property (nonatomic, strong, readonly) NSDictionary *videoInfo __deprecated;
/// 视频元数据
@property (nonatomic, strong) PvVideo *video;
/// 单元 id
@property (nonatomic, copy, readonly, getter=getPid) NSString *pid;
/// 观看时间
@property (nonatomic, assign) int watchTimeDuration;
///
@property (nonatomic, assign) int stayTimeDuration;

/**
 *  初始化播放器
 *
 *  @param vid 视频 id
 *
 *  @return 播放器对象
 */
- (instancetype)initWithVid:(NSString *)vid;

/**
 *  初始化播放器
 *
 *  @param vid   视频 id
 *  @param level 视频码率
 *
 *  @return 播放器对象
 */
- (instancetype)initWithVid:(NSString *)vid level:(PvLevel)level;

- (instancetype)initWithLocalMp4:(NSString *)vid level:(PvLevel)level __deprecated;

/**
 *  切换视频源
 *
 *  @param vid   视频 id
 *  @param level 视频码率
 */
- (void)setVid:(NSString *)vid level:(PvLevel)level;

/**
 *  视频拥有的在线码率数量
 */
- (int)getLevel;

/**
 *  当前码率
 *
 *  @return 当前码率
 */
- (PvLevel)currentLevel;

/**
 *  切换码率
 *
 *  @param level 码率
 */
- (void)switchLevel:(PvLevel)level;

/**
 *  切换码率
 *
 *  @param level      码率
 *  @param completion 码率切换后的回调，参数为最终切换的码率
 */
- (void)switchLevel:(PvLevel)level completion:(void (^)(PvLevel level))completion;

/**
 *  获取本地视频码率
 *
 *  @param vid 视频 id
 *
 *  @return 本地视频码率
 */
- (int)isExistedTheLocalVideo:(NSString *)vid;

/**
 *  销毁播放器对象
 */
- (void)cancel;

@end
