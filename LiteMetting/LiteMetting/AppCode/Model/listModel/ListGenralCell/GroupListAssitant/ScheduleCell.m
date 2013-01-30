//
//  ScheduleCell.m
//  LiteMetting
//
//  Created by hong pai on 13-1-24.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "ScheduleCell.h"
#import "UIColor+expanded.h"

@implementation ScheduleCell

@synthesize lab_expertname,lab_summary,lab_time;

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
    [super ee_setContentdata:dictionary];
    
    
    NSString *ScheduleBeginTime = [dictionary objectForKey:@"ScheduleBeginTime"];
    NSString *ScheduleEndTime = [dictionary objectForKey:@"ScheduleEndTime"];
    NSString *ScheduleSummery = [dictionary objectForKey:@"ScheduleSummery"];
    NSString *SpeakerName = [dictionary objectForKey:@"SpeakerName"];
    
    self.lab_time.text = [NSString stringWithFormat:@"%@-%@",ScheduleBeginTime,ScheduleEndTime];
    self.lab_expertname.text = SpeakerName;
    self.lab_summary.text = ScheduleSummery;
    
    
    BOOL isReaded = [[dictionary objectForKey:@"IsReaded"] boolValue];
    if (isReaded) {
        [self ee_setCellContentColor_Readed];
    }else{
        [self ee_setCellContentColor_Noraml];
    }
    
    //是否需要重新刷新位置
//    if (poster==nil || [poster isEqualToString:@""]) {
//        [self refreshUIControlerPosition:lab_titleName];
//        [self refreshUIControlerPosition:lab_summary];
//    }
}




#pragma mark - 设置 颜色 -
-(void)ee_setCellContentColor_Noraml{
    self.lab_time.textColor             = [UIColor colorWithRGBHex:color_noraml_black];
    self.lab_time.highlightedTextColor  = [UIColor colorWithRGBHex:color_noraml_black];
    
    self.lab_expertname.textColor             = [UIColor colorWithRGBHex:color_noraml_black];
    self.lab_expertname.highlightedTextColor  = [UIColor colorWithRGBHex:color_noraml_black];
    
    self.lab_summary.textColor               = [UIColor colorWithRGBHex:color_noraml_gray];
    self.lab_summary.highlightedTextColor    = [UIColor colorWithRGBHex:color_noraml_gray];
}


-(void)ee_setCellContentColor_Readed{
    self.lab_time.textColor             = [UIColor colorWithRGBHex:color_noraml_gray];
    self.lab_time.highlightedTextColor  = [UIColor colorWithRGBHex:color_noraml_gray];
    
    self.lab_expertname.textColor             = [UIColor colorWithRGBHex:color_noraml_gray];
    self.lab_expertname.highlightedTextColor  = [UIColor colorWithRGBHex:color_noraml_gray];
    
    self.lab_summary.textColor               = [UIColor colorWithRGBHex:color_noraml_gray];
    self.lab_summary.highlightedTextColor    = [UIColor colorWithRGBHex:color_noraml_gray];
}





-(void)dealloc{
    track();
    self.lab_expertname = nil;
    self.lab_summary = nil;
    self.lab_time = nil;
    
    [super dealloc];
}
@end
