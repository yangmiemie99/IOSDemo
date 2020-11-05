//
//  SceneDelegate.m
//  Sec0501Hypnosister
//
//  Created by brook on 2020/9/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "SceneDelegate.h"
#import "Hyponosister.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
//        CGRect firstFrame = self.window.bounds;
//        //视图1第一个视图
    //        Hyponosister* firstView = [[Hyponosister alloc] initWithFrame:firstFrame];
    //        [self.window addSubview:firstView];
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width = 2 * screenRect.size.width;

    //滚动view相当于一个镜头Rect代表了取景范围，myView相当于镜头下的图片
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    //创建与屏幕大小相同的myView1
    Hyponosister* myView1 = [[Hyponosister alloc] initWithFrame:screenRect];
    
    //创建与屏幕大小相同的myView2,并放在第一个view的右侧，使其正好平移出屏幕
    screenRect.origin.x += screenRect.size.width;
    Hyponosister* myView2 = [[Hyponosister alloc] initWithFrame:screenRect];
    
    //告诉scroolView的取景范围是多少，否则无法滚动
    scrollView.contentSize = bigRect.size;
    //分页切换，不停留在中间位置，uiscrollView根据bounds的大小分割成尺寸相同的多个区域，拖动结束只显示一个区域
    scrollView.pagingEnabled = YES;
    
    [scrollView addSubview:myView1];
    [scrollView addSubview:myView2];
    [self.window addSubview:scrollView];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
