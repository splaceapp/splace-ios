//
//  ASSplaceTransmitter.h
//  Splace
//
//  Created by Oleg Agapov on 10/10/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <MapKit/MapKit.h>

@interface ASSplaceTransmitter : AFHTTPSessionManager

+ (instancetype)sharedTransmitter;
- (void)getMarkersSuccess:(void (^)(NSArray *markers))aSuccess;

- (NSArray *)offlaneGetMarkers;
- (void)offlaneSetMarkerWithName:(NSString*)title coordinates:(CLLocationCoordinate2D)coord type:(NSUInteger)type money:(NSUInteger)money;
- (void)offlaneAddMoney:(NSUInteger)money forId:(NSString*)idString;

@end
