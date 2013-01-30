//
//  EEUIFactory.m
//  LiteMetting
//
//  Created by hong pai on 13-1-14.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "EEUIFactory.h"
#import "PModal.h"
#import "PDetail.h"
#import "ListGeneralModal.h"
#import "DetailArticle.h"
#import "DetailSchedule.h"

#import "GroupListModal.h"
#import "MapModal.h"
#import "ImageWallModal.h"



@implementation EEUIFactory


@synthesize modalControllerArray;


static EEUIFactory *instance;

+(EEUIFactory *)getFactory{
    if (instance == nil) {
        instance = [[EEUIFactory alloc] init];
    }
    return instance;
}
- (id)init
{
    self = [super init];
    if (self) {
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        self.modalControllerArray = array;
        [array release];
        
        
    }
    return self;
}



#pragma mark - 工厂 ModalController

//是否已经通过工厂创建了modalController
-(PModal *)ee_isCreateModalController:(NSMutableDictionary *)modalConfig{
    MarkID markID = [[modalConfig objectForKey:@"MarkID"] intValue];//标记
        
    for (int i = 0 ; i<[modalControllerArray count]; i++) {
        
        PModal *modal = [modalControllerArray objectAtIndex:i];
        NSDictionary *dictionary = modal.modalConfig;
        MarkID curMark = [(NSString *)[dictionary objectForKey:@"MarkID"] intValue];

        if (curMark == markID) {
            return modal;
        }
    }
    return nil;
}

//得到二级列表 工厂方法
-(PModal *)ee_getModalControllerByModalConfig:(NSMutableDictionary *)modalConfig{
    track();
    
    //从工厂里面的到modalController
    PModal *pModalController = [[EEUIFactory getFactory] ee_isCreateModalController:modalConfig];
    
    if (pModalController != nil) {
        
        return  pModalController;   
    }

    NSString *modalType = [modalConfig objectForKey:@"Modal_Type"];
    
    trace(@"------------modalType:%@",modalType);
    
    if([modalType localizedCaseInsensitiveCompare:@"GeneralListModal"] == NSOrderedSame){
        pModalController = [[ListGeneralModal alloc] initWithNibName:@"ListGeneralModal" bundle:nil modalConfig:modalConfig];
    }else if([modalType localizedCaseInsensitiveCompare:@"GroupListModal"] == NSOrderedSame){
        pModalController = [[GroupListModal alloc] initWithNibName:@"GroupListModal" bundle:nil  modalConfig:modalConfig];
    }else if([modalType localizedCaseInsensitiveCompare:@"MapModal"] == NSOrderedSame){
        pModalController = [[MapModal alloc] initWithNibName:@"MapModal" bundle:nil  modalConfig:modalConfig];
    }else if([modalType localizedCaseInsensitiveCompare:@"ImageWallModal"] == NSOrderedSame){
        pModalController = [[ImageWallModal alloc] initWithNibName:@"ImageWallModal" bundle:nil  modalConfig:modalConfig];
    }
    
    //放入数组
    if (pModalController != nil) {
        //[modalControllerArray addObject:pModalController];
    }
    
    return pModalController;
}


#pragma mark - 工厂 Cell
//得到cell 工厂方法
-(PCell *)ee_getTableCellViewByModalConfig:(NSDictionary *)modalConfig{
    track();
    PCell *pcell;
    
    NSString *cellType = [modalConfig objectForKey:@"Cell_Type"];
    
    if([cellType localizedCaseInsensitiveCompare:@"GeneralCell"] == NSOrderedSame){
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ListGeneralCell" owner:nil options:nil];
        pcell = [array objectAtIndex:0];
    }else if([cellType localizedCaseInsensitiveCompare:@"ScheduleCell"] == NSOrderedSame){
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:nil options:nil];
        pcell = [array objectAtIndex:0];
    }else if([cellType localizedCaseInsensitiveCompare:@"ExpertCell"] == NSOrderedSame){
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ExpertCell" owner:nil options:nil];
        pcell = [array objectAtIndex:0];
    }
    
//    else if([cellType localizedCaseInsensitiveCompare:@""]){
//        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ExpertCell" owner:nil options:nil];
//        pcell = [array objectAtIndex:0];
//    }else if([cellType localizedCaseInsensitiveCompare:@""]){
//        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:nil options:nil];
//        pcell = [array objectAtIndex:0];
//    }else if([cellType localizedCaseInsensitiveCompare:@""]){
//        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ListGeneralCell" owner:nil options:nil];
//        pcell = [array objectAtIndex:0];
//    }
    
    NSAssert(pcell != nil, @"found cell is nill，，。。。in EEUIFactory");
    
    //其它对cell的设置
    if (pcell) {
        //设置accessory
        BOOL isHasAccessoryType = [[modalConfig objectForKey:@"cellAccessory"] boolValue];
        
        if (isHasAccessoryType) {
            pcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return pcell;
}




#pragma mark - 工厂 DetailController
//得到三级内容页 工厂方法
-(PDetail *)ee_getDetailControllerByModalConfig:(NSDictionary *)modalConfig{
    track();
    PDetail *pcontentController;
    
    NSString *detailType = [modalConfig objectForKey:@"Detail_Type"];
    
    if([detailType localizedCaseInsensitiveCompare:@"GeneralDetail"] == NSOrderedSame){
        pcontentController = [[DetailArticle alloc] initWithNibName:@"DetailArticle" bundle:nil];
    }else if([detailType localizedCaseInsensitiveCompare:@"ScheduleDetail"] == NSOrderedSame){
        pcontentController = [[DetailSchedule alloc] initWithNibName:@"DetailSchedule" bundle:nil];        
    }
    
    if (pcontentController==nil) {
        trace(@"--------------------------获取DetailViewController的内容为空-------------------------");
    }
    
    NSAssert(pcontentController != nil, @"found detailViewController is nill，，。。。in EEUIFactory");
//    else if(type == Modal_Type_Expert){
//        pcontentController = [[DetailArticle alloc] initWithNibName:@"DetailArticle" bundle:nil];
//    }else if(type == Modal_Type_Schedul){
//        pcontentController = [[DetailSchedule alloc] initWithNibName:@"DetailSchedule" bundle:nil];
//    }else if(type == Modal_Type_Favorite){
//        pcontentController = [[DetailArticle alloc] initWithNibName:@"DetailArticle" bundle:nil];
//    }
    
    return pcontentController;
}



@end
