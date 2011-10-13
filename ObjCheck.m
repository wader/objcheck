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

+ (id) genArray: (id) gen {
	NSArray* arr = [NSArray array];

	int len = [self genInt] % 100;

	int i;
	for (i = 0; i < len; i++) {
		id value = gen();

		arr = [arr arrayByAddingObject: value];
	}

	return arr;
}

+ (id) genString {
	NSString* s = @"";

	char (^g)() = ^() {
		return [ObjCheck genChar];
	};

	NSArray* arr = [self genArray: g];
	s = [arr componentsJoinedByString: @""];

	return s;
}

@end