//
//  ThreeStatesTableView.h
//  ThreeStatesTableView
//
//  Created by Tomasz Zablocki (skalamandra@gmail.com) on 31/08/2012.
//  Copyright (c) 2012. All rights granted.
//
#import <UIKit/UIKit.h>

#define FROM_RED 0.0f
#define FROM_GREEN 0.0f
#define FROM_BLUE 0.0f
#define TO_RED 0.0f
#define TO_GREEN 0.0f
#define TO_BLUE 1.0f
#define TITLE_RED 0.9f
#define TITLE_GREEN 0.9f
#define TITLE_BLUE 0.6f

@interface ThreeStatesTableView : UIView
@property (readwrite, nonatomic) NSInteger lastSelectedIndexPathRow;
@property (strong, nonatomic) UIView *lineView;
@property (readwrite, nonatomic) CGRect lineViewFrame;
@property (strong, nonatomic) UIView *header;
@property (readwrite, nonatomic) CGRect headerFrame;

// this is to allow scroll indicator to be moved out of tableView space
@property (strong, nonatomic) UIView *tableViewContainer;
@property (readwrite, nonatomic) CGRect contentFrame;
@property (strong, nonatomic) UITableView *tableView;
@property (readwrite, nonatomic) CGRect tableViewFrame;
@property (strong, nonatomic) UIView *footer;
@property (readwrite, nonatomic) CGRect footerFrame;

- (id)initWithFrame:(CGRect)frame withHeaderTitle:(NSString *)headerTitle headerButtons:(NSArray *)headerButtons andFooterButtons:(NSArray *)footerButtons withHeaderOfSize:(CGFloat)headerPercentage andFooterOfSize:(CGFloat)footerPercentage;

- (UITableViewCell *)prepareCellForRowAtIndexPath:(NSIndexPath *)indexPath;

// might be used in case every row is different, then it doesn't make sense to find reusable cell
- (UITableViewCell *)prepareNoReusableCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end



