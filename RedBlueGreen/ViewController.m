//
//  ViewController.m
//  RedBlueGreen
//
//  Created by Omar Thanawalla on 6/2/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSTimer * gameTimer;
@property (strong, nonatomic) NSArray * word;
@property (strong, nonatomic) NSArray * color;
@property (assign) int correctAns;
@property (assign) int level;
@property (assign) int score;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Init words, colors
    self.word = [NSArray arrayWithObjects:@"red", @"green", @"blue", nil];
    self.color = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    
    //Begin Timer
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                      target:self
                                                    selector:@selector(createWordFlash)
                                                    userInfo:nil
                                                     repeats:YES];
    
    
    //Initialize new game
    self.continuePlaying = 1;
    self.level = 1;
    self.score = 0;
    [self setLevelLbl:self.level andScoreLbl:self.score];
}

-(void)setLevelLbl:(int)lvl andScoreLbl: (int) scre
{
    //update labels
    self.levelLbl.text = [NSString stringWithFormat:@"%d",lvl];
    self.scoreLbl.text = [NSString stringWithFormat:@"%d",scre];
}

-(void)resetGameTimer
{
    NSLog(@"resetGameTimer called");
    [self.gameTimer invalidate];
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                      target:self
                                                    selector:@selector(createWordFlash)
                                                    userInfo:nil
                                                     repeats:YES];
}

-(void)createWordFlash
{
    NSLog(@"createWordFlash called");
    if(!self.continuePlaying)
    {
        NSLog(@"createWordFlash - ran out of time");
        //kill the game (ran out of time)
        [self killGame];
    }else{
        [self createWordFlashBasedOnLevel];
    }
}

-(void)createWordFlashBasedOnLevel
{
    if(self.level == 1){
        //select the word
        int r = arc4random() % 3;
        NSString * myWord = self.word[r];
        self.correctAns = r;
        
        //select the color of the word
        UIColor * myColor = [UIColor blackColor];
        
        //assignWord
        [self assignWord:myWord withColor:myColor];
    }
    else if (self.level == 2){
        //select the word
        int r = arc4random() % 3;
        NSString * myWord = self.word[r];
        self.correctAns = r;
        
        //select the color of the word
        int s = arc4random() % 3;
        UIColor * myColor = self.color[s];
        
        //assignWord
        [self assignWord:myWord withColor:myColor];
    }else{
        
    }
}

-(void)assignWord: (NSString* ) wrd
        withColor: (UIColor *) clr
{
    NSLog(@"assignWordwithColor called: %@", wrd);
    self.wordFlash.text = wrd;
    
    self.wordFlash.textColor = clr; //this is hard
    
    //The user must save himself
    self.continuePlaying = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushRed:(id)sender {
    NSLog(@"pushRed");

    if(self.correctAns == 0)
    {
        NSLog(@"pushRed - correct choice");
        [self rewardCorrectAnsCheckLevelUp];
        [self resetGameTimer];
    }else{
        NSLog(@"pushRed - wrong choice");

        //lose, kill the game (incorrect push)
        [self killGame];
    }
}

- (IBAction)pushGreen:(id)sender {
    NSLog(@"pushGreen");

    if(self.correctAns == 1)
    {
        NSLog(@"pushGreen - correct choice");
        [self rewardCorrectAnsCheckLevelUp];
        [self resetGameTimer];
    }else{
        NSLog(@"pushGreen - wrong choice");
        [self killGame];
    }
    
}

- (IBAction)pushBlue:(id)sender {
    NSLog(@"pushBlue");
    if(self.correctAns == 2)
    {
        NSLog(@"pushBlue - correct choice");
        [self rewardCorrectAnsCheckLevelUp];
        [self resetGameTimer];
    }else{
        NSLog(@"pushBlue - wrong choice");
        [self killGame];
    }
    
}

-(void)rewardCorrectAnsCheckLevelUp
{
    //correct push
    self.continuePlaying = 1;
    self.wordFlash.text = @"Great!";
    
    //increment score by one point
    self.score = self.score+1;
    //level up if score multiple of 5
    if(self.score%5==0)
    {
        self.level = self.level+1;
    }
    //update labels
    self.levelLbl.text = [NSString stringWithFormat:@"%d",self.level];
    self.scoreLbl.text = [NSString stringWithFormat:@"%d",self.score];
}

-(void)killGame
{
    NSLog(@"killGame: called");
    [self.gameTimer invalidate];
    self.wordFlash.text = @"You lose";
    NSLog(@"killGame: end of method");
}
- (IBAction)playAgain:(id)sender {
    self.continuePlaying = 1;
    [self resetGameTimer];
    [self setLevelLbl:1 andScoreLbl:0];
}


@end
