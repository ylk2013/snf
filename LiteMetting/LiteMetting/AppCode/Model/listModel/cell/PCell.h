//
//  PCell.h
//  LiteMetting
//
//  Created by hong pai on 13-1-14.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCell : UITableViewCell{
    NSMutableDictionary *dataDictionary;
}

@property(nonatomic,retain)NSMutableDictionary *dataDictionary;


-(void)ee_setContentdata:(NSMutableDictionary *)contentDictionary;

-(void)ee_setCellContentColor_Noraml;
-(void)ee_setCellContentColor_Readed;

@end
