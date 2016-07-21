//
//  FoodDrinksWrapper.h
//  Pagination_Objc
//
//  Created by EkambaramE on 20/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//


#import <UIKit/UIKit.h>
/**
 *  TypeDef for BlockActivityAction
 */
typedef void (^BlockActivityAction)(void);
/**
 *  This class is a subclass of UIView .This is a commonClass for activity Indicator View inside Application 
 */
@interface PGActivityIndicatorView : UIView
{
    /**
     *  ActivityIndicatorView
     */
    UIActivityIndicatorView *activityIndicator;
    /**
     *  Activitylabel
     */
    UILabel *labelActivity;

}
/**
 *  Property Variables for StopActivityBlock,ActivityLabel,activityIndicator
 */
@property(nonatomic, copy) BlockActivityAction stopActivityAction;
@property(nonatomic, retain) UILabel *labelActivity;
@property(nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property(assign)            BOOL isAnimating;//SPHONE-9905
/**
 *  Method used while activityView is Animating
 *
 *  @param displayText NSString used as activityView Display Label
 *  @param startAction Block
 */
- (void)startAnimating:(NSString *)displayText withBlockAction:(BlockActivityAction)startAction alpha:(CGFloat)alphaValue;

- (void)startAnimating:(NSString *)displayText withBlockAction:(BlockActivityAction)startAction;
/**
 *  Method used while activityView stops Animating
 *
 *  @param stopAction Block
 */
- (void)stopAnimating:(BlockActivityAction)stopAction;


@end
