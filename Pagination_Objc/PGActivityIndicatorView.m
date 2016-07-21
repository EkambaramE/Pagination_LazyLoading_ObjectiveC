//
//  FoodDrinksWrapper.h
//  Pagination_Objc
//
//  Created by EkambaramE on 20/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//


#import "PGActivityIndicatorView.h"

@interface PGActivityIndicatorView ()<UIGestureRecognizerDelegate>
{
    BOOL isDefaultSwipeNavigationEnabled;
}

@end

@implementation PGActivityIndicatorView
/**
 *  Synthesize variables
 */
@synthesize activityIndicator;
@synthesize labelActivity;


#define ACTIVITY_WIDTH      40
#define ACTIVITY_HEIGHT    40
#define ACTIVITY_LBLWIDTH  140

/**
 *  Initialize activity frame
 *  Initialize activityIndicator , set its frame,style,background color
 *  Initialize labelActivity,set its frame,style,background color
 *  Add as subviews of ActivityView
 *  @param frame CGRect values
 *
 *  @return self
 */

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.3f;
        //MOBILEDEV-3137
        
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,
                                        activityIndicator);
        labelActivity = [[UILabel alloc] init];
        
        activityIndicator = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		//ENV-8074
        //BEGIN: SPHONE- 8339-To display activity indicator at center | Subhashree
        
        
        // Indicator
       activityIndicator.frame = CGRectMake((CGRectGetWidth(self.frame) -  ACTIVITY_WIDTH) * 0.5f,CGRectGetHeight(self.frame) * 0.5f -  ACTIVITY_HEIGHT , ACTIVITY_WIDTH, ACTIVITY_HEIGHT); //SPHONE-9794
        
        labelActivity.frame = CGRectMake(self.frame.origin.x , activityIndicator.frame.origin.y+ +5, self.frame.size.width, 80);
        //BEGIN: SPHONE- 8339-To display activity indicator at center | Subhashree
        

        // Activity Label.
        labelActivity.textAlignment = NSTextAlignmentCenter;
        labelActivity.backgroundColor = [UIColor clearColor];
        [self addSubview:labelActivity];
        [labelActivity setHidden:YES];
        
        //Activity Indicator.
        activityIndicator.tag = 101;
        [activityIndicator startAnimating];
        [self addSubview:activityIndicator];
        activityIndicator.hidden = YES;
       
        self.hidden = YES;
    }
    return self;
}
/**
 *  Method use to start Animating activityView
 *  Set Hidden state of activityIndicator
 *  @param displayText NSString
 *  @param startAction Block
 */
- (void)startAnimating:(NSString *)displayText withBlockAction:(BlockActivityAction)startAction alpha:(CGFloat)alphaValue
{
    self.alpha = alphaValue;
    [self startAnimating:displayText withBlockAction:startAction];
}

- (void)startAnimating:(NSString *)displayText withBlockAction:(BlockActivityAction)startAction
{
    [self disableDefaultSwipeNavigation];
    //if its from crop image in photo module
    //SPHONE-2432
    //By Lakshmi Narayanan . N on 05/dec/2013
    //SPHONE-9905
    _isAnimating=YES;
    if([self tag] == 101) {
        [activityIndicator setCenter:[self center]];
    }
    //end SPHONE-2432
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    self.hidden = NO;
    
    //BEGIN: SPHONE - 10234
    if (displayText && ![displayText isEqualToString:@""]) {
        //Sizeof Warning fixed
        
        //SPHONE-10293
        labelActivity.text = displayText;
        labelActivity.hidden = NO;
        CGRect rectLabel = labelActivity.frame;
       
        labelActivity.frame = rectLabel;
    }
    //END: SPHONE - 10234

    if (startAction != nil)
    {
        startAction();
    }

}
/**
 *  Method used to stopAnimating activityView
 *  Hide Activity view ,indicator,Label
 *  @param stopAction Block
 */
- (void)stopAnimating:(BlockActivityAction)stopAction
{
    [self enableDefaultSwipeNavigation];
    //SPHONE-9905
    _isAnimating=NO;

    activityIndicator.hidden = YES;
    [activityIndicator stopAnimating];
    labelActivity.text = @"";
    labelActivity.hidden = YES;
    self.hidden = YES;
    if (stopAction != nil)
    {
        stopAction();
    }

}
/**
 *  To check if device model is iphone 5
 *
 *  @return BOOL value yes or no
 */
- (BOOL)isPhone5
{
    return  CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640, 1136));
}

//SPHONE-9749 - Issue SPHONE-8633 is also fixed along with SPHONE-9749
/**
 *  Called to layout views while orientation of device changes
 *  Set frame of activityIndicator and labelActivity
 */
-(void)layoutSubviews
{
        activityIndicator.frame = CGRectMake((CGRectGetWidth(self.frame) -  ACTIVITY_WIDTH) * 0.5f,CGRectGetHeight(self.frame) * 0.5f -  ACTIVITY_HEIGHT , ACTIVITY_WIDTH, ACTIVITY_HEIGHT); //SPHONE-9794
    
         labelActivity.frame = CGRectMake(self.frame.origin.x , activityIndicator.frame.origin.y+5, self.frame.size.width, 80);
        //SPHONE-8633-Begin
    //Sizeof Warning fixed
}

- (void) disableDefaultSwipeNavigation{
    UIViewController *parentController = [self findParentViewController];
    
    if (parentController && parentController.navigationController) {
        if (parentController.navigationController.interactivePopGestureRecognizer.enabled) {
            isDefaultSwipeNavigationEnabled = YES;
        }
        parentController.navigationController.interactivePopGestureRecognizer.delegate = nil;
        parentController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void) enableDefaultSwipeNavigation{
    UIViewController *parentController = [self findParentViewController];
    if (parentController && parentController.navigationController && isDefaultSwipeNavigationEnabled) {
        parentController.navigationController.interactivePopGestureRecognizer.delegate = self;
        parentController.navigationController.interactivePopGestureRecognizer.enabled = YES;
        isDefaultSwipeNavigationEnabled = NO;
    }
}

- (UIViewController *)findParentViewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}

@end
