//
//  ARKippsterActivity.h
//  Kippster
//
//  Copyright 2013 Alex Robinson
//
//

#import <UIKit/UIKit.h>

/* This activity takes an NSURL and optionally an NSString as its activity items.
 *
 * 1. NSURL (required)
 *      This is the URL that you want to be saved to Kippt via Kippster.
 * 2. NSString (optional)
 *      This will be the title for the clip.
 *
 * If there are multiple strings and multiple URLs, only the last of each will be used.
 */

@interface ARKippsterActivity : UIActivity

/* The URL to callback to when Kippster has finished adding a clip.
    Empty by default. Either set this in the initializer, or this property. */
@property (strong, nonatomic) NSURL *callbackURL;

/* The text to be displayed on the back button in Kippster to cancel and go back to your app.
    Uses the "CFBundleName" from your Info.plist by default, which is usually what you'd want. */
@property (strong, nonatomic) NSString *callbackSource;

/* The text beneath the icon.
    Defaults to "Kippster". */
@property (strong, nonatomic) NSString *activityTitle;

// Use this initializer as a shortcut for setting the callbackURL.
- (id)initWithCallbackURL:(NSURL *)callbackURL;

@end
