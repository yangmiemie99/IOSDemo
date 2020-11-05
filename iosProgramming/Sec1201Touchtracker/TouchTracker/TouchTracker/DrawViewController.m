//
//  DrawViewController.m
//  TouchTracker
//
//  Created by brook on 2020/9/30.
//

#import "DrawViewController.h"
#import "DrawView.h"
@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {                       
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view = [[DrawView alloc] initWithFrame:CGRectZero];
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
