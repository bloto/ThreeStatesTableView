//
//  ViewController.m
//  ThreeStatesTableView
//
//  Created by Tomasz Zablocki (skalamandra@gmail.com) on 31/08/2012.
//  Copyright (c) 2012. All rights granted.
//

#import "ViewController.h"

@implementation ViewController

@synthesize button1;
@synthesize button2;
@synthesize button3;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create example ThreeStatesTableView
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    
    button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];    
    [button1 setTitle:@"Test1" forState:UIControlStateNormal];
    [button1 setTitle:@"Press" forState:UIControlStateHighlighted];
    
    button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setTitle:@"Test2" forState:UIControlStateNormal];
    [button2 setTitle:@"Press" forState:UIControlStateHighlighted];
    
    button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setTitle:@"Test3" forState:UIControlStateNormal];
    [button3 setTitle:@"Press" forState:UIControlStateHighlighted];
    
    [button1 addTarget:self action:@selector(buttonClickedInThreeStatesTableFooter:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(buttonClickedInThreeStatesTableFooter:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(buttonClickedInThreeStatesTableFooter:) forControlEvents:UIControlEventTouchUpInside];
    [buttons addObject:button1];
    [buttons addObject:button2];
    [buttons addObject:button3];
    
    threeStatesTableView = [[ThreeStatesTableView alloc] initWithFrame:[[self view] frame] withHeaderTitle:@"THREESTATESTABLEVIEW EXAMPLE" andFooterButtons:buttons withHeaderOfSize:0.15f andFooterOfSize:0.15f];
    [threeStatesTableView.tableView setDelegate:self];
    [threeStatesTableView.tableView setDataSource:self];
    
    [threeStatesTableView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [[self view] addSubview:threeStatesTableView];
}

- (void)buttonClickedInThreeStatesTableFooter:(id)sender
{
    if (sender == button1)
    {
        NSLog(@"Button 1 clicked");
    }
    else if (sender == button2)
    {
        NSLog(@"Button 2 clicked");
    }
    else if (sender == button3)
    {
        NSLog(@"Button 3 clicked");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height/4.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == (UITableView *)threeStatesTableView.tableView)
    {
        cell = [threeStatesTableView prepareCellForRowAtIndexPath:indexPath];
        cell.textLabel.text = @"EXAMPLE TEXT LABEL";
        cell.detailTextLabel.text = @"Example detailed text";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == (UITableView *)threeStatesTableView.tableView)
    {
        [threeStatesTableView handleDidSelectRowAtIndexPath:indexPath];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
