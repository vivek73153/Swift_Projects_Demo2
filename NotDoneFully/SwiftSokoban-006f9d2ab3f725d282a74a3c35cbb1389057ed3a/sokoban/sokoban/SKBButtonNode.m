//
//  SKBButtonNode.m
//  sokoban
//
//  Created by Admin on 06/06/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import "SKBButtonNode.h"

@implementation SKBButtonNode

#pragma mark Texture Initializer

/**
 * Override the super-classes designated initializer, to get a properly set SKButton in every case
 */
- (instancetype)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size {
    return [self initWithTextureNormal:texture selected:nil disabled:nil];
}

- (instancetype)initWithTextureNormal:(SKTexture *)normal selected:(SKTexture *)selected {
    return [self initWithTextureNormal:normal selected:selected disabled:nil];
}

/**
 * This is the designated Initializer
 */
- (instancetype)initWithTextureNormal:(SKTexture *)normal selected:(SKTexture *)selected disabled:(SKTexture *)disabled {
    self = [super initWithTexture:normal color:[UIColor whiteColor] size:normal.size];
    if (self) {
        [self setNormalTexture:normal];
        [self setSelectedTexture:selected];
        [self setDisabledTexture:disabled];
        [self setIsEnabled:YES];
        [self setIsSelected:NO];
        
        _title = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        [_title setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
        [_title setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
        
        [self addChild:_title];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

#pragma mark Image Initializer

- (instancetype)initWithImageNamedNormal:(NSString *)normal selected:(NSString *)selected {
    return [self initWithImageNamedNormal:normal selected:selected disabled:nil];
}

- (instancetype)initWithImageNamedNormal:(NSString *)normal selected:(NSString *)selected disabled:(NSString *)disabled {
    SKTexture *textureNormal = nil;
    if (normal) {
        textureNormal = [SKTexture textureWithImageNamed:normal];
    }
    
    SKTexture *textureSelected = nil;
    if (selected) {
        textureSelected = [SKTexture textureWithImageNamed:selected];
    }
    
    SKTexture *textureDisabled = nil;
    if (disabled) {
        textureDisabled = [SKTexture textureWithImageNamed:disabled];
    }
    
    return [self initWithTextureNormal:textureNormal selected:textureSelected disabled:textureDisabled];
}




#pragma -
#pragma mark Setting Target-Action pairs

- (void)setTouchUpInsideTarget:(id)target action:(SEL)action {
    _targetTouchUpInside = target;
    _actionTouchUpInside = action;
}

- (void)setTouchDownTarget:(id)target action:(SEL)action {
    _targetTouchDown = target;
    _actionTouchDown = action;
}

- (void)setTouchUpTarget:(id)target action:(SEL)action {
    _targetTouchUp = target;
    _actionTouchUp = action;
}

#pragma -
#pragma mark Setter overrides

- (void)setIsEnabled:(BOOL)isEnabled {
    _isEnabled = isEnabled;
    if ([self disabledTexture]) {
//        if (!_isEnabled) {
//            [self setTexture:textureDisabled];
//        } else {
//            [self setTexture:textureNormal];
//        }
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if ([self selectedTexture] && [self isEnabled]) {
//        if (_isSelected) {
//            [self setTexture:textureSelected];
//        } else {
//            [self setTexture:textureNormal];
//        }
    }
}

#pragma -
#pragma mark Touch Handling

/**
 * This method only occurs, if the touch was inside this node. Furthermore if
 * the Button is enabled, the texture should change to "selectedTexture".
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isEnabled]) {
        if (_actionTouchDown){
            [self.parent performSelectorOnMainThread:_actionTouchDown withObject:_targetTouchDown waitUntilDone:YES];
            [self setIsSelected:YES];
        }
    }
}

/**
 * If the Button is enabled: This method looks, where the touch was moved to.
 * If the touch moves outside of the button, the isSelected property is restored
 * to NO and the texture changes to "normalTexture".
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isEnabled]) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInNode:self.parent];
        
        if (CGRectContainsPoint(self.frame, touchPoint)) {
            [self setIsSelected:YES];
        } else {
            [self setIsSelected:NO];
        }
    }
}

/**
 * If the Button is enabled AND the touch ended in the buttons frame, the
 * selector of the target is run.
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self.parent];
    
    if ([self isEnabled] && CGRectContainsPoint(self.frame, touchPoint)) {
        if (_actionTouchUpInside){
            [self.parent performSelectorOnMainThread:_actionTouchUpInside withObject:_targetTouchUpInside waitUntilDone:YES];
        }
    }
    [self setIsSelected:NO];
    if (_actionTouchUp){
        [self.parent performSelectorOnMainThread:_actionTouchUp withObject:_targetTouchUp waitUntilDone:YES];
    }
}
@end