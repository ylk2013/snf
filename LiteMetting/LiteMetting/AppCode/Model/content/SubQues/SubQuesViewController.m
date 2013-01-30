//
//  SubQuesViewController.m
//  LiteMetting
//
//  Created by kyl on 13-1-30.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "SubQuesViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "UIView+EEExtras.h"
#import "MBProgressHUD.h"
#import "DropDownView.h"
#import "Tools_GetAllModalListConfig.h"
#import "Tools_DispatchWebRequest.h"
#import "WebServiceTools.h"
#import "NSObject+SBJson.h"

@interface SubQuesViewController ()

@end

WebServiceTools *ws;
@implementation SubQuesViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andType:(int)type andId:(int)id{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
         framRect = self.view.frame;
        q_type = type;
        q_id = id;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getAllExpert];
    // Do any additional setup after loading the view from its nib.
}

-(void) getAllExpert
{
    
    WebServiceTools *webserv = [[WebServiceTools alloc] init];
    
    NSMutableDictionary *dictinary = [NSMutableDictionary dictionary];
    
    [dictinary setValue:@"GetSpeakerList" forKey:@"method"];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:@"0" forKey:@"maxid"];
    [parameter setValue:[NSString stringWithFormat:@"%d",MarkID_Expert] forKey:@"type"];
    
    [dictinary setValue:parameter forKey:@"attachment"];
    
    NSString *postring = [dictinary JSONRepresentation];
    
    trace(@"%@",postring);
    
    [webserv.request setPostValue:postring forKey:@"paramter"];
    [webserv ee_execute_delegate:self finishSEL:@selector(request_Success:) FailedSEL:@selector(request_Failed:)];
    
//    NSMutableDictionary *td = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_Expert];
//    ws = [Tools_DispatchWebRequest ee_dispatchGetWebServerListRequest:td delegate:self finish:@selector(request_Success:) failed:@selector(request_Failed:)];
}

-(void) request_Success:(ASIHTTPRequest*)request{
//    ws = nil;
    if(![request.responseString hasPrefix:@"{"]&&![request.responseString hasPrefix:@"["]){
        
    }else{
        NSMutableArray* arr=[request.responseString JSONValue];
        if(arr!=nil && [arr count]!=0){
            _nameDropDown = [[DropDownView alloc] initWithFrame:CGRectMake(84, 182, 200, 30)];
            _nameDropDown.textField.placeholder = @"请选择专家姓名";
            _nameDropDown.tableArray = arr;
            [self.view addSubview:_nameDropDown];
            
        }
    }
}
-(void) request_Failed:(ASIHTTPRequest*)request{
    NSLog(@"111");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSubClick:(id)sender {
    if(_nameTxt.text.length<2||_hospitalTxt.text.length<2||_quesTxt.text.length<2)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入完整信息！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    [self postToServer];
}
- (IBAction)backView:(id)sender {
    
    [self ee_contentOut];
}

- (IBAction)backgroundTap:(id)sender {
    [_nameTxt resignFirstResponder];
    [_hospitalTxt resignFirstResponder];
    [_phoneTxt resignFirstResponder];
    [_quesTxt resignFirstResponder];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = framRect;
    [UIView commitAnimations];
}


#pragma mark -----键盘控制--------
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    float height = 400.0; //352.0 ipad
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(0, -height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

-(void)checkIsNeedDown{
    if (_nameTxt.isFirstResponder||_hospitalTxt.isFirstResponder||_phoneTxt.isFirstResponder||_quesTxt.isFirstResponder ) {
        return;
    }
    
    CGRect rect = [self.view frame];
    rect.origin.x = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    
    [self.view setFrame:rect];
    
    [UIView commitAnimations];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self performSelector:@selector(checkIsNeedDown) withObject:nil afterDelay:0.3f];
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    [self performSelector:@selector(checkIsNeedDown) withObject:nil afterDelay:0.3f];
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, -200,framRect.size.width,framRect.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}


#pragma mark ----提交数据到服务器-----
-(void)postToServer{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *path = [NSString stringWithFormat:@"http://www.elive.sh/snf/SendSms.aspx"];
    NSURL *url = [NSURL URLWithString:path];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.tag = 0;
    [request setPostValue:_nameTxt.text forKey:@"name"];
    [request setPostValue:_hospitalTxt.text forKey:@"hospital"];
    [request setPostValue:_quesTxt.text forKey:@"content"];
    [request setPostValue:[NSString stringWithFormat:@"%d",q_type] forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",q_id] forKey:@"id"];
    [request setPostValue:[NSString stringWithFormat:@"%d",_nameDropDown.expertId] forKey:@"speakerid"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@" %d  %@",request.responseStatusCode,responseString);
    
    if (request.tag==0 && request.responseStatusCode == 200) {//跟踪信息
        
    }else {
        NSLog(@"request。tag   none");
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self disponse];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@",request.error);
    
    if (request.tag ==0 ) {
    }
    NSLog(@"传递失败1");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self disponse];
}


-(void)ee_contentIn{
    CGSize rotatedSize = self.view.frame.size;
    self.view.center = CGPointMake(self.view.center.x+rotatedSize.width, self.view.center.y);
    [self.view ee_tween:0.5 to:@"x:0,y:0"];
}
-(void)ee_contentOut{
    NSString *toX = [NSString stringWithFormat:@"x:%f,y:0",ee_AppSize.width];
    [self.view ee_tween:0.5 to:toX delegate:self sel:@selector(ee_contentDisponse)];
}

-(void)ee_contentDisponse{
    track();
    //回收oneDetailController
    [self.view removeFromSuperview];
    [self release];
}
-(void)disponse{
    [self.view removeFromSuperview];
    [self release];
    self = nil;
}
- (void)dealloc {
    [_nameTxt release];
    [_hospitalTxt release];
//    [_phoneTxt release];
    [_quesTxt release];
    [_nameDropDown release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNameTxt:nil];
    [self setHospitalTxt:nil];
//    [self setPhoneTxt:nil];
    [self setQuesTxt:nil];
    [self setNameDropDown:nil];
    [super viewDidUnload];
}
@end
