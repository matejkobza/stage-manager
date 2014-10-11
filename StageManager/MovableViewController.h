//
//  MovableViewController.h
//  StageManager
//
//  Created by Jakub Vallo on 5/2/13.
//  Modified by Matej Kobza.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "Image.h"

@interface MovableViewController : UIViewController {

}

@property (strong, nonatomic)IBOutlet UIImageView *imageView;
//@property (strong, nonatomic) UIImage *im;
@property (weak, nonatomic) DetailViewController *sender;
@property (strong, nonatomic) Image *image;

@property (strong, nonatomic) UIImage *imageDefault;
@property (strong, nonatomic) UIImage *imageBaseDefault;
@property (strong, nonatomic) UIImage *imageBaseSelected;

@property (strong, nonatomic) UIImage *imageSelected;
@property (strong, nonatomic) UIImage *imageVolumeUp;
@property (strong, nonatomic) UIImage *imageVolumeDown;
@property (strong, nonatomic) UIImage *imageNotifying;

- (void) changeStateSelected;
- (void) changeStateDefault;
- (void) changeStateVolumeUp;
- (void) changeStateVolumeDown;
- (void) changeStateNotifying;

- (void) reset;
- (void) rotate;
- (void) makeSmallerImage;
- (void) makeBiggerImage;

@end
