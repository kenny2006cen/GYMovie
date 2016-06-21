//
//  ViewController.m
//  GYMovie
//
//  Created by User on 16/6/21.
//  Copyright © 2016年 jlc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.webView =[[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    
//    NSString *path = @"http://www.q2002.com";
//    NSURL *url = [[NSURL alloc] initWithString:path];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
    NSString *filePath  = [resourcePath stringByAppendingPathComponent:@"q2.html"];
    NSString *htmlstring =[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:htmlstring  baseURL:[NSURL URLWithString:@"www.q2002.com"]];
    
     //[self.webView loadHTMLString:htmlstring  baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
}

#pragma mark - UIWebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.mainDocumentURL.relativePath isEqualToString:@"/alert"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"本地代码执行" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return false;  //执行本地代码，返回false不让网页读取网络资源
    }
    
    //之后在该回调中取出超链接的地址
    //因为超链接中可以有其他非跳转到本应用页面的链接地址，例如http://www.baidu.com什么的，所以需要找出以a://**的超链接地址
    NSURL *url = request.URL;
    
    if ([[url scheme] isEqualToString:@"aichang"]) {}
    
    //获取到了超链接地址了，下一步就是改变url的scheme，使之变成b，代码如下
    
    NSString *newUrlString =  [NSString stringWithFormat:@"b://%@%@",
                               url.host, url.path];
    if (url.query) {
        newUrlString = [newUrlString stringByAppendingFormat:@"?%@", url.query];
    }
    url = [NSURL URLWithString:newUrlString];
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
