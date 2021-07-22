//
//  ViewController.m
//  MopubAdapterDemo
//
//  Created by Eason on 2021/7/22.
//

#import "ViewController.h"
#import "CSJViewController.h"
#import "PangleViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sdk;
@property (weak, nonatomic) IBOutlet UILabel *mopub;
@property (weak, nonatomic) IBOutlet UILabel *pangleadapter;
@property (weak, nonatomic) IBOutlet UILabel *csjadapter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (IBAction)PangleAction:(UIButton *)sender {
    PangleViewController *vc = [[PangleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)CSJAction:(UIButton *)sender {
    CSJViewController *vc = [[CSJViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
