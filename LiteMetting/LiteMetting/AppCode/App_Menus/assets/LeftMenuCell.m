//
//  LeftMenuCell.m
//  LiteMetting
//
//  Created by hong pai on 13-1-20.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "LeftMenuCell.h"
#import "UIColor+expanded.h"

@implementation LeftMenuCell

@synthesize image_bg,image_ico,lab_title;

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


#pragma mark - 设置内容 -
-(void)ee_setContentdata:(NSMutableDictionary *)dictionary{
    [super ee_setContentdata:dictionary];
    
    
    NSString *Ico = [self.dataDictionary objectForKey:@"Ico"];
    NSString *Title = [self.dataDictionary objectForKey:@"Title"];
    
    lab_title.text = Title;
    image_ico.image = [UIImage imageNamed:Ico];
    
    [lab_title setTextColor:[UIColor colorWithRGBHex:color_noraml_black]];
    
    UIImageView *normal = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftmenu_list_grid.png"]];
    UIImageView *select = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftmenu_list_grid_over.png"]];
    
    self.selectedBackgroundView = select;
    [self setBackgroundView:normal];
}



#pragma mark - 选中状态 -
-(void)ee_setSelected:(BOOL)sele{
    return;
    [self setSelected:NO];
    if (sele) {
        image_bg.image = [UIImage imageNamed:@"leftmenu_list_grid_over.png"];
    }else{
        image_bg.image = [UIImage imageNamed:@"leftmenu_list_grid.png"];
    }
}





















@end
