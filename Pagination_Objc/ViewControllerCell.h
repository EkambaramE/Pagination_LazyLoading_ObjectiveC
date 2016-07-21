//
//  ViewControllerCell.h
//  Pagination_Objc
//
//  Created by Ekambaram on 19/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UILabel *distance;


@end
