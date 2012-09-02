//
//  ViewController.h
//  ThreeStatesTableView
//
//  Created by Tomasz Zablocki (skalamandra@gmail.com) on 31/08/2012.
//  Copyright (c) 2012. All rights granted.
//

#import <UIKit/UIKit.h>
#import "ThreeStatesTableView.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    ThreeStatesTableView *threeStatesTableView;
}
@property(strong, readwrite) UIButton *button1;
@property(strong, readwrite) UIButton *button2;
@property(strong, readwrite) UIButton *button3;


@end
