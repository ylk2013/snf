//
//  WebServiceTools.h
//  LiteMetting
//
//  Created by hong pai on 13-1-24.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface WebServiceTools : NSObject{
    SEL _delegateFinish;
    SEL _delegateFailed;
    id _delegate;
    
    ASIFormDataRequest *request;
}
@property(nonatomic,assign)id _delegate;

@property(nonatomic,assign)ASIFormDataRequest *request;

//-(void)ee_execute:(MarkID)type bigestID:(int)bid delegate:(id)delegate finishSEL:(SEL)delegateFinishSEL FailedSEL:(SEL)delegateFailedSEL;
-(void)ee_execute_delegate:(id)delegate finishSEL:(SEL)delegateFinishSEL FailedSEL:(SEL)delegateFailedSEL;

@end
