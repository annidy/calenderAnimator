//
//  ViewController.m
//  calenderAnimator
//
//  Created by annidyfeng on 15/12/8.
//  Copyright © 2015年 annidyfeng. All rights reserved.
//

#import "ViewController.h"
#import "CalenderAnimationController.h"
#include <stdlib.h>
#define RND_COLOR ((double)arc4random() / RAND_MAX)

@interface ViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property CalenderAnimationController *animationController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat r = RND_COLOR;
    CGFloat g = RND_COLOR;
    CGFloat b = RND_COLOR;
    self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    
    self.title = [NSString stringWithFormat:@"#%0X%0X%0X", (int)(r*255), (int)(g*255), (int)(b*255)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CatInBin"]];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    self.animationController = [[CalenderAnimationController alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
    NSUInteger count = self.navigationController.viewControllers.count;
    if (count > 1) {
        self.navigationController.navigationBar.tintColor = self.navigationController.viewControllers[count - 2].view.backgroundColor;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}


- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    self.animationController.reverse = (operation == UINavigationControllerOperationPop);
    return self.animationController;
}
@end
