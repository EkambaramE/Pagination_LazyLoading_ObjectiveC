//
//  ViewController.h
//  Pagination_Objc
//
//  Created by Ekambaram on 19/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodDrinksFields.h"
#import "FoodDrinksWrapper.h"


@interface ViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (assign) Boolean isLoadingSpecies;
@property (strong, nonatomic) FoodDrinksFields *foodDrinksFields;
@property (strong, nonatomic) FoodDrinksWrapper *foodDrinksWrapper;
@property(nonatomic, strong) NSMutableArray<FoodDrink *> *foodDrinks;


@end

