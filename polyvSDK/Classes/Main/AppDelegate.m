//
//  AppDelegate.m
//  polyvSDK
//
//  Created by seanwong on 7/10/14.
//  Copyright (c) 2014 easefun. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "PolyvSettings.h"
#import "PolyvUtil.h"
#import "PolyvSettings+Bq.h"
#import <AlicloudUtils/AlicloudReachabilityManager.h>
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 当前 SDK 版本
    NSLog(@"当前 SDK 版本：%@", [PolyvSettings sdkVersion]);
    
    // 监听SDK错误通知
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(errorDidOccur:) name:PLVErrorNotification object:nil];
    
    // 采用 AlicloudReachabilityManager 监听网络情况
    [AlicloudReachabilityManager shareInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusDidChange:) name:ALICLOUD_NETWOEK_STATUS_NOTIFY object:nil];
    
	// 配置下载目录
    [PolyvSettings sharedInstance].downloadDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/plvideo/a"];
	// 配置日志等级
	[PolyvSettings.sharedInstance setLogLevel:PLVLogLevelAll];
	// 开启 HttpDNS 功能
	[PolyvSettings.sharedInstance setHttpDNSEnable:YES];
	
	// 配置sdk加密串
	[PolyvSettings sharedInstance].bqAccountEnable = YES;

    NSError *error = nil;
    BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (!success) {
        // Handle error here, as appropriate
    }
	
	// 配置音频会话，忽略系统静音开关
	[self setupAudioSession];
	
	return YES;
}

/// 配置音量会话
- (void)setupAudioSession {
	NSError *categoryError = nil;
	if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&categoryError]){
		NSLog(@"音量会话类别设置错误：%@", categoryError);
	}
	
	NSError *activeError = nil;
	if (![[AVAudioSession sharedInstance] setActive:YES error:&activeError])	{
		NSLog(@"音量会话激活设置错误：%@", activeError);
	}
}

/// 错误通知响应
- (void)errorDidOccur:(NSNotification *)notificaiton {
    NSLog(@"%@ - error info = %@", notificaiton.object, notificaiton.userInfo[PLVErrorMessageKey]);
}

/// 网络情况通知响应
- (void)networkStatusDidChange:(NSNotification *)notification {
    if ([AlicloudReachabilityManager shareInstance].preNetworkStatus == [AlicloudReachabilityManager shareInstance].currentNetworkStatus) return;
    NSString *networkStatusString = @"nerwork status did change: ";
    switch ([AlicloudReachabilityManager shareInstance].currentNetworkStatus) {
        case AlicloudNotReachable:{
            networkStatusString = [networkStatusString stringByAppendingFormat:@"Not Reachable."];
        }break;
        case AlicloudReachableVia2G:{
            networkStatusString = [networkStatusString stringByAppendingFormat:@"2G."];
        }break;
        case AlicloudReachableVia3G:{
            networkStatusString = [networkStatusString stringByAppendingFormat:@"3G."];
        }break;
        case AlicloudReachableVia4G:{
            networkStatusString = [networkStatusString stringByAppendingFormat:@"4G."];
        }break;
        case AlicloudReachableViaWiFi:{
            networkStatusString = [networkStatusString stringByAppendingFormat:@"WiFi."];
        }break;
        default:{}break;
    }
    NSLog(@"%@", networkStatusString);
}

-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(nonnull void (^)())completionHandler
{
	NSDictionary *userInfo = @{PLVSessionIdKey: identifier,
							   PLVBackgroundSessionCompletionHandlerKey: completionHandler};
    
    NSLog(@"background id: %@", identifier);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PLVBackgroundSessionUpdateNotification
														object:self
													  userInfo:userInfo];
}
/*
 
 -(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(nonnull NSString *)identifier completionHandler:(nonnull void (^)())completionHandler
 {
 self.backgroudSesstonCompletionHandler = completionHandler;
 }
*/

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 [[PolyvSettings sharedInstance]  reloadSettings];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end

//
////默认Portrait避免自动旋转
//@implementation UITabBarController (PolyvDemo)
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    if(toInterfaceOrientation == UIDeviceOrientationPortrait)
//        return YES;
//    return NO;
//}
//-(BOOL)shouldAutorotate{
//    return NO;
//}
//
//
//
//@end
//
//@implementation UINavigationController (PolyvDemo)
//-(BOOL)shouldAutorotate{
//    return NO;
//}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    if(toInterfaceOrientation == UIDeviceOrientationPortrait){
//        return YES;
//    }
//    
//    return NO;
//}
//@end
