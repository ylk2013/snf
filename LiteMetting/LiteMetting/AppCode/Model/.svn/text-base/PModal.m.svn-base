//
//  PModal.m
//  LiteMetting
//
//  Created by hong pai on 13-1-12.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//


/**
 **所有modal类的父类
 */
#import "PModal.h"
#import "DetailContainer.h"
#import "LiteMettingViewController.h"
#import "UIColor+expanded.h"

@interface PModal ()

@end

@implementation PModal

@synthesize modalConfig;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil modalConfig:(NSMutableDictionary *)mconfig{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modalConfig = mconfig;
        trace(@"%@",self.modalConfig);
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithRGBHex:0xF0F0F0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//    [self ee_createDetailContent:self.modalConfig contentConfig:cell.dataDictionary];
-(void)ee_createDetailContent:(NSMutableDictionary *)mconfig contentConfig:(NSMutableDictionary *)cconfig{
    track();
    trace(@"%@ %@",mconfig,cconfig);
    
    DetailContainer *detailContainer = [[DetailContainer alloc] initWithNibName:@"DetailContainer" bundle:nil modalConfig:mconfig contentConfig:cconfig];
    
    [detailContainer.view setFrame:CGRectMake(ee_AppSize.width,0, ee_AppSize.width, ee_AppSize.height-ee_AppStatusHeight)];
    [[Global shareGlobel].rootController.view addSubview:detailContainer.view];
    [detailContainer ee_contentIn];
}




-(void)dealloc{
    track();
    [self.modalConfig release];
    [super dealloc];
}

@end
