//
//  DLSegmentView.m
//
//  Created by ice on 15/10/28.
// 
//

#import "DLSegmentView.h"

@interface DLSegmentView ()

@property (nonatomic,strong) UIScrollView *scrollerView;
@property (nonatomic,strong) UIImageView  *sliderImageView;
@property (nonatomic,assign) BOOL         allowAnimation;
@property (nonatomic,strong) DLSegmentViewHandle handle;

@end

@implementation DLSegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollerView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.bounces = NO;
        [self addSubview:_scrollerView];
        
        _sliderImageView = [[UIImageView alloc] init];
        _sliderImageView.userInteractionEnabled = YES;
        [_scrollerView addSubview:_sliderImageView];
        
        _lastSelectIndex = 0;
        _allowAnimation  = NO;
    }
    return self;
}

- (void)showSubView:(NSArray *)subTitleArray
          titleFont:(CGFloat)fontSize
   titleNormalColor:(UIColor *)normalColor
   titleSelectColor:(UIColor *)selectColor
              width:(CGFloat)width
          offsetDis:(CGFloat)dis
     animationImage:(UIImage *)animationImage
        selectIndex:(NSInteger)selectIndex
             handle:(DLSegmentViewHandle)handle{
    
    NSInteger count = subTitleArray.count;
    if (selectIndex >= count) {
        selectIndex = 0;
    }
    
    if (handle) {
        self.handle = handle;
    }
    
    UIButton *selectButton = nil;
    if (subTitleArray && count > 0) {
        for (int i = 0; i < subTitleArray.count; i++) {
            CGFloat height = self.frame.size.height;
            CGFloat offsetX = i * (width + dis);
            
            NSString *title = [subTitleArray objectAtIndex:i];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, 0, width,height)];
            button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
            [button setTitleColor:normalColor forState:UIControlStateNormal];
            [button setTitleColor:selectColor forState:UIControlStateSelected];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = 100 + i;
          
            if (i == selectIndex) {
                selectButton = button;
                [self buttonSelectAction:button];
            }
            
            [button addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollerView addSubview:button];
        }
        
        _scrollerView.contentSize = CGSizeMake(width * count + dis * (count - 1), _scrollerView.frame.size.height);
        _sliderImageView.image = animationImage;
        _sliderImageView.frame = CGRectMake(0, 0, width, self.frame.size.height);
        
        if (selectButton) {
            _sliderImageView.center = selectButton.center;
        }
    }
}

- (void)selectButtonWithIndex:(NSInteger)index{
    UIButton *button = (UIButton *)[_scrollerView viewWithTag:index + 100];
    [self buttonSelectAction:button];
}

- (void)buttonSelectAction:(UIButton *)button{
    
    [button setSelected:YES];
    
    if (_lastSelectIndex != button.tag - 100) {
        UIButton *lastButton = (UIButton *)[_scrollerView viewWithTag:_lastSelectIndex + 100];
        [lastButton setSelected:NO];
    }
    
    _lastSelectIndex = button.tag - 100;
    
    if (_allowAnimation) {
        [self selectAnimation:button.center];
    }
    
    _allowAnimation = YES;
    
    if (self.handle) {
        self.handle(button.tag - 100);
    }
}

- (void)selectAnimation:(CGPoint)point{
    [UIView animateWithDuration:0.2 animations:^{
        _sliderImageView.center = point;
    }];
}

@end
