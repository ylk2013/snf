//
//  MapLineViewController.h
//  Baidu_map
//
//  Created by user on 13-1-22.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapLineViewController: UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *tableArray;
    NSString *titleL;
}

@property (retain, nonatomic) NSArray *tableArray;
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)backMapView:(id)sender;
-(id) initWithArray:(NSMutableArray*)arr WithTitle:(NSString*)title WithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
-(void)ee_contentIn;

- (IBAction)onShare:(id)sender;
@end