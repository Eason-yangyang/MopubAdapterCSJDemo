#import <Foundation/Foundation.h>
#import <BUFoundation/BUCommonMacros.h>
#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h> 
#else
    #import <MoPubSDK/MoPub.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface CSJAdapterConfiguration :MPBaseAdapterConfiguration

// Caching
/**
 Extracts the parameters used for network SDK initialization and if all required
 parameters are present, updates the cache.
 @param parameters Ad response parameters
 */
+ (void)updateInitializationParameters:(NSDictionary *)parameters;

@property (nonatomic, copy, readonly) NSString * adapterVersion;
@property (nonatomic, copy, readonly) NSString * biddingToken;
@property (nonatomic, copy, readonly) NSString * moPubNetworkName;
@property (nonatomic, copy, readonly) NSString * networkSdkVersion;

extern NSString * const kCSJNetworkName;
extern NSString * const kCSJAppIdKey;
extern NSString * const kCSJPlacementIdKey;

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> * _Nullable)configuration
                                  complete:(void(^ _Nullable)(NSError * _Nullable))complete;


// Set optional data for rewarded ad
+ (void)setUserId:(NSString *)userId;
+ (NSString *)userId;
+ (void)setRewardName:(NSString *)rewardName;
+ (NSString *)rewardName;
+ (void)setRewardAmount:(NSInteger)rewardAmount;
+ (NSInteger)rewardAmount;
+ (void)setMediaExtra:(NSString *)extra;
+ (NSString *)mediaExtra;

+ (void)csjSDKInitWithAppId:(NSString *)appId;

@end

NS_ASSUME_NONNULL_END
