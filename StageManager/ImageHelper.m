//
//  ImageHelper.m
//  StageManager
//
//  Created by Matej Kobza on 5/10/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "ImageHelper.h"
#import "Image.h"

@interface ImageHelper()

@end

@implementation ImageHelper

NSArray *core_images;
NSMutableArray *titles;
NSMutableArray *images;
NSMutableDictionary *menuDictionary;

-(id) init
{
    self = [super init];
    if(self) {
        titles = [[NSMutableArray alloc] init];
        images = [[NSMutableArray alloc] init];
        menuDictionary = [[NSMutableDictionary alloc] init];
        core_images = [[NSArray alloc] initWithObjects:
                       [[Image alloc] initWithTitle:@"Red Electric Guitar" andImageName:@"el-guit-red"],
                       [[Image alloc] initWithTitle:@"Swing Electric Guitar" andImageName:@"el-guit-red1"],
                       [[Image alloc] initWithTitle:@"Black Electric Guitar" andImageName:@"el-guit-black"],
                       [[Image alloc] initWithTitle:@"Black Classic Guitar" andImageName:@"wood-guit-black"],
                       [[Image alloc] initWithTitle:@"Classic Guitar" andImageName:@"wood-guit-yellow"],
                       [[Image alloc] initWithTitle:@"Microphone" andImageName:@"microphone"],
                       [[Image alloc] initWithTitle:@"High Microphone" andImageName:@"microphone1"],
                       [[Image alloc] initWithTitle:@"Saxaphone" andImageName:@"saxaphone"],
                       [[Image alloc] initWithTitle:@"Violin" andImageName:@"violin"],
                       [[Image alloc] initWithTitle:@"Small Drums" andImageName:@"drums"],
                       [[Image alloc] initWithTitle:@"Big Drums" andImageName:@"drums1"],
                       [[Image alloc] initWithTitle:@"Piano" andImageName:@"piano"],
                       [[Image alloc] initWithTitle:@"Monitor" andImageName:@"monitor"],
                       nil];
        for (Image* image in core_images) {
            NSMutableString* imageURL = [[NSMutableString alloc] initWithString:image.imageName];
            [imageURL appendString:@".png"];
            image.image = [UIImage imageNamed:imageURL];
            
            NSMutableString* imageMenuURL = [[NSMutableString alloc] initWithString:image.imageName];
            [imageMenuURL appendString:@"-menu.png"];
            image.menuIcon = [UIImage imageNamed:imageMenuURL];
            
#ifdef DEBUG
            NSLog(@"The image title is %@", image.title);
            NSLog(@"The image location %@", image.image);
            NSLog(@"The menu image location %@", image.menuIcon);
#endif
            [titles addObject:image.title];
            [images addObject:image.image];
            [menuDictionary setObject:image.menuIcon forKey:image.title];
        }
    }
    return self;
}

-(NSArray*) getTitles
{
    return titles;
}

-(NSArray*) getImages
{
    return images;
}

-(NSDictionary*) getMenuItems
{
    return menuDictionary;
}

-(Image*) imageAtIndex:(int) index
{
    return core_images[index];
}

@end
