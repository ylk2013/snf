//
//  SubQuesViewController.h
//  LiteMetting
//
//  Created by kyl on 13-1-30.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropDownView;

@interface SubQuesViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
    CGRect framRect;
    int q_type;
    int q_id;
}


@property (retain, nonatomic) IBOutlet UITextField *nameTxt;
@property (retain, nonatomic) IBOutlet UITextField *hospitalTxt;
@property (retain, nonatomic) IBOutlet UITextField *phoneTxt;
@property (retain, nonatomic) IBOutlet UITextView *quesTxt;
@property (retain, nonatomic) DropDownView *nameDropDown;


- (IBAction)onSubClick:(id)sender;
- (IBAction)backView:(id)sender;
-(void)ee_contentIn;
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andType:(int)type andId:(int)id;

@end
