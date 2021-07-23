//
//  AppDelegate.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "AppDelegate.h"
#import <MoPubSDK/MoPub.h>

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
    MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization:@""];
    
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
