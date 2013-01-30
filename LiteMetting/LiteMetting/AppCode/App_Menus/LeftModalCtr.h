//
//  LeftModalCtr.h
//  EENews
//
//  Created by hong pai on 12-10-21.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftMenuCell;

@interface LeftModalCtr : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *AllModalMenuArray;
    
    IBOutlet UITableView *listtableview;
    
    LeftMenuCell *lastClickCell;
}

//选中一个NavButton
-(void)ee_selectOneItem:(MarkID)clickMarkID;
-(void)ee_ChangedMenuBarState_ByMarkID:(MarkID)markID;

@end
