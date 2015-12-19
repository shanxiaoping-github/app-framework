//
//  BBGWebViewController.m
//  Components
//
//  Created by Holyjoy on 15/5/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGWebViewController.h"
#import "Common.h"
#import "BBGNavigationController.h"
@interface BBGWebViewController ()<UIWebViewDelegate,NSURLConnectionDelegate>


@property (nonatomic, strong) NSMutableData *webData;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSString *htmlString;

@property (nonatomic, strong) UIButton *backUpBtn;
@property (nonatomic, strong) UIButton *goForwardBtn;
@property (nonatomic, strong) UIButton *refreshBtn;


@property (nonatomic, strong, readonly) UIView *bottomView;
@property (nonatomic, strong) MASConstraint *bottomViewHeightConstraint;


@end

@implementation BBGWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        _bottomView = [UIView new];
        [_bottomView setBackgroundColor:RGB_COLOR(248, 248, 248)];
        
        _webView = [UIWebView new];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.webView.delegate = self;
        self.webView.scalesPageToFit = YES;
        self.webView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:_bottomView];
        [self.view addSubview:self.webView];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":@"iOSGlobal"}];

        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(_bottomView.mas_top);
        }];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            _bottomViewHeightConstraint = make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        UIView *lineView = [UIView new];
        [lineView setBackgroundColor:RGB_COLOR(204, 204, 204)];
        [_bottomView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        _backUpBtn = [UIButton buttonWithMyImage:@"web_left_arrow_gray"];
        [_backUpBtn setBackgroundImage:[UIImage imageNamed:@"web_left_arrow_red"] forState:UIControlStateSelected];
        _goForwardBtn = [UIButton buttonWithMyImage:@"web_right_arrow_gray"];
        [_goForwardBtn setBackgroundImage:[UIImage imageNamed:@"web_right_arrow_red"] forState:UIControlStateSelected];
        _refreshBtn = [UIButton buttonWithMyImage:@"web_refresh"];
        
        [_backUpBtn addTarget:self action:@selector(backUpBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_goForwardBtn addTarget:self action:@selector(goForwardBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_refreshBtn addTarget:self action:@selector(refreshBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:_backUpBtn];
        [_bottomView addSubview:_goForwardBtn];
        [_bottomView addSubview:_refreshBtn];
        
        [_backUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bottomView);
            make.left.mas_equalTo(10);
        }];
        
        [_goForwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bottomView);
            make.left.mas_equalTo(_backUpBtn.mas_right).offset(36);
        }];
        
        [_refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bottomView);
            make.right.mas_equalTo(_bottomView.mas_right).offset(-10);
        }];
        
        self.hasBottomView = NO;
    }
    return self;
}

- (id)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        [self loadURL:url];
    }
    return self;
}

- (id)initWithHTMLString:(NSString *)htmlString{
    self = [super init];
    if (self) {
        [self loadURL:nil htmlString:htmlString];
    }
    return self;
}



- (id)initWithURL:(NSURL *)url htmlString:(NSString *)htmlString {
    self = [super init];
    if (self) {
        self.htmlString = htmlString;
        [self loadURL:url htmlString:htmlString];
    }
    return self;
}

- (NSMutableURLRequest *)buildRequest {
    if (self.url) {
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:self.url];
        [request setValue:[NSString stringWithFormat:@"%f",IOS_VERSION] forHTTPHeaderField:@"systemVersion"];
        [request setValue:@"appName" forHTTPHeaderField:@"iOS_global"];
        return request;
    }else{
        return nil;
    }
}

- (void)loadURL:(NSURL *)url {
    [self loadURL:url htmlString:nil];
}

- (void)loadURL:(NSURL *)url htmlString:(NSString *)htmlString {
    if (url) {
        self.url = url;
        
        NSRange range = [self.url.absoluteString rangeOfString:BBG_SHOW_BOTTOM_BAR];
        if (NSNotFound == range.location) {
            self.hasBottomView = NO;
        }else{
            self.hasBottomView = YES;
        }
        
    }
    
    NSURLRequest *request = [self buildRequest];
    if ([url.scheme isEqualToString:@"https"] && [self handleHttps]) {
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [_connection start];
    }else{
        if (htmlString) {
            if (!self.url) {
                [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
            }else
                [self.webView loadHTMLString:htmlString baseURL:url];
        }else{

            [self.webView loadRequest:request];

        }
    }
}
-(NSDictionary*)pasingWithPrefix:(NSString *)prefix urlStr:(NSString *)urlStr{
    urlStr = [urlStr substringFromIndex:prefix.length];
    urlStr = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *info = [NSJSONSerialization
                          JSONObjectWithData:[urlStr dataUsingEncoding:NSUTF8StringEncoding]
                          options:kNilOptions
                          error:&error];
    if([info count] > 0){
        return info;
    }
    return nil;
}

- (NSDictionary *)pasingWithString:(NSString *)string {
    NSString *urlStr = [NSString stringWithString:string];
    NSString *prefix = @"bbgapp://";
    if ([[urlStr lowercaseString] hasPrefix:prefix]) {
        return [self pasingWithPrefix:prefix urlStr:urlStr];
    }
    return nil;
}

- (BOOL)parseURLString:(NSString *)url {
    BOOL isHttps = [url hasPrefix:@"https"];
    if (isHttps) {
        [self loadURL:[NSURL URLWithString:url]];
    }
    return !isHttps;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self judgeBackForwardBtn];

//    self.navigationController.navigationBar.tintColor = UIColorFromHexadecimalRGB(0x333333);
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NavBar_white"] stretchImage] forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)handleHttps {
    return YES;
}

- (void)setHasBottomView:(BOOL)hasBottomView{
    _hasBottomView = hasBottomView;
    if (_hasBottomView) {
        _bottomViewHeightConstraint.mas_equalTo(50);
    }else{
        _bottomViewHeightConstraint.mas_equalTo(0);
    }
}

- (void)backUpBtnPressed:(UIButton*)btn{
    [_webView goBack];
    [self reLoadNavView];
}

- (void)goForwardBtnPressed:(UIButton*)btn{
    [_webView goForward];
    [self reLoadNavView];
}

- (void)refreshBtnPressed:(UIButton*)btn{
    [_webView reload];
    [self reLoadNavView];
}

-(void)reLoadNavView{
    
}



-(void)judgeBackForwardBtn{
    if ([_webView canGoBack]) {
        [_backUpBtn setEnabled:YES];
        [_backUpBtn setSelected:YES];
    }else{
        [_backUpBtn setEnabled:NO];
        [_backUpBtn setSelected:NO];
    }
    if ([_webView canGoForward]) {
        [_goForwardBtn setEnabled:YES];
        [_goForwardBtn setSelected:YES];
    }else{
        [_goForwardBtn setEnabled:NO];
        [_goForwardBtn setSelected:NO];
    }
}

#pragma mark - UIWebViewDelegate Methods
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //    NSLog(@"webView:%@",request.URL.absoluteString);
    return [self parseURLString:request.URL.absoluteString];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

     [[BBGLoadingTips sharedInstance] showLoadingOnView:self.webView hideAfterTimeval:5];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [[BBGLoadingTips sharedInstance] hideTips];
    [self judgeBackForwardBtn];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[BBGLoadingTips sharedInstance] hideTips];
    [self judgeBackForwardBtn];
}

#pragma mark - HTTPS  NSURLConnectionDelegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (self.webData == nil) {
        self.webData = [[NSMutableData alloc] init];
    }
    [self.webData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (_htmlString) {
        [self.webView loadHTMLString:_htmlString baseURL:nil];
    }else{
        [self.webView loadData:self.webData MIMEType: @"text/html" textEncodingName: @"UTF-8" baseURL:connection.currentRequest.URL];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_connection cancel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
