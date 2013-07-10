//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Joshua Shuster on 5/11/13.
//  Copyright (c) 2013 josh_matchismo_stanford. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIButton *dealButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gameModeSwitch;


@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                          usingDeck:[[PlayingCardDeck alloc] init]];  
    }
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}


- (IBAction)dealNewGame:(id)sender
{
    _game = 0;
    self.flipCount = 0;
    self.game.gameMode = self.gameModeSwitch.selectedSegmentIndex;
    [self updateUI];
}

- (void)updateUI
{
    if (self.flipCount == 0) {
        [self.gameModeSwitch setEnabled:YES];
    } else {
        [self.gameModeSwitch setEnabled:NO];
    }
    
//    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.jpg"];
    
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (!card.isFaceUp) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
    }
    self.statusLabel.text = self.game.lastFlipLabel;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    
}


-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips %d", self.flipCount];
}

- (IBAction)gameModeChanged:(UISegmentedControl *)sender {
    self.game.gameMode = sender.selectedSegmentIndex;
}

- (void)setGameModeSwitch:(UISegmentedControl *)gameModeSwitch
{
    _gameModeSwitch = gameModeSwitch;
    self.game.gameMode = gameModeSwitch.selectedSegmentIndex; // Default game mode set to 0 (Match 2 cards)
}


- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}




@end
