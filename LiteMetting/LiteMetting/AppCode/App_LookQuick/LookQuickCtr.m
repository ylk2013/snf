//
//  LookQuickCtr.m
//  EENews
//
//  Created by hong pai on 12-10-21.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "LookQuickCtr.h"
#import "LookQuickView.h"

@interface LookQuickCtr ()

@end

@implementation LookQuickCtr

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
    // Do any additional setup after loading the view from its nib.
    
    //回调
    ((LookQuickView *)self.view).delegate = self;
}   
    
- (void)didReceiveMemoryWarning
{   
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}   



@end
