//
//  CSJBannerViewControllerViewController.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "CSJBannerViewControllerViewController.h"
#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDK/MoPub.h>)
    #import <MoPubSDK/MoPub.h>
#else
    #import "MoPub.h"
#endif

@interface CSJBannerViewControllerViewController ()<MPAdViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *bannerSeg;
@property (nonatomic) MPAdView *adView;

@end

@implementation CSJBannerViewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)loadBannerViewSlotId:(NSString *)slotId size:(CGSize)inputSize {

    [self.view endEditing:YES];
    [self.adView removeFromSuperview];
    self.adView = [[MPAdView alloc] initWithAdUnitId:slotId];
    self.adView.delegate = self;
    self.adView.frame = CGRectMake(0, 0, inputSize.width, inputSize.height);
    self.adView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.adView loadAd];
}

- (IBAction)loadAdAction:(UIButton *)sender {
    switch (self.bannerSeg.selectedSegmentIndex) {
        case 0:
            [self loadBannerViewSlotId:@"5bf96fc264934e838ac8fe8150c01b8f" size:CGSizeMake(320, 50)];
            break;
        case 1:
            [self loadBannerViewSlotId:@"314b6ed129e24c17b1d4b428c59f2462" size:CGSizeMake(300, 250)];
            break;
        case 2:
            [self loadBannerViewSlotId:@"ea985ac82edf44e2bb77204fb482c1f2" size:CGSizeMake(320, 50)];
            break;
        case 3:
            [self loadBannerViewSlotId:@"db2b712ab2b2411093811af81de4e6e8" size:CGSizeMake(300, 250)];
            break;
        default:
            break;
    }
}

#pragma mark MPAdViewDelegate
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view adSize:(CGSize)adSize {
    [self.view addSubview:self.adView];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-60];
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *w = [NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0 constant:self.adView.frame.size.width];
    NSLayoutConstraint *h = [NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0 constant:self.adView.frame.size.height];
    [self.view addConstraint:bottom];
    [self.view addConstraint:center];
    [self.view addConstraint:w];
    [self.view addConstraint:h];
}

- (void)adView:(MPAdView *)view didFailToLoadAdWithError:(NSError *)error {
    
}

- (void)willPresentModalViewForAd:(MPAdView *)view {
    
}

-(void)didDismissModalViewForAd:(MPAdView *)view {
    
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
