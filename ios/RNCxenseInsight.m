#import "RNCxenseInsight.h"
#import "CxenseInsight.h"
#import <CxenseInsightSDK/CxenseInsight.h>

@implementation RNCxenseInsight

RCT_EXPORT_MODULE(RNCxenseInsight)

RCT_EXPORT_METHOD(startTrackerWithName:(NSString *)name
                  siteID:(nonnull NSString *)siteID
                  dispatchMode:(CxenseInsightDispatchMode)dispatchMode
                  networkRestriction:(CxenseInsightNetworkRestriction)networkRestriction
                  consentOptions:(NSArray<NSString *> *)consentOptions
                  automaticMetaDataTracking:(BOOL)automaticMetaDataTracking)
{
    CxenseInsightTracker *tracker = [CxenseInsight trackerWithName:name
                                                            siteId:siteID];
    [CxenseInsight setDispatchMode:dispatchMode];
    [CxenseInsight setNetworkRestriction:networkRestriction];
    [CxenseInsight setConsentOptions:consentOptions];
    [CxenseInsight setAutoMetaInfTracking:automaticMetaDataTracking];
}

RCT_EXPORT_METHOD(trackPageViewEventWithURL:(NSString *)URL
                  referringURL:(NSString *)referringURL
                  siteID:(NSString *)siteID
                  Name:(NSString *)name siteID:(NSString *)siteID)
{
    CxenseInsightEventBuilder *builder = [CxenseInsightEventBuilder pageViewEventWithURL:URL
                                                                            referringURL:referringURL
                                                                                  siteId:siteID];
    [builder setCustomParameter:title forKey:@"title"];
    NSDictionary *eventData = [builder build];
    
    [_tracker trackEvent:eventData name: completion:^(NSDictionary *event, NSError *error) {
        if (error) {
            NSLog(@"Error during event reporting: %@", error.description);
        } else {
            NSLog(@"Event with data = '%@' was reported", event);
        }
    }];
    [CxenseInsight dispatch];
}

@end
