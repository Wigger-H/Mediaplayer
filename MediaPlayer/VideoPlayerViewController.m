//
//  VideoPlayerViewController.m
//  MediaPlayer
//
//  Created by FRAJ on 2019/7/10.
//  Copyright © 2019 FRAJ. All rights reserved.
//

#import "VideoPlayerViewController.h"

#import "IJKPlayer.h"
#import "AppDelegate.h"

@interface VideoPlayerViewController ()<backDelegate,fullScreenDelegate>

@property (nonatomic, strong) IJKPlayer * playerView;
@property (nonatomic, strong) UIView *blackView;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"VideoPlayerViewContorller";
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    
    self.blackView = [UIView new];
    self.blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.blackView];
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.equalTo(@(iPhoneX?34:0));
    }];
    
    
    self.playerView = [[IJKPlayer alloc]initWithFrame: CGRectMake(0, 0, SCREEN_W, ((9*SCREEN_W)/16)) delegate:self url:self.url];
    
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blackView.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(self.playerView.mas_width).multipliedBy(9.0/16);
    }];
}

#pragma mark - 与全屏相关的代理方法等

BOOL fullScreen;

static UIButton * btnFullScreen;

//点击了全屏按钮
-(void)btnFullScreenDidClick:(UIButton *)sender{
    
    fullScreen = !fullScreen;
    
    btnFullScreen = sender;
    
    if (fullScreen) {//小屏->全屏
        [UIView animateWithDuration:0.25 animations:^{
            NSNumber * value  = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        }];
        
    }else{//全屏->小屏
        [UIView animateWithDuration:0.25 animations:^{
            NSNumber * value  = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        }];
    }
}

- (void)statusBarOrientationChange:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeRight) // home键靠右
    {
        fullScreen = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.playerView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
            self.playerView.player.view.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        }];
    }
    
    if (orientation ==UIInterfaceOrientationLandscapeLeft) // home键靠左
    {
        fullScreen = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.playerView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
            self.playerView.player.view.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        }];
    }
    if (orientation == UIInterfaceOrientationPortrait)
    {
        fullScreen = NO;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.playerView.transform= CGAffineTransformMakeRotation(0);
            self.playerView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W*(SCREEN_W/SCREEN_H)*1.3);
            self.playerView.player.view.frame = self.playerView.frame;
        }];
    }
    if (orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSLog(@"其他");
    }
}

//点击了返回按钮
-(void)btnBackClick:(UIButton *)sender{
    
    [self.playerView.player shutdown];
    self.playerView = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)dealloc{
    
    NSLog(@"+++++++++++++delloc+++++++++++");
    [self.playerView.player shutdown];
    self.playerView = nil;
    
}


@end
