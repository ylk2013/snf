//
//  PContent.m
//  LiteMetting
//
//  Created by hong pai on 13-1-12.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "PDetail.h"

@interface PDetail ()

@end

@implementation PDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //左边阴影
        UIImageView *leftShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftmenu_shadow.png"]];
        [leftShadow setFrame:CGRectMake(-20, 0, 20, ee_AppSize.height)];
        [self.view addSubview:leftShadow];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ee_questDetail_ByCellConfig:(NSDictionary *)_cellConfig  modalconfig:(NSDictionary *)_modalconfig{
    modalConfig = _modalconfig;
    cellConfig = _cellConfig;
}

-(void)disponse{
    track();
    //自己已经在EEUIFactory里面alloc一次了，所有需要release
    [self release];
}


- (void)dealloc
{
    track();
    [super dealloc];
}

@end
