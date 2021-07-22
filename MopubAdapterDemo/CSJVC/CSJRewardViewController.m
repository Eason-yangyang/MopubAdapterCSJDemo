//
//  CSJRewardViewController.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "CSJRewardViewController.h"
#import <MoPubSDK/MoPub.h>

@interface CSJRewardViewController ()<MPRewardedAdsDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *rewardSeg;

@end

@implementation CSJRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loadadAction:(UIButton *)sender {
    switch (self.rewardSeg.selectedSegmentIndex) {
        case 0:
            [self setUpRewardVideoWithSlotId:@"123"];
            break;
        case 1:
            [self setUpRewardVideoWithSlotId:@"123"];
            break;
        default:
            break;
    }
}

- (void)setUpRewardVideoWithSlotId:(NSString *)slotId {
    [MPRewardedAds setDelegate:self forAdUnitId:slotId];
    [MPRewardedAds loadRewardedAdWithAdUnitID:slotId keywords:nil userDataKeywords:nil customerId:nil mediationSettings:nil localExtras:nil];
}

/**
 This method is called after an ad loads successfully.

 @param adUnitID The ad unit ID of the ad associated with the event.
 */
- (void)rewardedAdDidLoadForAdUnitID:(NSString *)adUnitID {
    [MPRewardedAds presentRewardedAdForAdUnitID:adUnitID fromViewController:self withReward:nil];
}

/**
 This method is called after an ad fails to load.

 @param adUnitID The ad unit ID of the ad associated with the event.
 @param error An error indicating why the ad failed to load.
 */
- (void)rewardedAdDidFailToLoadForAdUnitID:(NSString *)adUnitID error:(NSError *)error {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
