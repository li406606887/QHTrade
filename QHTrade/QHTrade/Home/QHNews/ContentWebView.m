//
//  ContentWebView.m
//  QHTrade
//
//  Created by user on 2017/8/17.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ContentWebView.h"
#import "QHNewsViewModel.h"

@interface ContentWebView ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property(nonatomic,strong) QHNewsViewModel *viewModel;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *timerLabel;
@property(nonatomic,strong) WKWebView *webView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) WKWebViewConfiguration *webViewConfiguration;
@property(nonatomic,strong) UIProgressView *progressView;
@end

@implementation ContentWebView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (QHNewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.webView];
    [self addSubview:self.title];
    [self addSubview:self.timerLabel];
    [self addSubview:self.line];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(80, 0, 0, 0));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 32));
    }];
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(16);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 14));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timerLabel.mas_bottom).with.offset(3);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 1));
    }];
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"AppModel"]) {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        NSLog(@"%@", message.body);
    }
}

#pragma mark WKNavigationDelegate协议，监听网页加载周期
// 发送请求前决定是否跳转，并在此拦截拨打电话的URL
// 请求开始前，会先调用此代理方法
// 与UIWebView的
// - (BOOL)webView:(UIWebView *)webView
// shouldStartLoadWithRequest:(NSURLRequest *)request
// navigationType:(UIWebViewNavigationType)navigationType;
// 类型，在请求先判断能不能跳转（请求）

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
/// 发送请求前决定是否跳转，并在此拦截拨打电话的URL
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    //    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
    //        && ![hostname containsString:@".baidu.com"]) {
    //        // 对于跨域，需要手动跳转
    //        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    //
    //        // 不允许web内跳转
    //        decisionHandler(WKNavigationActionPolicyCancel);
    //    } else {
    //
    //    }
    self.progressView.alpha = 1.0;
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"%s", __FUNCTION__);
}
/// 收到响应后决定是否跳转
// 在响应完成时，会回调此方法
// 如果设置为不允许响应，web内容就不会传过来
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%s", __FUNCTION__);
}
/// 内容开始加载
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    self.progressView.alpha = 1.0;
}
/// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if (self.progressView.progress < 1.0) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.progressView.alpha = 0.0f;
        } completion:nil];
    }
    //    /// 禁止长按弹窗，UIActionSheet样式弹窗
    //    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    //    /// 禁止长按弹窗，UIMenuController样式弹窗（效果不佳）
    //    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
}
//利用KVO实现进度条
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}
// 开始导航跳转时会回调
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}
// 接收到重定向时会回调
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (error.code == NSURLErrorNotConnectedToInternet) {
        showMassage(@"加载失败");
        /// 无网络(APP第一次启动并且没有得到网络授权时可能也会报错)
        
    } else if (error.code == NSURLErrorCancelled){
        /// -999 上一页面还没加载完，就加载当下一页面，就会报这个错。
        return;
    }
    NSLog(@"%s", __FUNCTION__);
}



// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

// 9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}
#pragma mark 懒加载 初始化配置
-(UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(gobackUpStep) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

-(void)gobackUpStep {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        //        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:self.webViewConfiguration];
        _webView.UIDelegate = self;/// 这个代理对应的协议方法常用来显示弹窗
        _webView.allowsBackForwardNavigationGestures = YES;/// 侧滑返回上一页，侧滑返回不会加载新的数据，选择性开启
        _webView.navigationDelegate = self;/// 在这个代理相应的协议方法可以监听加载网页的周期和结果
        // 字体的大小
//        NSString *strUrl = [self.viewModel.newsModel.content stringByReplacingOccurrencesOfString:@"font-size: 16px" withString:@"font-size: 40px"];
//        NSString *lineHeightStrUrl = [strUrl stringByReplacingOccurrencesOfString:@"line-height: 30px" withString:@"line-height: 80px"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.viewModel.newsModel.content]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [_webView loadRequest:request];
        UIScrollView *questScrollView =  [_webView.subviews objectAtIndex:0];
        [questScrollView setShowsVerticalScrollIndicator:NO];
        
        // 添加KVO监听
        [_webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
        [_webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
        [_webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    }
    return _webView;
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading) {
        [UIView animateWithDuration:0.5 animations:^ {
            self.progressView.alpha = 0;
        }];
    }
}


/// 偏好设置,涉及JS交互
-(WKWebViewConfiguration *)webViewConfiguration {
    if (!_webViewConfiguration) {
        _webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        _webViewConfiguration.preferences = [[WKPreferences alloc]init];
        _webViewConfiguration.preferences.javaScriptEnabled = YES;
        _webViewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        _webViewConfiguration.processPool = [[WKProcessPool alloc]init];
        _webViewConfiguration.allowsInlineMediaPlayback = YES;
        _webViewConfiguration.userContentController = [[WKUserContentController alloc] init];
        _webViewConfiguration.processPool = [[WKProcessPool alloc] init];
    }
    return _webViewConfiguration;
}

-(UIProgressView*)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.frame = self.bounds;
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}
-(UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc] init];
        _timerLabel.font = [UIFont systemFontOfSize:12];
        _timerLabel.textColor = RGB(180, 180, 180);
        _timerLabel.text = [NSString stringWithFormat:@"%@ 作者:%@",[NSDate getReleaseDate:self.viewModel.newsModel.createDate format:@"yyyy年MM月dd日HH:mm"],self.viewModel.newsModel.author];
    }
    return _timerLabel;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.numberOfLines = 2;
        _title.text = self.viewModel.newsModel.title;
    }
    return _title;
}
-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:RGB(180, 180, 180)];
    }
    return _line;
}
@end
