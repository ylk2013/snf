//
//  ScheduleCell.m
//  LiteMetting
//
//  Created by hong pai on 13-1-13.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "ScheduleCell.h"
#import "UIColor+expanded.h"

@implementation ScheduleCell

@synthesize s_expertOrOrgnization,s_time,s_titlename;

@synthesize dataDictionary = _dataDictionary;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 设置 表格里面的 数据 -
-(void)ee_setContentdata:(NSMutableDictionary *)dictionary{
    track();
    self.dataDictionary = dictionary;
    trace(@"12323   %@",dictionary);

    NSString *ScheduleName = [dictionary objectForKey:@"title"];
    trace(@"%@",ScheduleName);
    NSString *ScheduleTime = [NSString stringWithFormat:@"%@ - %@",[dictionary objectForKey:@"starttime"],[dictionary objectForKey:@"endtime"]] ;
    trace(@"%@",ScheduleTime);
    NSString *ScheduleExpert = [dictionary objectForKey:@"expert"];
    trace(@"%@",ScheduleExpert);
    
    self.s_time.text = ScheduleTime;
    self.s_titlename.text = ScheduleName;
    self.s_expertOrOrgnization.text = ScheduleExpert;
    
    
    //self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    [self ee_setCellContentColor_Noraml];
}

#pragma mark - 设置 颜色 -
-(void)ee_setCellContentColor_Noraml{
    s_titlename.textColor = [UIColor colorWithRGBHex:color_noraml_black];
    s_time.textColor = [UIColor colorWithRGBHex:color_noraml_gray];
    s_expertOrOrgnization.textColor = [UIColor colorWithRGBHex:color_noraml_gray];
}

-(void)ee_setCellContentColor_Readed{
    s_titlename.textColor = [UIColor colorWithRGBHex:color_noraml_gray];
    s_time.textColor = [UIColor colorWithRGBHex:color_noraml_gray];
    s_expertOrOrgnization.textColor = [UIColor colorWithRGBHex:color_noraml_gray];
}


-(void)dealloc{
    track();
    [self.s_time release];
    [self.s_expertOrOrgnization release];
    [self.s_titlename release];
    
    [self.dataDictionary release];
    
    [super dealloc];
}


@end
