//
//  DRFallingWordsView.m
//  DRFallingWords
//
//  Created by Danny Ricciotti on 1/10/14.
//  Copyright (c) 2014 Danny Ricciotti. All rights reserved.
//

#import "DRFallingWordsView.h"
#import "DRFallingWordLabel.h"

#pragma mark - Interface

@interface DRFallingWordsView ()
@property (nonatomic) NSArray *wordLabels;
@property (nonatomic) NSArray *timers;
@end

#pragma mark - Implementation

@implementation DRFallingWordsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.scrollEnabled = NO;    // for now...
    }
    return self;
}

#pragma mark - Public

- (void)showWords:(NSString *)words
{
    NSCAssert([NSThread isMainThread], @"Require main thread");
    
    [self clearWithCompletion:^(BOOL finished) {

        // split into array of strings
        NSArray *wordArray = [self _chop:words];
        
        [self _makeWordLabels:wordArray];
        NSParameterAssert(self.wordLabels.count == wordArray.count);    // make sure we created the expected number of labels
        
        [self _animateLabelsIn];
    }];
    
}

- (void)clear
{
    [self clearWithCompletion:nil];
}

- (void)clearWithCompletion:(void (^)(BOOL finished))completion
{
    NSCAssert([NSThread isMainThread], @"Require main thread");
    
    // cancel animate in timers
    [self _invalidateTimers];
    
    // finish immediatly if there is nothing to clear
    if ( !self.wordLabels ) {
        if ( completion ) {
            completion(YES);
            return;
        }
    }
    
    // otherwise, animate it all out nicely.
    NSArray *labelsArray = self.wordLabels;
    self.wordLabels = nil;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [labelsArray enumerateObjectsUsingBlock:^(DRFallingWordLabel *label, NSUInteger idx, BOOL *stop) {
            label.alpha = 0;
        }];
    } completion:^(BOOL finished) {
        [labelsArray enumerateObjectsUsingBlock:^(DRFallingWordLabel *label, NSUInteger idx, BOOL *stop) {
            [label removeFromSuperview];
        }];
        if ( completion ) {
            completion(YES);
        }
    }];
}

#pragma mark - Private

- (NSArray *)_chop:(NSString *)words
{
    return [words componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void)_makeWordLabels:(NSArray *)wordArray
{
    NSCAssert([NSThread isMainThread], @"Require main thread");
    
    NSMutableArray *wordsLabels = [NSMutableArray new];
    
    __block CGFloat nextY = 0;
    __block CGFloat nextX = 0;
    CGFloat maxX = self.bounds.size.width;
    static const CGFloat kWidthOfASpace = 7;
    
    // Make each word label and add it as a subview
    
    [wordArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        NSCAssert([obj isKindOfClass:[NSString class]], @"Invalid class.");
        
        DRFallingWordLabel *label = [[DRFallingWordLabel alloc] init];
        label.text = obj;
        
        // calculate size, and wrap to next line if too wide
        [label sizeToFit];
        CGFloat width = label.frame.size.width;
        CGFloat height = label.frame.size.height;
        
        if ( nextX + width > maxX ) {
            nextX = 0;
            nextY += height;
        }
        label.frame = CGRectMake(nextX, nextY, width, height);
        
        nextX += width + kWidthOfASpace;
        
        [self addSubview:label];
        [wordsLabels addObject:label];
        
        [label setMasked:YES animated:NO];
    }];
    
    self.wordLabels = wordsLabels;
}

- (void)_animateLabelsIn
{
    NSArray *wordLabels = self.wordLabels;
    
    __block NSTimeInterval delay = 0;
    
    NSMutableArray *timers = [NSMutableArray new];
    
    // create a timer that will fire when each word should be animated in
    [wordLabels enumerateObjectsUsingBlock:^(DRFallingWordLabel *label, NSUInteger idx, BOOL *stop) {
        NSUInteger len = label.text.length;
        NSTimeInterval myDelay = kDRWordDelayPerCharacter * len + delay;
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:myDelay target:self selector:@selector(_animateSingleLabel:) userInfo:label repeats:NO];
        [timers addObject:timer];
        
        delay += kDRWordDelayPerCharacter * len + kDRDelayPerSpace;
    }];
    
    NSParameterAssert(self.timers == nil);
    self.timers = timers;
}

- (void)_animateSingleLabel:(NSTimer *)sender
{
    DRFallingWordLabel *label = [sender userInfo];
    [label setMasked:NO animated:YES];
}

- (void)_invalidateTimers
{
    [self.timers enumerateObjectsUsingBlock:^(NSTimer *timer, NSUInteger idx, BOOL *stop) {
        [timer invalidate];
    }];
    self.timers = nil;
}

@end
