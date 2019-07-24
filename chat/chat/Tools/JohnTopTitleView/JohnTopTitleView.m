//
//  JohnTopTitleView.m

#import "JohnTopTitleView.h"

#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height

@interface JohnTopTitleView ()<UIScrollViewDelegate>{
    //CGFloat _titleHeight;  //标题高度
    CGFloat _lineViewWidth;  //记录底部线长度
    NSInteger _titleCount;  //title个数
}

@property (nonatomic,strong) UISegmentedControl *titleSegment;

@property (nonatomic,strong) UIScrollView *pageScrollView;

@property (nonatomic,strong) UIView *lineView;

@end
@implementation JohnTopTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _textColor = [UIColor grayColor];
        _selectedTextColor = [UIColor blueColor];
        _lineColor = [UIColor blueColor];
        [self setting];
        
    }
    return self;
}

#pragma mark - 初始化设置
- (void)setting{
    self.backgroundColor = [UIColor whiteColor];
    //title
    _titleHeight = 50.f;
    self.titleSegment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ViewWidth,_titleHeight)];
    self.titleSegment.tintColor = [UIColor clearColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                             NSForegroundColorAttributeName: _selectedTextColor};
    [self.titleSegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                               NSForegroundColorAttributeName: _textColor};
    [self.titleSegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [self.titleSegment addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.titleSegment];
    
    //滑动sc
    self.pageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleSegment.frame), ViewWidth, ViewHeight - _titleHeight)];
    self.pageScrollView.bounces = NO;
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.showsVerticalScrollIndicator = NO;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.pageScrollView.delegate = self;
    [self addSubview:self.pageScrollView];
    
    //底部线
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = _lineColor;
    [self addSubview:self.lineView];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleHeight-1.0, self.width, 1.0)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:lineView];
}

#pragma mark - set
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                               NSForegroundColorAttributeName: _textColor};
    [self.titleSegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor{
    _selectedTextColor = selectedTextColor;
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                             NSForegroundColorAttributeName: _selectedTextColor};
    [self.titleSegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _lineView.backgroundColor = lineColor;
}

- (void)setTitles:(NSArray *)titles{
    if (titles.count > 0) {
        NSInteger page = titles.count;
        if (_lineViewWidth == 0 ||
            _lineViewWidth > ViewWidth/page) {  //限制线长度范围
            _lineViewWidth = ViewWidth / page;
        }
        self.lineView.frame = CGRectMake(0,0,_lineViewWidth, 2);
        self.lineView.center = CGPointMake(ViewWidth / page / 2, _titleHeight);
        
        for (NSInteger i = 0; i < titles.count; i ++) {
            [self.titleSegment insertSegmentWithTitle:[titles objectAtIndex:i] atIndex:i animated:NO];
        }
    }
    self.titleSegment.selectedSegmentIndex = 0;
    _titleCount = titles.count;
}

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineViewWidth = lineWidth;
}

- (void)setCanScroll:(BOOL)canScroll{
    self.pageScrollView.scrollEnabled = canScroll;
}

- (void)setSelectedTitle:(NSInteger)selectedTitle{
    if (selectedTitle < _titleCount ) {
        self.titleSegment.selectedSegmentIndex = selectedTitle;
        [self.pageScrollView setContentOffset:CGPointMake(ViewWidth *self.titleSegment.selectedSegmentIndex,0) animated:NO];
        [self changeWithPage:self.titleSegment.selectedSegmentIndex];
    }
}

#pragma mark - 定制VC
- (void)setupViewControllerWithFatherVC:(UIViewController *)fatherVC childVC:(NSArray<UIViewController *>*)childVC{
    self.pageScrollView.contentSize = CGSizeMake(ViewWidth * childVC.count, 0);
    
    for (NSInteger i = 0; i < childVC.count; i ++) {
        UIViewController *vc = [childVC objectAtIndex:i];
        vc.view.frame = CGRectMake(ViewWidth * i, 0, ViewWidth, ViewHeight - _titleHeight);
        [fatherVC addChildViewController:vc];
        [self.pageScrollView addSubview:vc.view];
    }
}

- (void)setupViews:(NSArray<UIView *> *)views{
    self.pageScrollView.contentSize = CGSizeMake(ViewWidth * views.count, 0);
    
    for (NSInteger i = 0; i < views.count; i ++) {
        UIView *view = [views objectAtIndex:i];
        view.frame = CGRectMake(ViewWidth * i, 0, ViewWidth, ViewHeight - _titleHeight);
        [self.pageScrollView addSubview:view];
    }
    
}

#pragma mark - 联动设置
- (void)pageChange:(UISegmentedControl *)seg{
    [self changeWithPage:seg.selectedSegmentIndex];
    [self.pageScrollView setContentOffset:CGPointMake(ViewWidth *seg.selectedSegmentIndex,0) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / ViewWidth;
    self.titleSegment.selectedSegmentIndex = page;
    [self changeWithPage:page];
}

- (void)changeWithPage:(NSInteger)page{
    CGFloat lineViewCenterX = ViewWidth / _titleCount / 2 + page *(ViewWidth / _titleCount);
    [UIView transitionWithView:self.lineView duration:0.3 options:      UIViewAnimationOptionAllowUserInteraction  animations:^{
        self.lineView.center = CGPointMake(lineViewCenterX,_titleHeight);
    } completion:^(BOOL finished) {
    }];
    [self.delegete didSelectedPage:page];
}

- (NSInteger)selectedPage{
    return self.titleSegment.selectedSegmentIndex;
}

@end
