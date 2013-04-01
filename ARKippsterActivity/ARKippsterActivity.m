//
//  ARKippsterActivity.m
//  Kippster
//
//  Created by Alex Robinson on 19/10/12.
//
//

#import "ARKippsterActivity.h"

@implementation ARKippsterActivity {
    // Set via prepareWithActivityItems:
	NSURL *_activityURL; // The URL that will be saved.
    NSString *_activityTitle; // The Title that should be set.
}

@synthesize callbackURL = _callbackURL;
@synthesize callbackSource = _callbackSource;
@synthesize activityTitle = _activityTitle;

- (void)commonInit {
    // Set the property defaults.
    _callbackSource = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleName"];
    _activityTitle = @"Kippster";
}

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCallbackURL:(NSURL *)callbackURL {
    self = [super init];
    if (self) {
        [self commonInit];
        _callbackURL = callbackURL;
    }
    return self;
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"kippster-activity"];
}

- (NSString *)activityTitle {
    return @"Kippster";
}

- (NSString *)activityType {
    return NSStringFromClass([self class]);
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
    BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"kippster://"]];
    
    // Check whether there's a URL somewhere in activityItems.
    BOOL containsURL = NO;
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSURL class]]) {
            containsURL = YES;
        }
    }
	return canOpenURL && containsURL;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSURL class]]) {
            _activityURL = item;
        }
        else if ([item isKindOfClass:[NSString class]]) {
            _activityTitle = item;
        }
    }
}

- (void)performActivity {
	NSString *urlString = [NSString stringWithFormat:@"kippster://x-callback-url/add?url=%@&title=%@&x-success=%@&x-error=%@&x-cancel=%@&x-source=%@",
                           [_activityURL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           [_activityTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           [_callbackURL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           [_callbackURL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           [_callbackURL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           _callbackSource];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
	[self activityDidFinish:YES];
}

@end
