#import "ObjCheck.h"
#import <Foundation/Foundation.h>
#import <stdlib.h>

@implementation ObjCheck

+ (int) genInt {
	return arc4random();
}

+ (BOOL) genBool {
	return arc4random() % 2 == 0;
}

+ (char) genChar {
	return (char) (arc4random() % 128);
}

// + (id) genArray {
// 	// ...
// }

// + (NSString) genString {
// 	// ...
// }

@end