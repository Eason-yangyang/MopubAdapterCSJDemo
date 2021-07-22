//
//  CSJInterstitialViewController.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "CSJInterstitialViewController.h"
#import <MoPubSDK/MoPub.h>

@interface CSJInterstitialViewController ()<MPInterstitialAdControllerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *interstitialSeg;

@property (nonatomic, strong) MPInterstitialAdController *interstitial;

@end

@implementation CSJInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loadadAction:(UIButton *)sender {
    switch (self.interstitialSeg.selectedSegmentIndex) {
        case 0:
            [self loadInterstitialWithSlotId:@"123"];
            break;
        case 1:
            [self loadInterstitialWithSlotId:@"123"];
            break;
        default:
            break;
    }
}

- (void)loadInterstitialWithSlotId:(NSString *)slotId {
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:slotId];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

#pragma mark - MPInterstitialAdControllerDelegate
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    if (self.interstitial.ready) {
        [self.interstitial showFromViewController:self];
    }
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial withError:(NSError *)error {
   
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
