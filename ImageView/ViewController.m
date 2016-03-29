//
//  ViewController.m
//  ImageView
//
//  Created by xiaoyu on 16/3/28.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    CGPoint center_Old;
}
@property (nonatomic, strong) UIImageView *img_View;

@property (nonatomic, strong) UIImageView *View1;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _img_View = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 150, self.view.frame.size.height - 200)];
    _img_View.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    _img_View.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_img_View];
    _img_View.userInteractionEnabled = YES;
    center_Old = _img_View.center;
    
//    _View1 = [[UIImageView alloc] initWithFrame:CGRectMake(300, 0, 150, 300)];
//    _View1.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:_View1];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 20, 100, 20);
    [button setTitle:@"1232312" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hello) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [_img_View addGestureRecognizer:
     [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    CGPoint center = recognizer.view.center;
//    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
//    CGFloat hei = recognizer.view.frame.size.height / 2;
    CGPoint translation = [recognizer translationInView:self.view];//该方法返回在横坐标上、纵坐标上拖动了多少像素
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    
    recognizer.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    
    CGPoint newCenter = recognizer.view.center;
    CGFloat newX = newCenter.x;
    CGFloat wid = self.view.frame.size.width/2;

    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGFloat angle = M_PI_4/2*(wid-newX)/wid;
        
        //判断x位置变化
            CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
        
            _img_View.transform = transform;
        
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (fabs(wid-newX) > 100) {
            [UIView animateWithDuration:0.6 animations:^{
                if (newX < wid) {
                    recognizer.view.center = CGPointMake(newCenter.x-wid*2, newCenter.y);
                }else{
                    recognizer.view.center = CGPointMake(newCenter.x+wid*2, newCenter.y);
                }
            }];
            
            
        }else{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                CGAffineTransform transform = CGAffineTransformMakeRotation(0);
                
                _img_View.transform = transform;
                
                _img_View.center = center_Old;
                
            } completion:^(BOOL finished) {
                
            }];
        }
        
        
        #if 0
        //计算速度向量的长度，当他小于200时，滑行会很短
        CGPoint velocity = [recognizer velocityInView:self.view];//拖动速度
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866
        
        //基于速度和速度因素计算一个终点
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor),center.y + (velocity.y * slideFactor));
        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
        finalPoint.x = MIN(MAX(finalPoint.x, cornerRadius),self.view.bounds.size.width - cornerRadius);
        finalPoint.y = MIN(MAX(finalPoint.y, hei),self.view.bounds.size.height - hei);
        
        //使用 UIView 动画使 view 滑行到终点
        [UIView animateWithDuration:slideFactor
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             recognizer.view.center = finalPoint;
                         }
                         completion:nil];
#endif
    }
    

}
- (void)hello{
    
//    [UIView animateWithDuration:2
//                          delay:0
//                        options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         _img_View.center = [_View1 convertPoint:_View1.center fromView:_View1.superview];
//                         CGAffineTransform transform = CGAffineTransformMakeTranslation(100.f, 20);
//                         transform = CGAffineTransformRotate(transform, M_PI_4);
//                         transform = CGAffineTransformTranslate(transform, -100, -200);
//                         _img_View.transform = transform;
//                     }
//                     completion:nil];
    [UIView animateWithDuration:0.5 animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        
        _img_View.transform = transform;
        
        _img_View.center = center_Old;
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
