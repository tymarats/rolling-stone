//
//  RollingStoneViewController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RollingStoneViewController.h"
#import "EAGLView.h"

#import "RollingStoneDirector.h"

// Uniform index.
enum {
    UNIFORM_TRANSLATE,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@interface RollingStoneViewController ()

@property (nonatomic, retain) EAGLContext *context;

- (void) initOpenGL;
- (void) initDirector;

@end

@implementation RollingStoneViewController

@synthesize animating, context, director;

- (void)awakeFromNib
{
	[self initOpenGL];
	[self initDirector];
}

- (void)dealloc
{
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
	[director run];
    [self startAnimation];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopAnimation];
	[director stop];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
	[super viewDidUnload];

    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	self.context = nil;	
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    /*
	 Frame interval defines how many display frames must pass between each time the display link fires.
	 The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. A frame interval setting of less than one results in undefined behavior.
	 */
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;
        
        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    if (!animating)
    {
        if (displayLinkSupported)
        {
            /*
			 CADisplayLink is API new in iOS 3.1. Compiling against earlier versions will result in a warning, but can be dismissed if the system version runtime check for CADisplayLink exists in -awakeFromNib. The runtime check ensures this code will not be called in system versions earlier than 3.1.
            */
            displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawFrame)];
            [displayLink setFrameInterval:animationFrameInterval];
            
            // The run loop will retain the display link on add.
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        else
            animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(drawFrame) userInfo:nil repeats:TRUE];
        
        animating = TRUE;
    }
}

- (void)stopAnimation
{
    if (animating)
    {
        if (displayLinkSupported)
        {
            [displayLink invalidate];
            displayLink = nil;
        }
        else
        {
            [animationTimer invalidate];
            animationTimer = nil;
        }
        
        animating = FALSE;
    }
}

- (void) initOpenGL 
{
	EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	[aContext release];
	
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
    animating = FALSE;
    displayLinkSupported = FALSE;
    animationFrameInterval = 1;
    displayLink = nil;
    animationTimer = nil;
    
    // Use of CADisplayLink requires iOS version 3.1 or greater.
	// The NSTimer object is used as fallback when it isn't available.
    NSString *reqSysVer = @"3.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
        displayLinkSupported = TRUE;
}

- (void) initDirector 
{
	RollingStoneDirector *dir = [[[RollingStoneDirector alloc] init] autorelease];
	[self setDirector:dir];
}

- (void)drawFrame
{
    [(EAGLView *)self.view setFramebuffer];

	[director update];
    
    [(EAGLView *)self.view presentFramebuffer];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[director touchesBegan:touches withEvent:event onView:[self view]];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[director touchesBegan:touches withEvent:event onView:[self view]];
}

@end
