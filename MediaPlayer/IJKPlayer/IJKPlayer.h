//
//  IJKPlayer.h
//  MediaPlayer
//
//  Created by FRAJ on 2019/7/10.
//  Copyright © 2019 FRAJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "Masonry.h"

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

/**
 * 屏幕适配--iPhoneX全系
 */
#define iPhoneX ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

@protocol fullScreenDelegate <NSObject>

-(void)btnFullScreenDidClick:(UIButton *)sender;

@end

@protocol backDelegate <NSObject>

-(void)btnBackClick:(UIButton *)sender;

@end

@interface IJKPlayer : UIView
@property (nonatomic,copy)NSString * url;
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (nonatomic,strong)id<fullScreenDelegate> fullScreenDelegate;
@property (nonatomic,strong)id<backDelegate> backDelegate;

@property (nonatomic,strong)UIView * cover;


-(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate url:(NSString *)url;

@end
