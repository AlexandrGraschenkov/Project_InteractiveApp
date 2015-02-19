//
//  ViewController.m
//  TestInteractiveApp
//
//  Created by Alexander on 19.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"

@interface UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@interface ViewController ()
{
    CGPoint startPan;
}
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UIButton *butt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.butt setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
//    [self.butt setBackgroundImage:[UIImage imageWithColor:[UIColor yellowColor]] forState:UIControlStateHighlighted];
    self.butt.layer.cornerRadius = 15.0;
    self.butt.layer.masksToBounds = YES;
//    self.butt.highlithedColor = [UIColor redColor];
}

- (IBAction)buttPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:-10 options:0 animations:^{
        sender.backgroundColor = [UIColor colorWithRed:0.542 green:1.000 blue:0.000 alpha:1.000];
        sender.center = CGPointMake(sender.center.x, sender.center.y + 150);
        sender.transform = CGAffineTransformRotate(sender.transform, M_PI / 6);
    } completion:nil];
    
    return;
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
        
        sender.backgroundColor = [UIColor colorWithRed:0.542 green:1.000 blue:0.000 alpha:1.000];
        sender.center = CGPointMake(sender.center.x, sender.center.y + 150);
        sender.transform = CGAffineTransformRotate(sender.transform, M_PI / 6);
        
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleSecondPan:(UIPanGestureRecognizer *)pan {
    CGPoint destPoint = [pan locationInView:self.view];
    CGPoint center = self.imgView.center;
    
    float dx = destPoint.x - center.x;
    float dy = destPoint.y - center.y;
    float angle = atan2f(dy, dx) - M_PI_2;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.imgView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);
    } completion:nil];
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        startPan = [pan locationInView:pan.view];
        NSLog(@"%@", @"123412");
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [pan locationInView:pan.view];
        CGFloat x = point.x - startPan.x + pan.view.center.x;
        CGFloat y = point.y - startPan.y + pan.view.center.y;
        pan.view.center = CGPointMake(x, y);
        NSLog(@"%@", NSStringFromCGPoint(point));
    }
}

@end
