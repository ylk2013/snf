//
//  Globel.m
//  FruitsGame
//
//  Created by Yu on 11-6-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Global.h"

@implementation Global

@synthesize leftmodalctr,rightfiterctr,applistviewcontroller,lookquickstr,rootController,focusViewController;


+(Global *)shareGlobel{
    static Global *instance = nil;
    @synchronized(self){
        if (!instance) {
            instance = [[Global alloc] init];
        }
    }
    
    return instance;
}


-(id)init{
    if (self == [super init]) {
    }
    return self;
}

-(void)disponse{
}
@end
