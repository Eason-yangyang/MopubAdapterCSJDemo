#import "CSJNativeCustomEvent.h"
#import "CSJNativeAdAdapter.h"
#import <BUAdSDK/BUAdSDKManager.h>
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUAdSDK.h>
#import "CSJAdapterConfiguration.h"

#if __has_include("MoPub.h")
    #import "MoPub.h"
    #import "MPNativeAd.h"
    #import "MPLogging.h"
    #import "MPNativeAdError.h"
#endif

@interface CSJNativeCustomEvent () <BUNativeAdDelegate>
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, copy) NSString *adPlacementId;
@property (nonatomic, copy) NSString *appId;
@end

@implementation CSJNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    BOOL hasAdMarkup = adMarkup.length > 0;
    
    if (info.count == 0) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                             code:BUErrorCodeAdSlotEmpty
                                         userInfo:@{NSLocalizedDescriptionKey:
                                                        @"Incorrect or missing CSJ App ID or Placement ID on the network UI. Ensure the App ID and Placement ID is correct on the MoPub dashboard."}];
        MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError: error];
        return;
    }
    
    NSString *appId = [info objectForKey:kCSJAppIdKey];
    self.appId = appId;
    if (appId && [appId isKindOfClass:[NSString class]] && appId.length > 0) {
        [CSJAdapterConfiguration csjSDKInitWithAppId:self.appId];
        [CSJAdapterConfiguration updateInitializationParameters:info];
    }
    
    NSString *adPlacementId = [info objectForKey:kCSJPlacementIdKey];
    self.adPlacementId = adPlacementId;
    if (!(adPlacementId && [adPlacementId isKindOfClass:[NSString class]] && adPlacementId.length > 0)) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                             code:BUErrorCodeAdSlotEmpty
                                         userInfo:@{NSLocalizedDescriptionKey: @"Incorrect or missing CSJ placement ID. Failing ad request. Ensure the ad placement ID is correct on the MoPub dashboard."}];
        MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.AdType = BUAdSlotAdTypeFeed;
    slot.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    self.nativeAd = [[BUNativeAd alloc] initWithSlot:slot];
    self.nativeAd.delegate = self;
    
    self.nativeAd.adslot.ID = self.adPlacementId;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    
    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }
    self.nativeAd.rootViewController = rootViewController;
    
    MPLogAdEvent([MPLogEvent adLoadAttemptForAdapter:NSStringFromClass(self.class) dspCreativeId:nil dspName:nil], [self getAdNetworkId]);
    
    if (hasAdMarkup) {
        MPLogInfo(@"Loading CSJ native ad markup for Advanced Bidding");

        [self.nativeAd setMopubAdMarkUp:adMarkup];
    } else {
        MPLogInfo(@"Loading CSJ native ad");

        [self.nativeAd loadAdData];
    }
}

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info {
    [self.nativeAd loadAdData];
}

#pragma mark - BUNativeAdDelegate

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    
    CSJNativeAdAdapter *adapter = [[CSJNativeAdAdapter alloc] initWithBUNativeAd:nativeAd placementId:self.adPlacementId];
    MPNativeAd *mp_nativeAd = [[MPNativeAd alloc] initWithAdAdapter:adapter];
    [self.delegate nativeCustomEvent:self didLoadAd:mp_nativeAd];
}

- (NSString *) getAdNetworkId {
    NSString *adPlacementId = self.adPlacementId;
    return (adPlacementId && [adPlacementId isKindOfClass:[NSString class]]) ? adPlacementId : @"";
}

@end
