//
//  ASSplaceTransmitter.m
//  Splace
//
//  Created by Oleg Agapov on 10/10/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "ASSplaceTransmitter.h"
#import <MapKit/MapKit.h>

@implementation ASSplaceTransmitter

+ (instancetype)sharedTransmitter
{
    static dispatch_once_t onceToken;
    
    static ASSplaceTransmitter *sharedTransmitter = nil;
    
    dispatch_once(&onceToken, ^
                  {
                      sharedTransmitter = [[ASSplaceTransmitter alloc] init];
                  });
    
    return sharedTransmitter;
}


+ (NSString *)baseURL
{
    return @"http://splace.shpp.me";
}

- (instancetype)init
{
    return [self initWithBaseURL:[NSURL URLWithString:@"http://splace.shpp.me"]];
}

- (instancetype)initWithBaseURL:(NSURL *)anURL
{
    self = [super initWithBaseURL:anURL];
    
    if (self != nil)
    {
//        self.requestSerializer  = [self baseRequestSerializer];
//        self.responseSerializer = [self baseResponseSerializer];
//        
//        
//        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        
//        [self.requestSerializer setValue:[self headerValueDeviceID]	  forHTTPHeaderField:@"X-DEVICE-ID"];
//        [self.requestSerializer setValue:@"ios"						  forHTTPHeaderField:@"X-MOBILE-PLATFORM"];
//        [self.requestSerializer setValue:[self headerValueAppName]	  forHTTPHeaderField:@"X-APPLICATION-NAME"];
//        [self.requestSerializer setValue:[self headerValueAppVersion] forHTTPHeaderField:@"X-APPLICATION-VERSION"];
//        [self.requestSerializer setValue:[self headerValueTimeZone]   forHTTPHeaderField:@"X-DEVICE-TIME-ZONE"];
//        [self.requestSerializer setValue:[self headerValueLocale]     forHTTPHeaderField:@"X-DEVICE-LOCALE"];
    }
    
    return self;
}



- (void)getMarkersSuccess:(void (^)(NSArray *markers))aSuccess
{
    
    [self GET:@"get/v1/markers" parameters:@"" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject: %@", responseObject);
    } failure:nil];
}

- (NSArray *)offlaneGetMarkers
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"markers"];
}

- (void)offlaneSetMarkerWithName:(NSString*)title coordinates:(CLLocationCoordinate2D)coord type:(NSUInteger)type money:(NSUInteger)money
{
    int idCounter = [[NSUserDefaults standardUserDefaults] integerForKey:@"idCounter"];
    idCounter++;
    [[NSUserDefaults standardUserDefaults] setInteger:idCounter forKey:@"idCounter"];
    NSMutableArray* array = [[self offlaneGetMarkers] mutableCopy];
    if (array == nil)
    {
        array = [NSMutableArray array];
    }
    NSDictionary* dict = @{@"id": [NSString stringWithFormat:@"%d", idCounter], @"title": title, @"latitude": @(coord.latitude), @"longtitude": @(coord.longitude), @"type": @(type), @"moneyDonated": @(money)};
    [array addObject: dict];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"markers"];
}

- (void)offlaneAddMoney:(NSUInteger)money forId:(NSString*)idString
{
    NSMutableArray* array = [[self offlaneGetMarkers] mutableCopy];
    id obj = nil;
    NSMutableDictionary* cDict;
    for (NSDictionary *dict in array)
    {
        if ([dict[@"id"] isEqualToString:idString])
        {
            obj = dict;
            cDict = [dict mutableCopy];
            NSUInteger currentMoney = [dict[@"moneyDonated"] integerValue];
            [cDict setObject:@(money + currentMoney) forKey:@"moneyDonated"];
            break;
        }
    }
    [array removeObject: obj];
    [array addObject:cDict];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"markers"];
}

@end
