//
//  SoundWavesView.h
//  SoundWaves
//
//  Created by mfhj-dz-001-059 on 2021/4/29.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SoundWavesLevel) {
    /// 静音
    SoundWavesLevelMute = 0,
    /// 默认状态
    SoundWavesLevelNormal = 1,
    /// 弱
    SoundWavesLevelWeak = 2,
    /// 中
    SoundWavesLevelMedium = 3,
    /// 强
    SoundWavesLevelStrong = 4,
};

@interface SoundWavesView : UIView

/// 声波浮动等级
@property(assign, nonatomic) SoundWavesLevel level;

@end

NS_ASSUME_NONNULL_END
