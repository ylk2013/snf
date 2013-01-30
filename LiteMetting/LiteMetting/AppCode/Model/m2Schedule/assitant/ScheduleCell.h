//
//  ScheduleCell.h
//  LiteMetting
//
//  Created by hong pai on 13-1-13.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleCell : UITableViewCell{
    IBOutlet UILabel *s_titlename;
    IBOutlet UILabel *s_time;
    IBOutlet UILabel *s_expertOrOrgnization;
    
    NSMutableDictionary *_dataDictionary;
}

@property(nonatomic,retain)NSMutableDictionary *dataDictionary;

@property(nonatomic,retain)UILabel *s_titlename;
@property(nonatomic,retain)UILabel *s_time;
@property(nonatomic,retain)UILabel *s_expertOrOrgnization;



-(void)ee_setContentdata:(NSMutableDictionary *)dictionary;



@end
