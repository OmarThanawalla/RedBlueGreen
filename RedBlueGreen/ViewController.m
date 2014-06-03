//
//  ViewController.m
//  RedBlueGreen
//
//  Created by Omar Thanawalla on 6/2/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@property (strong, nonatomic) NSTimer * gameTimer;
@property (strong, nonatomic) NSArray * word;
@property (strong, nonatomic) NSArray * color;
@property (assign) int correctAns;
@property (assign) int level;
@property (assign) int score;
//These two arrays will hold the solution for levels >= 3
@property (strong, nonatomic) NSMutableArray * correctAnsManyColors;
@property (strong, nonatomic) NSMutableArray * correctAnsManyColorsFont;

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
    
    //Test Parse
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
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
        UIColor * myColor = self.color[r];
        
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
    }
    else{ //for Levels >= 3
        
        [self killGame];
        //String should say "red blue green" with elements colored randomly,
        //Coloring the text inside a text label according to a dynamic allocation of fonts is proving to be tricky in objective-c
        //moving on to setting up a leaderboard. will come back if more time
        
        /*
        //for Levels >= 3
        self.correctAnsManyColors = [NSMutableArray array];
        self.correctAnsManyColorsFont = [NSMutableArray array];
        
        //create sequence of words
        int i;
        for ( i = 0 ; i < self.level; i++) {
            //select the word
            int r = arc4random() % 3;
            NSString * myWord = self.word[r];
            [self.correctAnsManyColors addObject:myWord];
            
            //select the color of the word
            int s = arc4random() % 3;
            UIColor * myColor = self.color[s];
            [self.correctAnsManyColorsFont addObject:myColor];
            
        }
        //color sequence of words
        NSString * combinedString = [self.correctAnsManyColors componentsJoinedByString:@" "];
        NSLog(@"combinedString: %@", combinedString);
        self.wordFlash.text = combinedString;
        NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:combinedString];
        int pivot = 0;
        int j;
        for(j = 0; j < [self.correctAnsManyColorsFont count]; j++)
        {
            NSLog(@"pivot: %i", pivot);
            NSLog(@"text length: %i",[text length]);
            UIColor * chosenColor = self.correctAnsManyColorsFont[j];
            if (chosenColor == [UIColor redColor]) {
                [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(pivot, 4)];
                pivot = pivot + 3;
            }else if(chosenColor == [UIColor greenColor])
            {
                [text addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(pivot, 6)];
                pivot = pivot + 5;
            }else
            {
                [text addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(pivot, 5)];
                pivot = pivot + 4;
            }
        }
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, 3)];
        [self.wordFlash setAttributedText:text];
        */
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
    self.score = self.score+10;
    //level up if score multiple of 5
    if(self.score%50==0)
    {
        self.level = self.level+1;
        self.wordFlash.text = @"Next Level!";
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
    
    //Submit Score to server
    PFObject * gameScore = [PFObject objectWithClassName:@"GameScore"];
    [gameScore setObject:@"foo" forKey:@"name"];
    [gameScore setObject:[NSString stringWithFormat:@"%d",self.score] forKey:@"highScore"];
    [gameScore setObject:[NSString stringWithFormat:@"%d",self.level] forKey:@"level"];
    [gameScore saveInBackground];
    
}
- (IBAction)playAgain:(id)sender {
    self.continuePlaying = 1;
    [self resetGameTimer];
    [self setLevelLbl:1 andScoreLbl:0];
}


@end
