//
//  ListGeneralCell.h
//  LiteMetting
//
//  Created by hong pai on 13-1-14.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCell.h"
#import "EGOImageView.h"

@interface ListGeneralCell : PCell{
    IBOutlet EGOImageView *image_poster;
    IBOutlet UILabel *lab_titleName;
    IBOutlet UILabel *lab_summary;
}

@property(nonatomic,retain)EGOImageView *image_poster;
@property(nonatomic,retain)UILabel *lab_titleName;
@property(nonatomic,retain)UILabel *lab_summary;



-(void)ee_setCellContentColor_Noraml;
-(void)ee_setCellContentColor_Readed;


@end
