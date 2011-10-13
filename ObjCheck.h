#import <objc/Object.h>

@interface ObjCheck: Object {}

+ (id) genNum;
+ (id) genBool;
+ (id) genChar;
+ (id) genArray: (id(^)()) gen;
+ (id) genString;

+ forAll: (id(^)(id)) property withGenerators: (id) generators;

@end