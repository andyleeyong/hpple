//
//  ViewController.m
//  HppleDemo
//
//  Created by Vytautas Galaunia on 11/25/14.
//
//

#import "TFHpple.h"
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) TFHpple* doc;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)getMenuList
{
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.xiachufang.com/category/51761/"]];
    self.doc = [[TFHpple alloc] initWithHTMLData:data];
    //            <ul class="level2 plain list ">

    NSArray* a = [self.doc searchWithXPathQuery:@"//ul[@class='level2 plain list ']//a"];
    for (TFHppleElement* element in a) {
        NSString* url = element.attributes[@"href"];
        NSString* title = element.content;
        title = [self replaceSpaceAndEnterString:title];
    }
}
#pragma mark - Tool
- (NSString*)replaceSpaceAndEnterString:(NSString*)str
{
    return [[str stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

+ (NSDictionary*)dictionaryWithJsonString:(NSString*)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* err;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"json解析失败：%@", err);
        return nil;
    }
    return dic;
}

+ (NSString*)dictionaryToJson:(NSDictionary*)dic
{
    NSError* parseError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+ (NSArray*)arrayWithJsonString:(NSString*)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* err;
    NSArray* dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    if (err) {
        NSLog(@"json解析失败：%@", err);
        return nil;
    }
    return dic;
}

+ (NSString*)arrToJson:(NSArray*)dic
{
    NSError* parseError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
