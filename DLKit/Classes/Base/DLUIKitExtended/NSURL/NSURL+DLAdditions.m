//
//  NSURL+AB_Additions.m
//
//
//

#import "NSURL+DLAdditions.h"

@implementation NSURL (DLAdditions)

+ (NSURL *)encodeURLWithString:(NSString *)string{
    NSURL *url = [NSURL URLWithString:string];
    
    if(url != nil){
        CFStringRef originalString = (__bridge CFStringRef)string;
        CFStringRef charactersToLeaveUnescaped = NULL;
        CFStringRef legalURLCharactersToBeEscaped = (CFStringRef)@"!*'();@&=+$,#[]";
        CFStringEncoding encoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        
        CFStringRef createString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, originalString, charactersToLeaveUnescaped, legalURLCharactersToBeEscaped, encoding);
        
        NSString *newString = (__bridge NSString *)createString;
        
        if (newString)
        {
            url = [NSURL URLWithString:newString];
            CFRelease(createString);
        }
    }
    
	return url;
}

@end
