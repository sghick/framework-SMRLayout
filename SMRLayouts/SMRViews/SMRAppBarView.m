//
//  SMRAppBarView.m
//  SMRLayoutsDemo
//
//  Created by Tinswin on 2020/12/27.
//

#import "SMRAppBarView.h"
#import "SMRLayout.h"

@implementation SMRAppBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in self.actions) {
        [self addSubview:view];
    }
    for (UIView *view in self.leadings) {
        [self addSubview:view];
    }
    if (self.titleView) {
        [self addSubview:self.titleView];
    }
    
    SMRLayout *layout =
    Box(^(SMRBox * _Nonnull set) {
        set.view = self;
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = @[
                Box(^(SMRBox * _Nonnull set) {
                    set.height = StatusBarHeight();
                }),
                Row(^(SMRRow * _Nonnull set) {
                    set.children = @[
                        Row(^(SMRRow * _Nonnull set) {
                            set.crossAlign = SMRCrossAlignCenter;
                            set.children = self.leadings.viewBoxes;
                        }),
                        Box(^(SMRBox * _Nonnull set) {
                            set.align = SMRAlignCenter;
                            set.child = self.titleView.viewBox;
                        }),
                        Row(^(SMRRow * _Nonnull set) {
                            set.mainAlign = SMRMainAlignEnd;
                            set.crossAlign = SMRCrossAlignCenter;
                            set.children = self.actions.viewBoxes.reverseObjectEnumerator.allObjects;
                        }),
                    ];
                }),
            ];
        });
    });
    [layout setState];
}

#pragma mark - Getters

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

@end

@implementation SMRNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        self.titleView = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if ([self.titleView isKindOfClass:UILabel.class]) {
        ((UILabel *)self.titleView).text = title;
    }
}

#pragma mark - Getters



@end