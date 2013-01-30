//
//  PCell.m
//  LiteMetting
//
//  Created by hong pai on 13-1-14.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "PCell.h"

@implementation PCell

@synthesize dataDictionary;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)ee_setContentdata:(NSMutableDictionary *)contentDictionary{
    self.dataDictionary = contentDictionary;
    
    UIImage *nimg = [UIImage imageNamed:@"list_grid.png"];
    UIImage *simg = [UIImage imageNamed:@"list_grid_over.png"];
    //
    UIImageView *normal = [[UIImageView alloc] initWithImage:nimg];
    UIImageView *select = [[UIImageView alloc] initWithImage:simg];

    self.backgroundView = normal;
    self.selectedBackgroundView = select;
    
    //self.selectionStyle = UITableViewCellSelectionStyleGray;
}


-(void)ee_setCellContentColor_Noraml{
}


-(void)ee_setCellContentColor_Readed{
}


-(void)dealloc{
//    track();
    
    self.dataDictionary = nil;
    
    [super dealloc];
}


@end
