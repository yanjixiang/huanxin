//
//  JohnTopTitleView.h


#import <UIKit/UIKit.h>

@protocol JohnTopTitleViewDelegate <NSObject>

@optional
- (void)didSelectedPage:(NSInteger)page;

@end

@interface JohnTopTitleView : UIView

@property (nonatomic,weak) id<JohnTopTitleViewDelegate>delegete;

//title数组
@property (nonatomic,strong) NSArray<NSString*> *titles;

//线宽（默认屏幕宽度除以标题数）
@property (nonatomic,assign) CGFloat lineWidth;

@property (nonatomic,assign,readonly) NSInteger selectedPage;

@property (nonatomic,strong) UIColor* selectedTextColor;

@property (nonatomic,strong) UIColor* textColor;

@property (nonatomic,strong) UIColor* lineColor;

@property (nonatomic,assign,readonly) CGFloat titleHeight;  //标题栏高度

@property (nonatomic,assign,readwrite) NSInteger selectedTitle;//设置默认选中的title

@property (nonatomic,assign) BOOL canScroll;
/**
 *传入父控制器和子控制器数组即可
 **/
- (void)setupViewControllerWithFatherVC:(UIViewController *)fatherVC childVC:(NSArray<UIViewController *>*)childVC;

/**
 *传入view
 **/
- (void)setupViews:(NSArray<UIView *>*)views;

@end
