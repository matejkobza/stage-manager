//
//  Image.m
//  StageManager
//
//  Created by Matej Kobza on 5/10/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "Image.h"

@implementation Image

@synthesize title = _title;
@synthesize image = _image;
@synthesize menuIcon = _menuIcon;
@synthesize imageName = _imageName;

-(id)initWithTitle:(NSString *)pTitle andImage:(UIImage *)pImage andMenuIcon:(UIImage *)pMenuIcon
{
    self = [super init];
    if(self) {
        _title = pTitle;
        _image = pImage;
        _menuIcon = pMenuIcon;
    }
    return self;
}

-(id)initWithTitle:(NSString *)pTitle andImageName:(NSString *) pImageName
{
    self = [super init];
    if (self) {
        _title = pTitle;
        _imageName = pImageName;
    }
    return self;
}

@end
