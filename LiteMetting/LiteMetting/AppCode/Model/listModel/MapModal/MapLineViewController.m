//
//  MapLineViewController.m
//  Baidu_map
//
//  Created by user on 13-1-22.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MapLineViewController.h"
#import "UIView+EEExtras.h"
#import <ShareSDK/ShareSDK.h>

@interface MapLineViewController ()

@end

@implementation MapLineViewController
@synthesize tableview;
@synthesize titleLabel;
@synthesize tableArray;

- (IBAction)backMapView:(id)sender {
    
    [self ee_contentOut];
}

-(id) initWithArray:(NSMutableArray*)arr WithTitle:(NSString*)title WithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        tableArray = arr; 
        titleL = title;
        
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
    titleLabel.text = titleL;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [tableview release];
    [titleLabel release];
    [super dealloc];
}


#pragma mark－－－－tableView－－－

//－－－－－－－－－－－－－tableView delegate－－－－－－－－－－－－－－－
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * indetify=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indetify];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetify];
    }
    cell.textLabel.text=[tableArray objectAtIndex:indexPath.row];
    [cell.textLabel sizeToFit];
    cell.textLabel.numberOfLines = 0;
//    cell.accessoryType=UITableViewCellAccessoryCheckmark;//添加附加的样子
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //    NSString *name = [pdfsort objectAtIndex:section];
    
    return @"";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return;
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

- (IBAction)onShare:(id)sender {
    
    NSArray *shareList = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:ShareTypeSinaWeibo],[NSNumber numberWithInt:ShareTypeTencentWeibo], nil];
    
    id<ISSPublishContent> publishContent = [ShareSDK publishContent:@"分享内容！！！！"
                                                     defaultContent:@""
                                                              image:[UIImage imageNamed:@"bus1.png"]
                                                       imageQuality:0.8
                                                          mediaType:SSPublishContentMediaTypeNews
                                                              title:@"ShareSDK"
                                                                url:@"http://www.sharesdk.cn"
                                                       musicFileUrl:nil
                                                            extInfo:nil
                                                           fileData:nil];
    //定制微信好友内容
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                         content:@"Hello 微信好友!"
                                           title:INHERIT_VALUE
                                             url:@"http://www.baidu.com"
                                           image:INHERIT_VALUE
                                    imageQuality:INHERIT_VALUE
                                    musicFileUrl:INHERIT_VALUE
                                         extInfo:INHERIT_VALUE
                                        fileData:INHERIT_VALUE];
    
    //定制微信朋友圈内容
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic]
                                          content:@"Hello 微信朋友圈!"
                                            title:INHERIT_VALUE
                                              url:@"http://y.qq.com/i/song.html#p=7B22736F6E675F4E616D65223A22E4BDA0E4B88DE698AFE79C9FE6ADA3E79A84E5BFABE4B990222C22736F6E675F5761704C69766555524C223A22687474703A2F2F74736D7573696332342E74632E71712E636F6D2F586B303051563558484A645574315070536F4B7458796931667443755A68646C2F316F5A4465637734356375386355672B474B304964794E6A3770633447524A574C48795333383D2F3634363232332E6D34613F7569643D32333230303738313038266469723D423226663D312663743D3026636869643D222C22736F6E675F5769666955524C223A22687474703A2F2F73747265616D31382E71716D757369632E71712E636F6D2F33303634363232332E6D7033222C226E657454797065223A2277696669222C22736F6E675F416C62756D223A22E5889BE980A0EFBC9AE5B08FE5B7A8E89B8B444E414C495645EFBC81E6BC94E594B1E4BC9AE5889BE7BAAAE5BD95E99FB3222C22736F6E675F4944223A3634363232332C22736F6E675F54797065223A312C22736F6E675F53696E676572223A22E4BA94E69C88E5A4A9222C22736F6E675F576170446F776E4C6F616455524C223A22687474703A2F2F74736D757369633132382E74632E71712E636F6D2F586C464E4D31354C5569396961495674593739786D436534456B5275696879366A702F674B65356E4D6E684178494C73484D6C6A307849634A454B394568572F4E3978464B316368316F37636848323568413D3D2F33303634363232332E6D70333F7569643D32333230303738313038266469723D423226663D302663743D3026636869643D2673747265616D5F706F733D38227D"
                                            image:INHERIT_VALUE
                                     imageQuality:INHERIT_VALUE
                                     musicFileUrl:@"http://mp3.mwap8.com/destdir/Music/2009/20090601/ZuiXuanMinZuFeng20090601119.mp3"
                                          extInfo:nil
                                         fileData:nil];
    
    //定制QQ分享内容
    [publishContent addQQUnitWithType:INHERIT_VALUE
                              content:@"Hello QQ!"
                                title:INHERIT_VALUE
                                  url:INHERIT_VALUE
                                image:INHERIT_VALUE
                         imageQuality:INHERIT_VALUE];
    
    //定制邮件分享内容
    [publishContent addMailUnitWithSubject:INHERIT_VALUE
                                   content:@"<a href='http://sharesdk.cn'>Hello Mail</a>"
                                    isHTML:[NSNumber numberWithBool:YES]
                               attachments:INHERIT_VALUE];
    
    //定制短信分享内容
    [publishContent addSMSUnitWithContent:@"Hello SMS!"];
    
    
    [ShareSDK showShareActionSheet:self
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                   oneKeyShareList:[NSArray defaultOneKeyShareList]
     //                          autoAuth:YES                                  //委托SDK授权标识，YES：用户授权过期后自动弹出授权界面进行授权，NO：开发者自行处理
     //                        convertUrl:YES                                  //委托转换链接标识，YES：对分享链接进行转换，NO：对分享链接不进行转换，为此值时不进行回流统计。
                    shareViewStyle:ShareViewStyleDefault
                    shareViewTitle:@"内容分享"
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
    
//    [ShareSDK showShareActionSheet:self
//                         shareList:nil content:publishContent
//                     statusBarTips:YES autoAuth:YES convertUrl:YES
//                  shareViewOptions:[ShareSDK defaultShareViewOptionsWithTitle:@"内容分享" oneKeyShareList:nil
//                                                               qqButtonHidden:YES wxSessionButtonHidden:YES
//                                                       wxTimelineButtonHidden:YES]
//                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo>
//                                     statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSPublishContentStateSuccess)
//                                {
//                                    NSLog(@"发送成功"); }
//                                else
//                                {
//                                    NSLog(@"发送失败");
//                                } }];
}




@end
