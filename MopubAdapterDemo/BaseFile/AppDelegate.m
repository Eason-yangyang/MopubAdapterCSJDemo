//
//  AppDelegate.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "AppDelegate.h"
#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDK/MoPub.h>)
    #import <MoPubSDK/MoPub.h>
#else
    #import "MoPub.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configCustomEvent];
    return YES;
}

- (void)configCustomEvent {

    // mopub adaptor config
    MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization:@"5bf96fc264934e838ac8fe8150c01b8f"];
    
    NSMutableDictionary *networkConfig = [NSMutableDictionary dictionaryWithCapacity:2];
    
    NSMutableDictionary *InitConfig = [[NSMutableDictionary alloc] init];
    [InitConfig setValue:@"5000546" forKey:@"app_id"];
    NSDictionary *config = @{@"CSJAdapterConfiguration":InitConfig};
    
    [networkConfig addEntriesFromDictionary:config];
    
    Class<MPAdapterConfiguration> BUAdSDKAdapterConfiguration = NSClassFromString(@"CSJAdapterConfiguration");
    sdkConfig.additionalNetworks = @[BUAdSDKAdapterConfiguration];
    
    sdkConfig.mediatedNetworkConfigurations = networkConfig;
    
    sdkConfig.loggingLevel = MPBLogLevelInfo;
    
    sdkConfig.globalMediationSettings = @[];
    
    [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:^{
        NSLog(@"Mopub initializeSdk");
    }];
}

@end
