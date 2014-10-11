//
//  MovableViewController.m
//  StageManager
//
//  Created by Jakub Vallo on 5/2/13.
//  Modified by Matej Kobza.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "MovableViewController.h"

@interface MovableViewController ()
{
    //int rotations;
}
@end

@implementation MovableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithTitle: (NSString *) pTitle andImageName: (NSString*) pImageName
{
    self = [super init];
    if(self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  	// Do any additional setup after loading the view.
    NSMutableString *imageName = [[NSMutableString alloc] initWithString:[[self image] imageName]];
    [imageName appendString:@".png"];
    _imageDefault = [UIImage imageNamed:imageName];
    [imageName setString:[[self image] imageName]];
    [imageName appendString:@"-selected.png"];
    _imageSelected = [UIImage imageNamed:imageName];
    [self imageView].image = [self imageDefault];
    [imageName setString:[[self image] imageName]];
    [imageName appendString:@"-volume.png"];
    _imageVolumeUp = [UIImage imageNamed:imageName];
    [imageName setString:[[self image] imageName]];
    [imageName appendString:@"-volume.png"];
    _imageVolumeDown = [UIImage imageNamed:imageName];
    [imageName setString:[[self image] imageName]];
    [imageName appendString:@"-notify.png"];
    _imageNotifying = [UIImage imageNamed:imageName];
    
    _imageBaseDefault = _imageDefault;
    _imageBaseSelected = _imageSelected;
    
    //rotations = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons callings

-(UIImage*) changeSizeofImage:(UIImage*) image toWidth:(CGFloat) width andHeight:(CGFloat) height{
    
    UIImage *tempImage = image;
    UIImage *targetImage = [[UIImage alloc] init];
    
    CGSize targetSize = CGSizeMake(width,height);
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectMake(0.0, 0.0, 0.0, 0.0);
    thumbnailRect.origin = CGPointMake(0.0,0.0);
    
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    
    [tempImage drawInRect:thumbnailRect];
    targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return targetImage;
}

- (void) makeBiggerImage
{
#ifdef DEBUG
    NSLog(@"MovableViewController#makeBiggerImage");
#endif
    CGFloat width = (_imageView.image.size.width * 1.05);
    CGFloat height = (_imageView.image.size.height * 1.05);
    if (height > _imageBaseDefault.size.height) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot make bigger!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        _imageView.image = [self changeSizeofImage:_imageBaseSelected toWidth:width andHeight:height];
        _imageSelected = [self changeSizeofImage:_imageBaseSelected toWidth:width andHeight:height];
        _imageDefault = [self changeSizeofImage:_imageBaseDefault toWidth:width andHeight:height];
    }
}

- (void) makeSmallerImage
{
#ifdef DEBUG
    NSLog(@"MovableViewController#makeSmallerImage");
#endif
    CGFloat width = (_imageView.image.size.width * 0.95);
    CGFloat height = (_imageView.image.size.height * 0.95);
    if (height < 150.0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot make smaller!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        _imageView.image = [self changeSizeofImage:_imageBaseSelected toWidth:width andHeight:height];
        _imageSelected = [self changeSizeofImage:_imageBaseSelected toWidth:width andHeight:height];
        _imageDefault = [self changeSizeofImage:_imageBaseDefault toWidth:width andHeight:height];
    }
}

- (void) rotate
{
#ifdef DEBUG
    NSLog(@"MovableViewController#rotate");
#endif
    //TODO
    /*
     rotations++;
     [self.view setTransform:CGAffineTransformRotate(self.view.transform, M_PI/18)];
     //    [self.view setBackgroundColor:[UIColor yellowColor]];
     if (rotations==36) {
     rotations = 0;
     //        [self.view setBackgroundColor:[UIColor clearColor]];
     }
     */
}

- (void) reset
{
#ifdef DEBUG
    NSLog(@"MovableViewController#reset");
#endif
    _imageView.image = _imageBaseSelected;
    _imageSelected = _imageBaseSelected;
    _imageDefault = _imageBaseDefault;
    /*
     while (rotations>0) {
     [self rotate];
     }
     */
}

#pragma mark - State Change Events
- (void) changeStateSelected
{
    if(_imageBaseSelected) {
        [self imageView].image = _imageSelected;
    }
}

- (void) changeStateDefault
{
    if(_imageBaseDefault) {
        [self imageView].image = _imageDefault;
    }
}

- (void) changeStateVolumeUp
{
    if(_imageVolumeUp) {
        [self imageView].image = _imageVolumeUp;
    }
}

- (void) changeStateVolumeDown
{
    if(_imageVolumeDown) {
        [self imageView].image = _imageVolumeDown;
    }
}

- (void) changeStateNotifying
{
    if(_imageNotifying) {
        [self imageView].image = _imageNotifying;
    }
}


@end
