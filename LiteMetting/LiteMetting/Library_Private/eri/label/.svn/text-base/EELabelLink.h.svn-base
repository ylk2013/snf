//
//  EELabelLink.h
//  Libaray
//
//  Created by pai hong on 12-6-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class EELabelLink;

@protocol EELabelLinkDelegate <NSObject>
@required
- (void)eelabel:(EELabelLink *)eeLabel touchesWtihTag:(NSInteger)tag;
@end

@interface EELabelLink : UILabel{
    
    id <EELabelLinkDelegate> delegate;
}
@property (nonatomic, assign) id <EELabelLinkDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

@end
