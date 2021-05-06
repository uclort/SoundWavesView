//
//  SoundWavesView.m
//  SoundWaves
//
//  Created by mfhj-dz-001-059 on 2021/4/29.
//

#import "SoundWavesView.h"
#import "SoundWavesLine.h"
#import <Masonry/Masonry.h>

@interface SoundWavesView()

@property (strong, nonatomic) NSMutableArray<SoundWavesLine *> *lineGroup;

@end

@implementation SoundWavesView

/// 线宽
const CGFloat lineWidth = 2.0;
/// 线高
const CGFloat lineHeight = 2.0;
/// 线间距
const CGFloat lineSpace = 4.0;
/// 线数量
const CGFloat lineNumber = 40.0;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeAttribute];
        [self addCustomControl];
    }
    return self;
}

- (void)initializeAttribute {
    self.lineGroup = [NSMutableArray arrayWithCapacity:lineNumber];
}

- (void)addCustomControl {
    for (int i = 0; i < lineNumber; i++) {
        SoundWavesLine *line = [[SoundWavesLine alloc] initWithLineColor:[UIColor redColor]];
        [self addSubview:line];
        [self.lineGroup addObject:line];
    }
    [self layoutLine];
    [self beginAnimation];
    
}

- (void)beginAnimation {
    NSArray *randomArray = [self sortedRandomArrayByArray:[self randomArray]];
    if (!randomArray.count) {
        [self.lineGroup enumerateObjectsUsingBlock:^(SoundWavesLine * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj stopAnimation];
        }];
        return;
    }
    [self.lineGroup enumerateObjectsUsingBlock:^(SoundWavesLine * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int index = arc4random_uniform(lineNumber);
        CGFloat random = [randomArray[index] floatValue];
        obj.toValue = random;
        obj.beginTime = index / 100.0;
        [obj beginAnimation];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self beginAnimation];
    });
}

- (void)setLevel:(SoundWavesLevel)level {
    _level = level;
    [self beginAnimation];
}

- (NSArray *)randomArray {
    NSArray *level;
    switch (self.level) {
        case SoundWavesLevelNormal: // 普通状态
            level = @[@1, @2, @3, @4];
            break;
        case SoundWavesLevelWeak: // 弱
            level = @[@5, @6, @7, @8];
            break;
        case SoundWavesLevelMedium: // 中
            level = @[@9, @10, @11, @12];
            break;
        case SoundWavesLevelStrong: // 强
            level = @[@13, @14, @15, @16];
            break;
        default:
            return @[];
            break;
    }
    NSMutableArray *randomArray = [NSMutableArray arrayWithCapacity:lineNumber];
    int index = -1;
    for (int i = 0; i < lineNumber; i++) {
        index++;
        if (index >= level.count) {
            index = 0;
        }
        CGFloat levelNumber = [level[index] floatValue];
        [randomArray addObject:@(levelNumber)];
    }
    return randomArray;
}

//对数组随机排序
- (NSArray *)sortedRandomArrayByArray:(NSArray *)array{
    NSArray *randomArray = [[NSArray alloc] init];
    randomArray = [array sortedArrayUsingComparator:^NSComparisonResult(id one, id two) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return  [one compare:two];
        } else {
            return [two compare:one];
        }
    }];
    
    return randomArray;
}

- (void)layoutLine {
    UIView *prev;
    for (NSInteger i = 0, len = self.lineGroup.count; i < len; i++) {
        UIView *v = self.lineGroup[i];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            if (prev) {
                make.width.equalTo(prev);
                make.left.equalTo(prev.mas_right).offset(lineSpace);
                if (i == len - 1) {//last one
                    make.right.equalTo(self);
                }
            }
            else {//first one
                make.width.equalTo(@(lineWidth));
                make.left.equalTo(self);
            }
            make.height.equalTo(@(lineHeight));
            make.centerY.equalTo(self);
        }];
        prev = v;
    }
}

@end
