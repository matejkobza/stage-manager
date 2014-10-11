//
//  ButtonsViewDelegate.h
//  StageManager
//
//  Created by Jakub Vallo on 6/5/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ButtonsViewDelegate <NSObject>
- (void)buttonClicked:(UIButton*)button inView:(UIView*)view;
@end
