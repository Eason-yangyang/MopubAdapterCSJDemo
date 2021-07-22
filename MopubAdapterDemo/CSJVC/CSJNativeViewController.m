//
//  CSJNativeViewController.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "CSJNativeViewController.h"
#import <MoPubSDK/MoPub.h>

@interface CSJNativeViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *styleSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *nativeSeg;

@end

@implementation CSJNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loadadAction:(UIButton *)sender {
    
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
