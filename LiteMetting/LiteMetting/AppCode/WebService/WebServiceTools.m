//
//  WebServiceTools.m
//  LiteMetting
//
//  Created by hong pai on 13-1-24.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "WebServiceTools.h"
#import "Tools_AppInitConfig.h"

@implementation WebServiceTools

@synthesize request;

@synthesize _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        [self getRquest];
    }
    return self;
}

-(ASIFormDataRequest *)getRquest {
    NSString *weburlstringg = [[Tools_AppInitConfig ee_getConfig] objectForKey:@"webrequseturl"];
    NSURL *url = [NSURL URLWithString:weburlstringg];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(e_requestFinished:)];
    [request setDidFailSelector:@selector(e_requestFailed:)];
    
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request setRequestMethod:@"POST"];
    
    
    trace(@"----------webrequseturl:%@",weburlstringg);
    
    return request;
}


-(void)ee_execute_delegate:(id)delegate finishSEL:(SEL)delegateFinishSEL FailedSEL:(SEL)delegateFailedSEL{
    self._delegate = delegate;
    _delegateFinish = delegateFinishSEL;
    _delegateFailed = delegateFailedSEL;
    
    NSString *str = [[NSString alloc] initWithData:request.postBody encoding:NSUTF8StringEncoding];
    
    [request startAsynchronous];
    
    trace(@"----------postString:%@",str);
}




-(void)e_requestFinished:(ASIFormDataRequest *)EErequest{
    track();
    
    if (self._delegate == nil) {
        trace(@"----------dagrous release--------");
        [self release];
        return;
    }
    
    [_delegate  performSelector:_delegateFinish withObject:EErequest];
    [self release];
}

-(void)e_requestFailed:(ASIFormDataRequest *)EErequest{
    track();
    
    if (self._delegate == nil) {
        trace(@"----------dagrous release--------");
        [self release];
        return;
    }
    
    [_delegate  performSelector:_delegateFailed withObject:EErequest];
    [self release];
}












-(void)dealloc{
    track();
    _delegate = nil;
    
    [super dealloc];
}
@end






























//
////3、生成SOAP消息
//NSString * soapMsg = [soapMsgBody1 stringByAppendingFormat:@"%@%@", soapParas, soapMsgBody2];
//
////    trace(@"%@",soapMsg);
//
////请求发送到的路径
//NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WebURL, wsFile]];
//
////NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
//theRequest = [ASIHTTPRequest requestWithURL:url];
//NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
//
////以下对请求信息添加属性前四句是必有的，第五句是soap信息。
//[theRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
//[theRequest addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@", xmlNS, wsName]];
//
//[theRequest addRequestHeader:@"Content-Length" value:msgLength];
//[theRequest setRequestMethod:@"POST"];
//[theRequest appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
//
//[theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//
////4、cookie
//[ADFSCookieManager ee_removeAllInHttpCookieStorage];//清空先
//NSString *siteurl = [WebURL stringByReplacingOccurrencesOfString:@"_vti_bin" withString:@""];
//NSHTTPCookie *cookie = [ADFSCookieManager ee_getOneCookie_bySiteURL:siteurl];
//if (cookie!=nil) {
//    [theRequest setRequestCookies:[NSMutableArray arrayWithObject:cookie]];
//}
//
