//
//  CommonWebController.m
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "CommonWebController.h"

@interface CommonWebController ()

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UIActivityIndicatorView *ind_header;
@property (strong, nonatomic) UIActivityIndicatorView *ind_content;

@end

@implementation CommonWebController
#pragma mark - initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadURL];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self updateLoadingStatus:NO];
    [self.webView stopLoading];
}

- (void)initWebView{
    if (!self.webView) {
        self.webView = [[UIWebView alloc] init];
        self.webView.frame = [UIScreen mainScreen].bounds;
        self.webView.delegate = self;
        [self.webView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
        
        self.webView.scalesPageToFit = YES;
        self.webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.webView];
        
        //indicators
        //header indicator
        _ind_header = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        //content indicator
        _ind_content = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _ind_content.center = self.webView.center;
        [self.webView addSubview:_ind_content];
    }
    if (self.navigationController) {
        self.navigationItem.rightBarButtonItems =@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(reloadURL)],
                                                   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemStop) target:self action:@selector(stopLoading)]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - setter

- (void)setShowContentLoadingIndicator:(BOOL)showContentLoadingIndicator{
    _showContentLoadingIndicator = showContentLoadingIndicator;
    if (!showContentLoadingIndicator) {
        [self.ind_content stopAnimating];
    }
}

#pragma mark - loading methods
- (void)loadURL{
    if (self.url) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:(NSURLRequestReturnCacheDataElseLoad) timeoutInterval:15];
        [self.webView loadRequest:req];
        [self showTitleIndicator];
        [self updateLoadingStatus];
    }
}

- (void)reloadURL{
    [self.webView reload];
}

- (void)stopLoading{
    [self.webView stopLoading];
}

- (void)updateLoadingStatus{
    [self updateLoadingStatus:self.webView.isLoading];
}
- (void)updateLoadingStatus:(BOOL)isLoading{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = isLoading;
    if (self.showContentLoadingIndicator) {
        if (isLoading) {
            [self.ind_content startAnimating];
        }else{
            [self.ind_content stopAnimating];
        }
    }
}

- (void)showTitleIndicator{
    if (self.navigationController) {
        self.navigationItem.titleView = self.ind_header;
        [self.ind_header startAnimating];
    }
}

- (void)hideTitleIndicator{
    if (self.navigationController) {
        [self.ind_header stopAnimating];
        self.navigationItem.titleView = self.titleView;
    }
}

- (NSString *)titleOfCurrentUrl{
    return [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (NSString *)currentUrl{
    return self.webView.request.URL.absoluteString ? self.webView.request.URL.absoluteString : self.webView.request.mainDocumentURL.absoluteString;
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self updateLoadingStatus];
    if ([self titleOfCurrentUrl]) {
        self.title = [self titleOfCurrentUrl];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self updateLoadingStatus:NO];
    [self hideTitleIndicator];
    self.title = [self titleOfCurrentUrl];
    self.url = [self currentUrl];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self updateLoadingStatus:NO];
    [self hideTitleIndicator];
    self.title = [self titleOfCurrentUrl];
    self.url = [self currentUrl];
}


// 如果返回NO，代表不允许加载这个请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 说明协议头是ios,例：ios:DoMethod
    if ([@"ios" isEqualToString:request.URL.scheme]) {
        NSString *url = request.URL.absoluteString;
        NSRange range = [url rangeOfString:@":"];
        NSString *method = [request.URL.absoluteString substringFromIndex:range.location + 1];
        
        SEL selector = NSSelectorFromString(method);
        
        if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang disgnostic ignored "-Warc-performSelecotr-leaks"
            [self performSelector:@selector(selector)];
#pragma clang disgnostic pop
        }
        
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeReload) {
        [self showTitleIndicator];
    }
    return YES;
}
@end

