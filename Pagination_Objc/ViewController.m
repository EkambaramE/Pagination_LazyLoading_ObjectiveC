//
//  ViewController.m
//  Pagination_Objc
//
//  Created by Ekambaram on 19/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerCell.h"
#import "FoodDrink.h"
#import "PGActivityIndicatorView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController () {
    PGActivityIndicatorView *activityView;
}

@end

@implementation ViewController

static int pageNumber = 0;

+ (void) setPageNumber : (int) value {
    pageNumber = value;
}

+ (int) getPageNumber {
    
    return pageNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"ViewControllerCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"cell"];
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.foodDrinksFields = [[FoodDrinksFields alloc]init];
    self.foodDrinksWrapper = [[FoodDrinksWrapper alloc]init];
    [self addActivityIndicator];
    self.isLoadingSpecies = false;
    [self loadFirstSpecies];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 * loadFirstSpecies
 */

-(void)loadFirstSpecies {
    
    NSString *url = @"http://apis-development.fizz.in/hangouts/13.0375051/80.2387716/food-and-drink/1/10?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJGaXp6IGUtVmVudHVyZXMgUHZ0IEx0ZC4iLCJ1c2VySWQiOiI1NzZkMWE4MTI2NDk1MGU3NjM5NGZiMzMiLCJpYXQiOjE0NjgyMzQ4MDd9.ssCNouUOIfxG2H3nI7IkMdqffzL4l5cRkbwe3Xf3Uw4";
    
    self.isLoadingSpecies = true;
    [self showActivityIndicator:@"Loading..!"];
    [self.foodDrinksFields parseDataFromResponseObject:url completionAction:^(FoodDrinksWrapper *result) {
        [self addSpeciesFromWrapper:result];
        self.isLoadingSpecies = false;
        [self hideActivityIndicator];
        [self.tableView reloadData];
        
    }];
    
}

/**
 * loadMoreSpecies
 */

-(void) loadMoreSpecies {
    
    ViewController.pageNumber = ViewController.getPageNumber + 1;
    
    if (ViewController.getPageNumber < 150) {
        
        NSMutableString* aString = [NSMutableString stringWithFormat:@"http://apis-development.fizz.in/hangouts/13.0375051/80.2387716/food-and-drink/%d", ViewController.getPageNumber];
        
        NSString * url = [NSString stringWithFormat:@"%@/10?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJGaXp6IGUtVmVudHVyZXMgUHZ0IEx0ZC4iLCJ1c2VySWQiOiI1NzZkMWE4MTI2NDk1MGU3NjM5NGZiMzMiLCJpYXQiOjE0NjgyMzQ4MDd9.ssCNouUOIfxG2H3nI7IkMdqffzL4l5cRkbwe3Xf3Uw4", aString];
        
        self.isLoadingSpecies = true;
        [self showActivityIndicator:@"Loading..!"];
        [self.foodDrinksFields parseDataFromResponseObject:url completionAction:^(FoodDrinksWrapper *result) {
            
            [self addSpeciesFromWrapper:result];
            self.isLoadingSpecies = false;
        
            [self hideActivityIndicator];
            [self.tableView reloadData];
            
        }];
    }
}

-(void) addSpeciesFromWrapper :(FoodDrinksWrapper *) wrapper {
    
    self.foodDrinksWrapper = wrapper;
    
    if (self.foodDrinks == nil)
    {
        self.foodDrinks = self.foodDrinksWrapper.foodDrinks;
    }
    else if (self.foodDrinksWrapper != nil && self.foodDrinksWrapper.foodDrinks != nil)
    {
        
        for(int i = 0; i < 10; i++) {
            [self.foodDrinks addObject:self.foodDrinksWrapper.foodDrinks[i]];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section
    
    if (self.foodDrinks == nil)
    {
        return 0;
    }
    return self.foodDrinks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewControllerCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[ViewControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    FoodDrink * object = self.foodDrinks[indexPath.row];
    
    if (self.foodDrinks != nil && self.foodDrinks.count >= indexPath.row)
    {
        
        if (self.foodDrinksWrapper.count > 0) {
            cell.area.text = [object valueForKey:@"area"];
            cell.name.text = [object valueForKey:@"name"];
            cell.distance.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"latitude"]]; //Problem getting distanceFromUser thats why I showed dummy value
            
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:[object valueForKey:@"logo"]]
                              placeholderImage:nil
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         cell.titleImageView.image = image;
                                         
                                     }];
           
            [cell.bannerImageView sd_setImageWithURL:[NSURL URLWithString:[object valueForKey:@"heroImage"]]
                                   placeholderImage:nil
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              cell.bannerImageView.image = image;
                                              
                                          }];
            
        }
        
        // See if we need to load more pages
        
        int rowsToLoadFromBottom = 5;
        NSUInteger rowsLoaded = [self.foodDrinks count];
        
        if (!self.isLoadingSpecies && (indexPath.row >= (rowsLoaded - rowsToLoadFromBottom)))
        {
            NSUInteger totalRows = 0;
            
            if (self.foodDrinksWrapper != nil) {
                totalRows = 140;
            }
            
            NSUInteger remainingSpeciesToLoad = totalRows - rowsLoaded;
            
            if (remainingSpeciesToLoad > 0)
            {
                [self loadMoreSpecies];
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330.0;
}

/**
 *  Activity Indicator
 */

- (void)addActivityIndicator
{
    if (activityView == nil) {
        activityView = [[PGActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:activityView];
    }
    
    
}

-(void)showActivityIndicator:(NSString *)loadingString{
    [self.view bringSubviewToFront:activityView];
    [activityView
     startAnimating:loadingString withBlockAction:nil];
}

-(void)hideActivityIndicator{
    [activityView stopAnimating:nil];
    [self.view sendSubviewToBack:activityView];
}


@end
