//
//  DetailContentTainer.m
//  LiteMetting
//
//  Created by hong pai on 13-1-12.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "DetailContainer.h"
#import "UIView+EEExtras.h"
#import "LiteMettingViewController.h"
#import "PDetail.h"
#import "EEUIFactory.h"
#import "SubQuesViewController.h"

@interface DetailContainer ()

@end

@implementation DetailContainer

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil modalConfig:(NSMutableDictionary *)modalconfig contentConfig:(NSMutableDictionary *)detailconfig{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        modalConfig = [modalconfig retain];
        detailConfig = [detailconfig retain];
        
        //创建
        [self insertChildrenDetailViewController];
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
    // Do any additional setup after loading the view from its nib.
    [self managerGestureRecongnizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 手势管理 -
-(void)managerGestureRecongnizer{
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)];
    trace(@"%d",panGes.state);
    
    [self.view addGestureRecognizer:panGes];
    [panGes release];
}

-(void)handelPan:(UIPanGestureRecognizer *)gestureRecognizer{
    //获取平移手势对象在self.view的位置点，并将这个点作为self.aView的center,这样就实现了拖动的效果
    //CGPoint curPoint = [gestureRecognizer locationInView:[self.view viewWithTag:11]];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        lastRemenberPanPosition = [gestureRecognizer locationInView:[Global shareGlobel].rootController.view];
    }else if(gestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGPoint curPoint = [gestureRecognizer locationInView:[Global shareGlobel].rootController.view];
        
        float difx =  (curPoint.x - lastRemenberPanPosition.x);
        
        CGAffineTransform newTransform1 = CGAffineTransformTranslate(self.view.transform, difx, 0);
        
        //trace(@"------%f  %f   %f",self.view.frame.origin.x,newTransform1.tx , self.view.frame.origin.x + newTransform1.tx);
        
        if ((self.view.frame.origin.x + newTransform1.tx) <0) {
            CGRect rect = self.view.frame;
            rect.origin.x = 0;
            [self.view setFrame:rect];
        }else{
            
            lastRemenberPanPosition = curPoint;
            [self.view setTransform:newTransform1];
        }
        
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        [self ee_dragOver];
    }
    // [self.view setCenter:curPoint];
}

-(void)ee_dragOver{
    float  curx = self.view.frame.origin.x;
    
    if (curx>ee_AppSize.width*0.5) {
        [self ee_contentOut];
    }else{
        [self ee_contentIn];
    }
}


#pragma mark - 根据modalType 创建类型的detailController到DetailContainer里面来 -
-(void)insertChildrenDetailViewController{
    //得到detail
    oneDetailController = [[EEUIFactory getFactory] ee_getDetailControllerByModalConfig:modalConfig];
    trace(@"%@",oneDetailController);
    [oneDetailController.view setFrame:CGRectMake(0, ee_AppDetailControllerHeight, ee_AppSize.width, self.view.frame.size.height - ee_AppDetailControllerHeight)];
    [self.view addSubview:oneDetailController.view];
    
    [self.view sendSubviewToBack:oneDetailController.view];
    
    //给Cell 设置数据
    [oneDetailController ee_questDetail_ByCellConfig:detailConfig modalconfig:modalConfig];
}

#pragma mark - 创建 出现 消失 后退移除 -
//创建时候初始化
-(void)ee_initCreate{
    [self.view setFrame:CGRectMake(ee_AppSize.width, 0, ee_AppSize.width, ee_AppSize.height-ee_AppStatusHeight)];
}

-(void)ee_contentIn{
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

-(IBAction)clickReturn:(id)sender{
    [self ee_contentOut];
}

#pragma mark ----提问------
- (IBAction)onSubQues:(id)sender {
    SubQuesViewController * sqVC = [[SubQuesViewController alloc] initWithNibName:@"SubQuesViewController" bundle:nil andType:[modalConfig objectForKey:@"MarkID"]  andId:[detailConfig objectForKey:@"SID"]];
    [self.view addSubview:sqVC.view];
    [sqVC ee_contentIn];
}


-(void)dealloc{
    track();
    //回收oneDetailController
    [oneDetailController disponse];
    
    [modalConfig release];
    [detailConfig release];
    modalConfig = nil;
    detailConfig = nil;
    [super dealloc];
}
@end
