//
//  Image.h
//  StageManager
//
//  Created by Matej Kobza on 5/10/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) UIImage *image;
@property (nonatomic, weak) UIImage *menuIcon;
@property (nonatomic, weak) NSString *imageName;

-(id) initWithTitle: (NSString*) pTitle andImage: (UIImage*) pImage andMenuIcon: (UIImage*) pMenuIcon;

-(id) initWithTitle: (NSString*) pTitle andImageName: (NSString*) pImageName;

@end
