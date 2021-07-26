//
//  CSJNativeViewController.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "CSJNativeViewController.h"
#import <MoPubSDK/MoPub.h>
#import "CSJNativeAdView.h"
#import "CSJNativeAdRenderer.h"

@interface CSJNativeViewController ()<MPNativeAdDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *styleSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *nativeSeg;

@property (nonatomic, strong) MPNativeAdRequest *adReq;
@property (nonatomic, strong) MPNativeAd *nativeAd;

@end

@implementation CSJNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loadadAction:(UIButton *)sender {
    self.nativeAd = nil;
    BOOL video = self.styleSeg.selectedSegmentIndex == 1;
    switch (self.nativeSeg.selectedSegmentIndex) {
        case 0:
            [self setAdReqWithSlotId:@"5a053876f41648309014419fd2f6bc8e" video:video];
            break;
        case 1:
            [self setAdReqWithSlotId:@"efb1334ac62e49f39e5d1fe8bdb6129d" video:video];
            break;
        default:
            break;
    }
    [self.adReq startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            self.nativeAd = response;
            self.nativeAd.delegate = self;
            [self showNativeAds];
        }
    }];
}

- (void)showNativeAds {
    // show native Ad
    if (self.nativeAd) {
        MPNativeView *view = (MPNativeView *)[self.nativeAd retrieveAdViewWithError:nil];
        CGFloat height = 400;
        view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),height);
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
        
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-60];
        NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *w = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0 constant:view.frame.size.width];
        NSLayoutConstraint *h = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0 constant:view.frame.size.height];
        [self.view addConstraint:bottom];
        [self.view addConstraint:center];
        [self.view addConstraint:w];
        [self.view addConstraint:h];
    }
}

- (void)setAdReqWithSlotId:(NSString *)slotId video:(BOOL)video {
    MPStaticNativeAdRendererSettings *settings = [[MPStaticNativeAdRendererSettings alloc] init];
    settings.renderingViewClass = [CSJNativeAdView class];
    settings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(maximumWidth,300);
    };

    MPNativeAdRendererConfiguration *config = [CSJNativeAdRenderer rendererConfigurationWithRendererSettings:settings];

    // targeting
    MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
    
    targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdCTATextKey, kAdIconImageKey, kAdMainImageKey, kAdStarRatingKey, video?kVASTVideoKey:nil, nil];
    
    // init adReq
    _adReq = [MPNativeAdRequest requestWithAdUnitIdentifier:slotId rendererConfigurations:@[config]];
    _adReq.targeting = targeting;
}

#pragma mark - MPNativeAdDelegate
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

#pragma mark - MPNativeViewDelegate
- (void)nativeViewWillMoveToSuperview:(UIView *)superview {
    
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
