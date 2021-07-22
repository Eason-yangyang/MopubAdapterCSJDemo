//
//  ViewController.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "ViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import <MoPubSDK/MoPub.h>
#import "CSJAdapterConfiguration.h"

#import "CSJBannerViewControllerViewController.h"
#import "CSJInterstitialViewController.h"
#import "CSJRewardViewController.h"
#import "CSJNativeViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sdk;
@property (weak, nonatomic) IBOutlet UILabel *mopub;
@property (weak, nonatomic) IBOutlet UILabel *csjadapter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sdk.text = [BUAdSDKManager SDKVersion];
    _mopub.text = [[MoPub sharedInstance] version];
    _csjadapter.text = [CSJAdapterConfiguration new].adapterVersion;
    
    // Do any additional setup after loading the view.
}
- (IBAction)bannerAction:(UIButton *)sender {
    CSJBannerViewControllerViewController *vc = [[CSJBannerViewControllerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)interstitialAction:(UIButton *)sender {
    CSJInterstitialViewController *vc = [[CSJInterstitialViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)rewardAction:(UIButton *)sender {
    CSJRewardViewController *vc = [[CSJRewardViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)nativeAction:(UIButton *)sender {
    CSJNativeViewController *vc = [[CSJNativeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
