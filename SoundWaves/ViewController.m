//
//  ViewController.m
//  SoundWaves
//
//  Created by mfhj-dz-001-059 on 2021/4/29.
//

#import "ViewController.h"
#import "SoundWavesView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property(strong, nonatomic) NSArray<UIButton *> *buttons;
@property(strong, nonatomic) SoundWavesView *soundWavesView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.soundWavesView = [[SoundWavesView alloc] init];
    self.soundWavesView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.soundWavesView];
    [self.soundWavesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
        make.height.equalTo(@100);
    }];
    
    UIButton *muteButton = [self createButtonWithTitle:@"静音"];
    muteButton.tag = 10000;
    muteButton.selected = true;
    UIButton *normalButton = [self createButtonWithTitle:@"普通"];
    normalButton.tag = 10001;
    UIButton *weakButton = [self createButtonWithTitle:@"弱强度"];
    weakButton.tag = 10002;
    UIButton *mediumButton = [self createButtonWithTitle:@"中强度"];
    mediumButton.tag = 10003;
    UIButton *strongButton = [self createButtonWithTitle:@"高强度"];
    strongButton.tag = 10004;
    self.buttons = @[muteButton, normalButton, weakButton, mediumButton, strongButton];
    [self.buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [self.buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.soundWavesView.mas_bottom).offset(30);
        make.height.equalTo(@40);
    }];
}

- (void)changeSoundWavesLevel:(UIButton *)sender {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = false;
    }];
    sender.selected = true;
    self.soundWavesView.level = sender.tag - 10000;
}

- (UIButton *)createButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] forState:UIControlStateHighlighted];
    [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] forState:UIControlStateHighlighted | UIControlStateSelected];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(changeSoundWavesLevel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}


@end
