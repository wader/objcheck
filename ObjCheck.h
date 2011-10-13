#import <objc/Object.h>

@interface ObjCheck: Object {}

+ (int) genInt;
+ (BOOL) genBool;
+ (char) genChar;
+ (id) genArray: (id) gen;
+ (id) genString;

@end