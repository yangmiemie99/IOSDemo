//
//  BNRHyypnosisView.m
//  HypnosisView
//
//  Created by brook on 2020/9/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BNRHyypnosisView.h"

@implementation BNRHyypnosisView

- (void) drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    //根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width  /2.f;
    center.y = bounds.origin.y + bounds.size.height  /2.f;
    
//    float radius = (MIN(bounds.size.width, bounds.size.height)/2.f);
    
    //和最外层视图形成的外接圆,斜边长的一半
    float radius = hypotf(bounds.size.width, bounds.size.height) / 2.f;
    UIBezierPath* path = [[UIBezierPath alloc] init];
    //构建路径,默认不抬笔
//    [path addArcWithCenter:center radius:radius startAngle:0.f endAngle:M_PI * 2 clockwise:YES];
    for(float currentRadius = radius;currentRadius > 0;currentRadius-=20){
        //每次进入循环抬笔到指定位置画图
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }
    //设置线宽度为10
    [path setLineWidth:10.f];
    
    //设置线的颜色为灰色
    [[UIColor lightGrayColor] setStroke];
    //画图
    [path stroke];
    
    // 绘制三角
    UIBezierPath *trianglePath = [[UIBezierPath alloc]init];
    CGPoint p0 = CGPointMake(center.x - 100, center.y + 100);
    CGPoint p1 = CGPointMake(center.x + 100, center.y + 100);
    CGPoint p2 = CGPointMake(center.x, center.y - 100);
    [trianglePath moveToPoint:p0];
    [trianglePath addLineToPoint:p1];
    [trianglePath addLineToPoint:p2];
    [trianglePath closePath];
//    [trianglePath addLineToPoint:p0];
    [trianglePath stroke];
    // 绘制三角形的阴影
    //获取三角形渐变
    //图像上下文，负责存储绘画状态（画笔颜色和线条粗细）和绘制内容所处的空间
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //保存当前图像上下文
    CGContextSaveGState(currentContext);
    //剪切路径
    [trianglePath addClip];
    CGFloat locations[2] = {0.0,1.0};
    //RCG和一个有效位
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0,1.0};
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    //渐变的起始和终止位置
    CGPoint startPoint = CGPointMake(center.x, center.y - 100);
    CGPoint endPoint = CGPointMake(center.x, center.y + 100);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    //恢复之前保存的图像上下文
    CGContextRestoreGState(currentContext);
    
    //添加图片，让图片拥有阴影
    currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3); // 设置阴影
    UIImage* logoIamge = [UIImage imageNamed:@"haizwang.jpg"];
    [logoIamge drawInRect:CGRectMake(center.x - 25, center.y - 15 ,50,30)];
    CGContextRestoreGState(currentContext);

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor= [UIColor clearColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
