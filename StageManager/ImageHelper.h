//
//  ImageHelper.h
//  StageManager
//
//  Created by Matej Kobza on 5/10/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"

@interface ImageHelper : NSObject

-(NSArray*) getTitles;
-(NSArray*) getImages;
-(NSDictionary*) getMenuItems;
-(Image*) imageAtIndex:(int) index;

@end
