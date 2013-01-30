//
//  FocusViewController.h
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PModal.h"
//#import "HorizontalMenuBar.h"
#import "EE_HorizontalMenuBar.h"

@interface FocusViewController : PModal<EE_HorizontalMenuBarDelegate>{
    EE_HorizontalMenuBar *horizontal;
    NSMutableArray *topMenuArray;
    
    PModal *lastModalController;
}

-(void)showModalViews:(NSMutableDictionary *)_modalConfig;

-(IBAction)clickShowNews:(id)sender;
-(IBAction)clickShowMaps:(id)sender;
-(IBAction)clickShowNotice:(id)sender;
-(IBAction)clickShowImagesWall:(id)sender;
-(IBAction)clickShowPartners:(id)sender;
-(IBAction)clickShowAround:(id)sender;


#pragma mark - 返回控制 -
-(void)ee_ShowAllNavigationDefaultView;

-(void)ee_ChangedHorizontalMenuBarState_ByMarkID:(MarkID)markid;

@end
