//
//  DLSegmentView.h
//
//  Created by ice on 15/10/28.
// 
//

#import <UIKit/UIKit.h>

typedef void (^DLSegmentViewHandle)(NSInteger selectIndex);

@interface DLSegmentView : UIView
@property (nonatomic,assign) NSInteger    lastSelectIndex;

- (void)showSubView:(NSArray *)subTitleArray
          titleFont:(CGFloat)fontSize
   titleNormalColor:(UIColor *)normalColor
   titleSelectColor:(UIColor *)selectColor
              width:(CGFloat)width
          offsetDis:(CGFloat)dis
     animationImage:(UIImage *)animationImage
        selectIndex:(NSInteger)selectIndex
             handle:(DLSegmentViewHandle)handle;
/**
 *  按钮选中
 *
 *  @param index 按钮的索引
 */
- (void)selectButtonWithIndex:(NSInteger)index;
@end
