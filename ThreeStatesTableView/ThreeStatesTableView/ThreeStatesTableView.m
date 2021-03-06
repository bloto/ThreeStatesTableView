//
//  ThreeStatesTableView.m
//  ThreeStatesTableView
//
//  Created by Tomasz Zablocki (skalamandra@gmail.com) on 31/08/2012.
//  Copyright (c) 2012. All rights granted.
//
#import "ThreeStatesTableView.h"
#import <QuartzCore/QuartzCore.h>

// in points
#define MARGIN 10.0f

@implementation ThreeStatesTableView

@synthesize header;
@synthesize headerFrame;
@synthesize lineView;
@synthesize lineViewFrame;
@synthesize tableViewContainer;
@synthesize contentFrame;
@synthesize tableView;
@synthesize tableViewFrame;
@synthesize footer;
@synthesize footerFrame;
@synthesize lastSelectedIndexPathRow;

// buttons are needed at this stage since I want to reposition them correctly
- (id)initWithFrame:(CGRect)frame withHeaderTitle:(NSString *)headerTitle headerButtons:(NSArray *)headerButtons andFooterButtons:(NSArray *)footerButtons withHeaderOfSize:(CGFloat)headerPercentage andFooterOfSize:(CGFloat)footerPercentage;
{
	if (!(self = [super init]))
	{
		return nil;
	}
	self.frame = frame;
	
	// calculate frames per header, content and footer,
	headerFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height * headerPercentage);
	contentFrame = CGRectMake(frame.origin.x, frame.origin.y + headerFrame.size.height , frame.size.width, frame.size.height - frame.size.height * headerPercentage - frame.size.height * footerPercentage);
	tableViewFrame = CGRectMake(MARGIN, 0 , contentFrame.size.width - 2 * MARGIN, contentFrame.size.height);
	footerFrame = CGRectMake(frame.origin.x, frame.origin.y + headerFrame.size.height + contentFrame.size.height, frame.size.width, frame.size.height * footerPercentage);
    
	// create main elements
	header = [[UIView alloc] initWithFrame:headerFrame];
	if (header == nil)
	{
		return nil;
	}
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerFrame];
	[titleLabel setText:headerTitle];
	titleLabel.textAlignment =  UITextAlignmentCenter;
	titleLabel.textColor = [UIColor colorWithRed:TITLE_RED green:TITLE_GREEN blue:TITLE_BLUE alpha:1.0f];
	titleLabel.backgroundColor = [UIColor blackColor];
    
	titleLabel.font = [UIFont fontWithName:@"Courier" size:(headerFrame.size.height/3)];
	[titleLabel adjustsFontSizeToFitWidth];
	[header addSubview:titleLabel];
    lineViewFrame = CGRectMake(headerFrame.origin.x + MARGIN, headerFrame.origin.y + headerFrame.size.height - 2, headerFrame.size.width - 2 * MARGIN, 1);
	lineView = [[UIView alloc] initWithFrame:lineViewFrame]; 
	lineView.backgroundColor = [UIColor grayColor];
	[header addSubview:lineView];
    
	tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
	if (tableView == nil)
	{
		return nil;
	}
	tableView.backgroundColor = [UIColor clearColor];
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.frame = frame;
	gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:FROM_RED green:FROM_GREEN blue:FROM_BLUE alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:TO_RED green:TO_GREEN blue:TO_BLUE alpha:1.0f] CGColor], nil]; 
	[gradientLayer setLocations:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:1.0f], nil]];
	//[tableView.layer addSublayer:gradientLayer];
	[self.layer addSublayer:gradientLayer];
	[tableView setSeparatorColor:[UIColor darkGrayColor]];
	[tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];

	[tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0,0,0,-MARGIN)];
	[tableView setClipsToBounds:NO];

	tableViewContainer = [[UIView alloc] initWithFrame:contentFrame];
	if (tableViewContainer == nil)
	{
		return nil;
	}
	// This one will be clipped
	[tableViewContainer addSubview:tableView];
	[tableViewContainer setClipsToBounds:YES];

	footer = [[UIView alloc] initWithFrame:footerFrame];
	if (footer == nil)
	{
		return nil;
	}
	UIView *secondLineView = [[UIView alloc] initWithFrame:CGRectMake(headerFrame.origin.x + MARGIN, footerFrame.origin.y+1, headerFrame.size.width - 2 * MARGIN, 1)]; 
	secondLineView.backgroundColor = [UIColor grayColor];
	[header addSubview:secondLineView];

	// these buttons are designed to be square images
	int buttonWidthSpace = headerFrame.size.height * 0.7;
	int initialXPosition = tableViewFrame.origin.x + tableViewFrame.size.width - buttonWidthSpace;
	for (UIButton* button in headerButtons)
	{
		[button setFrame:CGRectMake(initialXPosition, headerFrame.size.height * 0.15, buttonWidthSpace, buttonWidthSpace)];
		[[button layer] setCornerRadius:5.0f];
		[button setClipsToBounds:YES];
		initialXPosition -= buttonWidthSpace + headerFrame.size.height * 0.15;
		[header addSubview:button];
	}
	
	// position buttons in the right places
	int buttonsCnt = [footerButtons count];
	buttonWidthSpace = footerFrame.size.width / buttonsCnt;
	initialXPosition = 0;
	for (UIButton* button in footerButtons)
	{
		[button setFrame:CGRectMake(initialXPosition + buttonWidthSpace/6, footerFrame.size.height/4, buttonWidthSpace/1.5, footerFrame.size.height/2)];

		[button.titleLabel setFont:[UIFont fontWithName:@"Courier" size:footerFrame.size.height/4]];
		[button setBackgroundImage:[UIImage imageNamed:@"ButtonBackgroundNormal"] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"ButtonBackgroundHighlighted"] forState:UIControlStateHighlighted];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
		[[button layer] setCornerRadius:5.0f];
		[button setClipsToBounds:YES];
		initialXPosition += buttonWidthSpace;
		[footer addSubview:button];
	}
	
	self.backgroundColor = [UIColor colorWithRed:TO_RED green:TO_GREEN blue:TO_BLUE alpha:1.0f];

	[self addSubview:header];
	[self addSubview:tableViewContainer];
	[self addSubview:footer];

	return self;	
}

- (UITableViewCell *)prepareCellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
        [selectedView setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:0.3f]];
        [cell setSelectedBackgroundView:selectedView];
    }
    int cellHeight = tableView.frame.size.height/4.0f;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont fontWithName:@"Courier" size:(cellHeight/3)];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Courier" size:(cellHeight/5)];
    
    if (lastSelectedIndexPathRow == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"IconSelected.png"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"IconEmpty.png"];
    }
    
    UIImage *image = [UIImage imageNamed:@"IconStar.png"];
    UIView *imageView = [[UIImageView alloc] initWithImage:image];
    
    // icons are square
    imageView.bounds = CGRectMake(0, 0, cellHeight, cellHeight);
    cell.accessoryView = imageView;
    return cell;
}

- (UITableViewCell *)prepareNoReusableCellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedView setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:0.3f]];
    [cell setSelectedBackgroundView:selectedView];
    int cellHeight = tableView.frame.size.height/4.0f;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont fontWithName:@"Courier" size:(cellHeight/3)];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Courier" size:(cellHeight/5)];
    
    if (lastSelectedIndexPathRow == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"IconSelected.png"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"IconEmpty.png"];
    }
    
    UIImage *image = [UIImage imageNamed:@"IconStar.png"];
    UIView *imageView = [[UIImageView alloc] initWithImage:image];
    
    // icons are square
    imageView.bounds = CGRectMake(0, 0, cellHeight, cellHeight);
    cell.accessoryView = imageView;
    return cell;
}


- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (lastSelectedIndexPathRow != indexPath.row)
     {
         [[tableView cellForRowAtIndexPath:indexPath] imageView].image = [UIImage imageNamed:@"IconSelected.png"];
         NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:lastSelectedIndexPathRow inSection:0];
         [[tableView cellForRowAtIndexPath:tmpIndexPath] imageView].image = [UIImage imageNamed:@"IconEmpty.png"];
         lastSelectedIndexPathRow = indexPath.row;
     }
}
     
@end
