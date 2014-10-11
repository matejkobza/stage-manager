//
//  DetailViewController.m
//  StageManager
//
//  Created by Tomas Cejka on 4/11/13.
//  Modified by Matej Kobza.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "DetailViewController.h"
#import "MovableViewController.h"
#import "ImageHelper.h"
#import "Image.h"

@interface DetailViewController ()
{
    BOOL shouldDeselect;
}
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMoveAround:)];
    //[_panGesture setMaximumNumberOfTouches:2];
    [_panGesture setDelegate:self];
    [self.view addGestureRecognizer:_panGesture];
    
    // setup controlButtonsController
    buttonsController = [[ButtonsViewController alloc] init];
    buttonsController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ButtonsViewController"];
    [buttonsController view].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    isButtonsControllerrEnabled = YES;
    [self hideButtons];

    CGFloat x = [[self view] frame].size.width/2;
    NSLog(@"Center x=%f",[[self view] center].x);
    NSLog(@"Width=%f",[[self view] frame].size.width);
    [[buttonsController view] setCenter: CGPointMake(x, 70)];
    
    buttonsController.delegate = self;
    
    [[self view] addSubview:buttonsController.view];
    
    // setup volumeViewController
    volumeController = [[VolumeViewController alloc] init];
    volumeController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"VolumeViewController"];
    
    selectingMyInstrument = NO;
    selectionsDisabled = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image view

-(void) addInstrument:(Image*) instrument
{
#ifdef DEBUG
    NSLog(@"DetailViewController#addInstrument");
#endif
    MovableViewController *movableViewController = [[MovableViewController alloc] init];
    movableViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MovableViewController"];
    movableViewController.title = instrument.title;
    movableViewController.image = instrument;
    movableViewController.sender = self;
    UIImageView *view = (UIImageView*)movableViewController.view;
    int width = instrument.image.size.width;
    int height = instrument.image.size.height;
    
#ifdef DEBUG
    NSLog(@"Width and height of inserted image: [%d,%d]", width, height);
#endif
    view.frame = CGRectMake(0, 0, width, height);
    view.center = CGPointMake([[self view] center].x, [[self view] center].y);

    
    if(!instrumentsViewControllers) {
        instrumentsViewControllers = [[NSMutableArray alloc] init];
    }
    
    [instrumentsViewControllers addObject:movableViewController];
    [self.view addSubview: view];
}

-(void) removeInstrument:(MovableViewController *)instrumentController
{
#ifdef DEBUG
    NSLog(@"DetailViewController#removeInstrument");
#endif
    [instrumentsViewControllers removeObject:instrumentController];
    [instrumentController.view removeFromSuperview];
    [self hideButtons];
}

-(void) backwardInstrument:(MovableViewController*) instrumentController
{
    [instrumentsViewControllers removeObject:instrumentController];
    [instrumentsViewControllers insertObject:instrumentController atIndex:0];
}

-(void) forwardInstrument:(MovableViewController*) instrumentController
{
    [instrumentsViewControllers removeObject:instrumentController];
    [instrumentsViewControllers addObject:instrumentController];
}

- (void) moveSelectedInstrumentForward:(MovableViewController*) instrumentController
{
#ifdef DEBUG
    NSLog(@"DetailViewController#moveInstrumentForward");
#endif
    // selected instrument move forward
    if([instrumentsViewControllers containsObject:instrumentController]) {
        [self.view addSubview:(UIImageView*)instrumentController.view];
    }
}
/*
- (void) moveDeselectedInstrumentBackward:(MovableViewController*) instrumentController
{
#ifdef DEBUG
    NSLog(@"DetailViewController#moveInstrumentBackward");
#endif
    if([instrumentsViewControllers containsObject:instrumentController]) {
        [self.view addSubview:(UIImageView*)instrumentController.view];
    }
    // put all other instruments above the selected one in corect order
    for (int i=0; i < instrumentsViewControllers.count; i++) {
        if(instrumentsViewControllers[i] != instrumentController) {
            UIView* view;
            view = ((MovableViewController*)instrumentsViewControllers[i]).view;
            [self.view addSubview: view];
        }
    }
}
*/
- (void) selectInstrument:(MovableViewController*) instrumentController
{
    if (selectionsDisabled) return;
    
    if (selectingMyInstrument) {
        [instrumentController.view setAlpha:0.5f];
        myInstrument = instrumentController;
        selectingMyInstrument = NO;
        return;
    }

    if (instrumentController==myInstrument) {
        return;
    }

#ifdef DEBUG
    NSLog(@"DetailViewController#selectInstrument: %@", instrumentController.title);
#endif
    if(selectedInstrumentController != nil) {
        [self hideButtons];
    }
    [self showButtons];
    selectedInstrumentController = instrumentController;
    [self moveSelectedInstrumentForward:selectedInstrumentController];
    [self showButtons];
    [selectedInstrumentController changeStateSelected];
    
    if (myInstrument) {
        [self.view addSubview:volumeController.view];
        
        // buttons on instrument
//        CGRect f1 = selectedInstrumentController.view.frame;
//        CGRect f2 = volumeController.view.frame;
//        f1.origin.x += (f1.size.width-f2.size.width)/2;
//        f1.origin.y += (f1.size.height-f2.size.height)/2;
//        f1.size = f2.size;
//        [volumeController.view setFrame:f1];
        
        //buttons in right top corner
        CGRect r = volumeController.view.frame;
        r.origin.x = self.view.frame.size.width - r.size.width - 20;
        r.origin.y = 20;
        [volumeController.view setFrame:r];
    }
}

- (void) deselectInstrument
{
#ifdef DEBUG
    NSLog(@"DetailViewController#deselectInstrument %@", selectedInstrumentController.title);
#endif
    if (selectedInstrumentController != nil) {
        [self hideButtons];
        [selectedInstrumentController changeStateDefault];
        selectedInstrumentController = nil;

    }
    for (MovableViewController *instrumentController in instrumentsViewControllers) {
        [self moveSelectedInstrumentForward:instrumentController];
    }
    [volumeController.view removeFromSuperview];
}

#pragma mark - Image Check

- (BOOL)pointAtTransparentArea:(CGPoint)point in:(MovableViewController*)instrumentController
{
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 1, NULL, kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    CGFloat x = [[instrumentController imageView] frame].origin.x;
    CGFloat leftMargin = [[instrumentController view] frame].origin.x;
    CGFloat topMargin = [[instrumentController view] frame].origin.y;
    [instrumentController.imageView.image drawAtPoint:CGPointMake(-point.x + leftMargin + x, -point.y + topMargin)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0;
    BOOL transparent = alpha < 0.01;
    if(transparent){
#ifdef DEBUG
        NSLog(@"Touched point is in transparent area? YES");
#endif
        return YES;
    } else {
#ifdef DEBUG
        NSLog(@"Touched point is in transparent area? NO");
#endif
        return NO;
    }
}

#pragma mark - Gestures

-(void)panGestureMoveAround:(UIPanGestureRecognizer *)gesture;
{
#ifdef DEBUG
    NSLog(@"DetailViewController#panGestureMoveArround");
#endif
    
    //[self adjustAnchorPointForGestureRecognizer:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged) {
        if(selectedInstrumentController != nil) {
            UIView *movingView = selectedInstrumentController.view;
            CGPoint translation = [gesture translationInView:[gesture view].superview];
            NSLog(@"location: [%f,%f]", translation.x, translation.y);
            [movingView setCenter:CGPointMake([movingView center].x + translation.x, [movingView center].y + translation.y)];
            [gesture setTranslation:CGPointZero inView:[movingView superview]];
        }
        //        CGPoint translation = [gesture translationInView:[piece superview]];
        //        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y+translation.y*0.1)];
        //        [gesture setTranslation:CGPointZero inView:[piece superview]];
    } else if([gesture state] == UIGestureRecognizerStateEnded) {
        //Put the code that you may want to execute when the UIView became larger than certain value or just to reset them back to their original transform scale
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
#ifdef DEBUG
    NSLog(@"DetailViewController#touchesBegan");
#endif
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    MovableViewController *touchedInstrument = nil;
    for(MovableViewController *instrumentController in instrumentsViewControllers) {
        CGFloat minX = [[instrumentController view] frame].origin.x;
        CGFloat minY = [[instrumentController view] frame].origin.y;
        CGFloat maxX = minX + [[instrumentController view] frame].size.width;
        CGFloat maxY = minY + [[instrumentController view] frame].size.height;
        if(touchPoint.x >= minX && touchPoint.x <= maxX && touchPoint.y >= minY && touchPoint.y <= maxY) {
            // the touch point is in this movableViewController i need to put it above others
            if(![self pointAtTransparentArea:touchPoint in:instrumentController]) {
                touchedInstrument = instrumentController;
            }
        }
    }
    if(selectedInstrumentController == touchedInstrument) {
        shouldDeselect = YES;
    } else {
        shouldDeselect = NO;
    }
    
    if(selectedInstrumentController != nil) {
        [self deselectInstrument];
    }
    if (touchedInstrument != nil) {
        [self selectInstrument:touchedInstrument];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
#ifdef DEBUG
    NSLog(@"DetailViewController#touchesMoved: [%f,%f]", touchPoint.x, touchPoint.y);
#endif
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
#ifdef DEBUG
    NSLog(@"DetailViewController#touchesEnded");
#endif
    if(selectedInstrumentController != nil && shouldDeselect) {
        [self deselectInstrument];
    }
}

#pragma mark - Buttons
- (void) showButtons
{
    if (isButtonsControllerrEnabled)
        [buttonsController view].hidden = NO;
}

- (void) hideButtons
{
    if (isButtonsControllerrEnabled)
        [buttonsController view].hidden = YES;
}

- (void)buttonClicked:(UIButton *)button inView:(UIView *)view
{
#ifdef DEBUG
    NSLog(@"DetailViewController#buttonClicked: %@",button.titleLabel.text);
#endif
    if ([button.titleLabel.text isEqualToString:@"Remove"]) {
        [self removeInstrument:selectedInstrumentController];
    }
    if ([button.titleLabel.text isEqualToString:@"Reset"]) {
        [selectedInstrumentController reset];
    }
    if ([button.titleLabel.text isEqualToString:@"Backward"]) {
        [self backwardInstrument:selectedInstrumentController];
    }
    if ([button.titleLabel.text isEqualToString:@"Forward"]) {
        [self forwardInstrument:selectedInstrumentController];
    }
    if ([button.titleLabel.text isEqualToString:@"Rotate"]) {
        [selectedInstrumentController rotate];
    }
    if ([button.titleLabel.text isEqualToString:@"Smaller"]) {
        [selectedInstrumentController makeSmallerImage];
    }
    if ([button.titleLabel.text isEqualToString:@"Bigger"]) {
        [selectedInstrumentController makeBiggerImage];
    }
}

#pragma mark - Events

- (void) didReceiveNotificationFromClient:(BOOL) volumeUp from:(MovableViewController*)from to:(MovableViewController*)to
{
    
    CGRect f1 = to.view.frame;
    f1.origin.x = self.view.frame.size.width  - 170;
    f1.origin.y = 20;
    f1.size.width = 150;
    f1.size.height = 150;

    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:f1];
    
    
    [self.view addSubview:imgView];
    
    if (volumeUp) {
        NSArray *animup = [NSArray arrayWithObjects:[UIImage imageNamed:@"server-volume-up-state-1"],[UIImage imageNamed:@"server-volume-up-state-0"], nil];
        [imgView setAnimationImages:animup];
        

    } else {
        NSArray *animdown = [NSArray arrayWithObjects:[UIImage imageNamed:@"server-volume-down-state-1"],[UIImage imageNamed:@"server-volume-down-state-0"], nil];
        [imgView setAnimationImages:animdown];
        

    }
    
    [imgView setAnimationDuration:1.2];
    [imgView setAnimationRepeatCount:0];
    [imgView startAnimating];
    
    
//    selectionsDisabled = NO;
//    [self selectInstrument:from];
//    selectionsDisabled = YES;
    [from changeStateNotifying];
    if (volumeUp)
        [to changeStateVolumeUp];
    else
        [to changeStateVolumeDown];
    
    for (int i=0; i<10; i++) {
        if (i%2==0)
        {
            if (volumeUp)
                [to performSelector:@selector(changeStateVolumeUp) withObject:nil afterDelay:(float)i*0.6];
            else
                [to performSelector:@selector(changeStateVolumeDown) withObject:nil afterDelay:(float)i*0.6];
            [from performSelector:@selector(changeStateDefault) withObject:nil afterDelay:(float)i*0.6];
        }
        else{
            [to performSelector:@selector(changeStateDefault) withObject:nil afterDelay:(float)i*0.6];
            
            [from performSelector:@selector(changeStateNotifying) withObject:nil afterDelay:(float)i*0.6];
        }

    }
    
    [from performSelector:@selector(changeStateDefault) withObject:nil afterDelay:6.1];
    [to performSelector:@selector(changeStateDefault) withObject:nil afterDelay:6.1];
    [imgView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:6.0];

//    [self performSelector:@selector(deselectInstrument) withObject:nil afterDelay:6.0];
}



@end