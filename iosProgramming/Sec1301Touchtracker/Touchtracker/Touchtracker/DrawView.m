//
//  DrawView.m
//  TouchTracker
//
//  Created by brook on 2020/9/30.
//

#import "DrawView.h"
#include "Line.h"
@interface DrawView()<UIGestureRecognizerDelegate>
//正在绘制的线条和完成绘制的线条
@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishLine;
@property (nonatomic, weak) Line *selectLine;


@end

@implementation DrawView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.finishLine = [[NSMutableArray alloc] init];
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled =YES;
        //增加两次点击按下手势
        UITapGestureRecognizer *doubleTapRecgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecgnizer.numberOfTapsRequired = 2;
        //避免向UIView发送touchbegin event 消息
        doubleTapRecgnizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecgnizer];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecgnizer];
        [self addGestureRecognizer:tapRecognizer];
        //长按选中线条
        [self addGestureRecognizer:tapRecognizer];
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        //拖动
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        //可以允许多个手势接收UITocuh对象
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
    }
    return self;
}
#pragma mark --delegate
//当某个UIGestureRecognizer识别出某个对象之后，发现其他的对象也识别出了特定的手势，就会向代理发送消息
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if(gestureRecognizer == self.moveRecognizer)
        return YES;
    return NO;
}
#pragma mark --action
- (void)moveLine:(UIPanGestureRecognizer *)gr
{
    if(!self.selectLine){
        return;
    }
    //如果UIPanGestureRecognizer处于变化后的状态
    if(gr.state == UIGestureRecognizerStateChanged){
        //获取手指的移动距离
        CGPoint translation = [gr translationInView:self];
        //将拖移距离加至选中线条的起点和终点
        CGPoint begin = self.selectLine.begin;
        CGPoint end = self.selectLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;

        self.selectLine.begin = begin;
        self.selectLine.end = end;
        
        [self setNeedsDisplay];
        //距离位置变化,当前位置设置为起始位置
        [gr setTranslation:CGPointZero inView:self];
    }
}
- (void)longPress:(UIGestureRecognizer *)gr
{
    if(gr.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gr locationInView:self];
        self.selectLine = [self lineAtPoint:point];
        if(self.selectLine){
            [self.linesInProgress removeAllObjects];
        }else if(gr.state == UIGestureRecognizerStateEnded){
            self.selectLine = nil;
        }
    }
    [self setNeedsDisplay];
}
- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    [self.linesInProgress removeAllObjects];
    [self.finishLine removeAllObjects];
    [self setNeedsDisplay];
}
- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized tap");
    //UIGestureRecognizer有Location方法。返回手势发生时的位置
    CGPoint point = [gr locationInView:self];
    self.selectLine = [self lineAtPoint:point];
    if(self.selectLine){
        //使视图成为UIMenuItem动作消息的目标
        [self becomeFirstResponder];
        //获取UIMenuCotroller对象
        UIMenuController *menu = [UIMenuController sharedMenuController];
        //创建一个标题为"delete"的uimenuitem对象
        UIMenuItem *deletItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deletItem];
        //先为UIMenuController对象设置显示区域，然后设置为可见
        [menu showMenuFromView:self rect:CGRectMake(point.x, point.y, 2, 2)];
    }else{
        [[UIMenuController sharedMenuController] hideMenuFromView:self];
    }
    
    [self setNeedsDisplay];
}
//选取最近的Line对象
- (Line *)lineAtPoint:(CGPoint)p
{
    //找出离p最近的Line对象
    for(Line *l in self.finishLine){
        CGPoint start = l.begin;
        CGPoint end = l.end;
        //检查线条的若干点
        for(float t =0.0;t<=1.0;t+=0.05){
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            if(hypot(x - p.x, y -p.y) <20.0)
            {
                return l;
            }
        }
    }
    return nil;
}
//自定义第一相应对象必须覆盖该方法
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)deleteLine:(id)sender
{
    [self.finishLine removeObject:self.selectLine];
    [self setNeedsDisplay];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
#pragma mark --touch

- (void)strokeLine:(Line *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}
- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    for(Line *line in self.finishLine){
        [self strokeLine:line];
    }
    [[UIColor redColor] set];
    for(NSValue *key in self.linesInProgress){
        [self strokeLine:self.linesInProgress[key]];
    }
    //选中的线条用绿色绘制
    if(self.selectLine){
        [[UIColor greenColor] set];
        [self strokeLine:self.selectLine];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //查看触摸事件发生的顺序
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        //根据触摸点位置创建Line对象
        CGPoint location = [t locationInView:self];
        Line *line = [[Line alloc] init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }

    [self setNeedsDisplay];
    
}
- (int)numberOFLines
{
    int count = 0;
    if(self.linesInProgress && self.finishLine)
        count = [self.linesInProgress count] + [self.finishLine count];
    return count;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = _linesInProgress[key];
        [self.finishLine addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

//系统终端应用，触摸事件就会被取消，应该将事件恢复到触摸之前的状态
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        NSValue *value = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:value];
    }
    [self setNeedsDisplay];
}
@end
