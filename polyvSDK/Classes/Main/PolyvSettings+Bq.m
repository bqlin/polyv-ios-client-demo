//
//  PolyvSettings+Bq.m
//  polyvSDK_bq
//
//  Created by LinBq on 17/3/28.
//  Copyright © 2017年 Bq. All rights reserved.
//

#import "PolyvSettings+Bq.h"
#import <objc/runtime.h>
#import "PolyvUtil.h"

static void *bqAccountEnableKey = &bqAccountEnableKey;

@implementation PolyvSettings (Bq)

- (void)setBqAccountEnable:(BOOL)bqAccountEnable{
	objc_setAssociatedObject(self, &bqAccountEnableKey, @(bqAccountEnable), OBJC_ASSOCIATION_COPY);
	if (bqAccountEnable) {
		NSString *sdkKey = @"v4yoqNIHwZ69WNbOTI4rzDRHbwjUYsh14V1Czv7CNhwRE3EGBEleaezLNZms14CKhxu+KB+OPH341zknQ5+7gE5UZnz4u5V0jP+SCO9kaRwthY4UyvZ3ClHgnSBEZoTCkwrYQ+sgLVIRhjo2y+uZIQ==";
		NSArray *config = [PolyvUtil decryptUserConfig:[sdkKey dataUsingEncoding:NSUTF8StringEncoding] key:@"VXtlHmwfS2oYm0CZ" iv:@"2u9gDPKdX6GyQJKU"];
		[[PolyvSettings sharedInstance] initVideoSettings:[config objectAtIndex:1] Readtoken:[config objectAtIndex:2] Writetoken:[config objectAtIndex:3] UserId:[config objectAtIndex:0]];
	}else{
		NSString *appKey = @"iPGXfu3KLEOeCW4KXzkWGl1UYgrJP7hRxUfsJGldI6DEWJpYfhaXvMA+32YIYqAOocWd051v5XUAU17LoVlgZCSEVNkx11g7CxYadcFPYPozslnQhFjkxzzjOt7lUPsWF/CO2xt5xZemQCBkkSKLGA==";
		// 使用默认加密秘钥和加密向量解密 sdk加密串
		NSArray *config = [PolyvUtil decryptUserConfig:[appKey dataUsingEncoding:NSUTF8StringEncoding]];
		[[PolyvSettings sharedInstance] initVideoSettings:[config objectAtIndex:1] Readtoken:[config objectAtIndex:2] Writetoken:[config objectAtIndex:3] UserId:[config objectAtIndex:0]];
	}
}

- (BOOL)bqAccountEnable{
	return [objc_getAssociatedObject(self, &bqAccountEnableKey) boolValue];
}

@end
