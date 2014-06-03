//
//  MyHighScoresTableVC.m
//  RedBlueGreen
//
//  Created by Omar Thanawalla on 6/2/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "MyHighScoresTableVC.h"

@interface MyHighScoresTableVC ()

@end

@implementation MyHighScoresTableVC

-(id)initWithCoder:(NSCoder *)aCoder {
    NSLog(@"initwithCoder");
    self =  [super initWithCoder:aCoder];
    if (self)
    {
        
        NSLog(@"initWithStyle");
        // The className to query on
        self.parseClassName = @"GameScore";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"highScore";
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Conversations.m:ViewDidLoad");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
