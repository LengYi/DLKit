// 多语言
#define _(s) NSLocalizedString((s),@"")

// block 弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

// 提供RGB模式的UIColor定义.
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 屏幕尺寸
#define KSCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define KSCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)


// 设置view圆角和边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// G/MB/KB 转换
#define GBSize(size) [NSString stringWithFormat:@"%.2f GB",size / 1024.0f / 1024.0f]
#define MBSize(size) [NSString stringWithFormat:@"%.1f MB",size / 1024.0f]
#define KBSize(size) [NSString stringWithFormat:@"%.1f KB",size / 1024.0f]
#define APPSize(size) size > 1024.0f * 1024.0f ? GBSize(size) : MBSize(size)

// 检查字符有效性
#define IsValidString(String) (String != nil && ![String isEqualToString:@""]) ? YES : NO
