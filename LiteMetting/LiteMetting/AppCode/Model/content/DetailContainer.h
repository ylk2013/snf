//
//  DetailContentTainer.h
//  LiteMetting
//
//  Created by hong pai on 13-1-12.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDetail.h"

@interface DetailContainer : UIViewController{
    NSDictionary *modalConfig;
    NSDictionary *detailConfig;
    
    CGPoint lastRemenberPanPosition;
    PDetail *oneDetailController;
}
-(void)ee_initCreate;
-(void)ee_contentIn;
-(void)ee_contentOut;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil modalConfig:(NSMutableDictionary *)modalconfig contentConfig:(NSMutableDictionary *)detailconfig;
- (IBAction)onSubQues:(id)sender;

@end
