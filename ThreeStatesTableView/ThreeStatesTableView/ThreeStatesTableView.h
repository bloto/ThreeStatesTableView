//
//  ThreeStatesTableView.h
//  ThreeStatesTableView
//
//  Created by Tomasz Zablocki (skalamandra@gmail.com) on 31/08/2012.
//  Copyright (c) 2012. All rights granted.
//
#import <UIKit/UIKit.h>

@interface ThreeStatesTableView : UIView
{
	UIView	 *header;
	UIView	 *footer;
    NSInteger lastSelectedIndexPathRow;
}
@property(strong, readwrite) UITableView *tableView;

- (id)initWithFrame:(CGRect)frame withHeaderTitle:(NSString *)headerTitle andFooterButtons:(NSArray *)buttons withHeaderOfSize:(CGFloat)headerPercentage andFooterOfSize:(CGFloat)footerPercentage;

- (UITableViewCell *)prepareCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end



