//
//  Globel.h
//  FruitsGame
//
//  Created by Yu on 11-6-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

@class LeftModalCtr;
@class RIghtFiterCtr;
@class AppListViewController;
@class LookQuickCtr;
@class LiteMettingViewController;
@class FocusViewController;


@interface Global : NSObject {
    LeftModalCtr *leftmodalctr;
    RIghtFiterCtr *rightfiterctr;
    AppListViewController *applistviewcontroller;
    LookQuickCtr *lookquickstr;
    LiteMettingViewController *rootController;
    FocusViewController *focusViewController;
}

@property(nonatomic,retain)LeftModalCtr *leftmodalctr;
@property(nonatomic,retain)RIghtFiterCtr *rightfiterctr;
@property(nonatomic,retain)AppListViewController *applistviewcontroller;
@property(nonatomic,retain)LookQuickCtr *lookquickstr;
@property(nonatomic,retain)LiteMettingViewController *rootController;
@property(nonatomic,retain)FocusViewController *focusViewController;

+(Global *)shareGlobel;

-(void)disponse;

@end
