//
//  IOSGate.m
//  Unity-iPhone
//
//  Created by crl on 16/10/31.
//
//


#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>
#import "IOSGate.h"

#import "InAppPurchasesManager.h"

@implementation IOSGate
{
    
}

static IOSGate *_instance;

NSString* unityAdGameID=@"1212892";
NSString* placementId=@"1212892";

NSString* vungleGameID=@"583d2b5b5245aed1640000d9";
NSString* inMobiGameID=@"52acfac30055466794b83945dc02e579";
long inMobiPlacementId=1482330531238;

NSString* inMobiGameID_intr=@"ae95671162c94b2999341eb3a0fcaacb";
long inMobiPlacementId_intr=1482846222141;

+(IOSGate *) sharedInstance{
    if(_instance==nil){
        _instance=[[self alloc]init];
    }
    
    return _instance;
}
bool isInited=false;

-(void)doInit:(NSString *) value{
    
    if(isInited){
        return;
    }
//    //adSDK init;
//    [UnityAds initialize:unityAdGameID delegate:self];
//    
//    VungleSDK* sdk=[VungleSDK sharedSDK];
//    sdk.delegate=self;
//    
//    [sdk startWithAppId:vungleGameID];
//    [IMSdk initWithAccountID:inMobiGameID_intr];
//    
//    InAppPurchasesManager *iap = [InAppPurchasesManager sharedInAppPurchasesManager];
//    [iap loadStore];
//    
//    NSArray *v=@[@"zs01",@"zs06",@"zs18",@"zs30",@"zs68",@"zs168"];
//    [iap requestProductData:v];
    
    isInited=true;
    
    [self login];
}

///###unity AD
//bool isUnityAdPlayed=false;
bool isCharge=false;
//- (void)unityAdsReady:(NSString *)placementId{
//    if(isUnityAdPlayed==false && isCharge==false){
//        isUnityAdPlayed=true;
//        UIViewController *rootViewController=[[[[UIApplication sharedApplication] delegate] window] rootViewController];
//        [UnityAds show:rootViewController placementId:placementId];
//    }
//}
//- (void)unityAdsDidError:(UnityAdsError)error withMessage:(NSString *)message{
//    NSLog(@"unityAdsDidError");
//}
//- (void)unityAdsDidStart:(NSString *)placementId{
//    NSLog(@"unityAdsDidStart");
//}
//- (void)unityAdsDidFinish:(NSString *)placementId withFinishState:(UnityAdsFinishState)state{
//    NSLog(@"unityAdsDidFinish");
//}
////#end unity AD


///# ADBanner
/*Indicates that the banner has received an ad. */
//- (void)bannerDidFinishLoading:(IMBanner *)banner {
//    NSLog(@"bannerDidFinishLoading");
//    if(self.banner!=nil && self.banner.hidden==true){
//        self.banner.hidden=false;
//    }
//}
///* Indicates that the banner has failed to receive an ad */
//- (void)banner:(IMBanner *)banner didFailToLoadWithError:(IMRequestStatus *)error {
//    NSLog(@"banner failed to load ad");
//    NSLog(@"Error : %@", error.description);
//}
///* Indicates that the banner is going to present a screen. */
//- (void)bannerWillPresentScreen:(IMBanner *)banner {
//    NSLog(@"bannerWillPresentScreen");
//}
///* Indicates that the banner has presented a screen. */
//- (void)bannerDidPresentScreen:(IMBanner *)banner {
//    NSLog(@"bannerDidPresentScreen");
//}
///* Indicates that the banner is going to dismiss the presented screen. */
//- (void)bannerWillDismissScreen:(IMBanner *)banner {
//    NSLog(@"bannerWillDismissScreen");
//}
///* Indicates that the banner has dismissed a screen. */
//- (void)bannerDidDismissScreen:(IMBanner *)banner {
//    NSLog(@"bannerDidDismissScreen");
//    
//    if(banner!=nil){
//        banner.hidden=true;
//    }
//}
///* Indicates that the user will leave the app. */
//- (void)userWillLeaveApplicationFromBanner:(IMBanner *)banner {
//    NSLog(@"userWillLeaveApplicationFromBanner");
//    
//    if(banner!=nil){
//        banner.hidden=true;
//    }
//}
/*  Indicates that the banner was interacted with. */
//-(void)banner:(IMBanner *)banner didInteractWithParams:(NSDictionary *)params{
//    NSLog(@"bannerdidInteractWithParams");
//}
///*Indicates that the user has completed the action to be incentivised with .*/
//-(void)banner:(IMBanner*)banner rewardActionCompletedWithRewards:(NSDictionary*)rewards{
//    NSLog(@"rewardActionCompletedWithRewards");
//}
/////#end banner;
//
///*Indicates that the interstitial is ready to be shown */
//- (void)interstitialDidFinishLoading:(IMInterstitial *)interstitial {
//    NSLog(@"interstitialDidFinishLoading");
//}
///* Indicates that the interstitial has failed to receive an ad. */
//- (void)interstitial:(IMInterstitial *)interstitial didFailToLoadWithError:(IMRequestStatus *)error {
//    NSLog(@"Interstitial failed to load ad");
//    NSLog(@"Error : %@",error.description);
//}
///* Indicates that the interstitial has failed to present itself. */
//- (void)interstitial:(IMInterstitial *)interstitial didFailToPresentWithError:(IMRequestStatus *)error {
//    NSLog(@"Interstitial didFailToPresentWithError");
//    NSLog(@"Error : %@",error.description);
//}
///* indicates that the interstitial is going to present itself. */
//- (void)interstitialWillPresent:(IMInterstitial *)interstitial {
//    NSLog(@"interstitialWillPresent");
//}
///* Indicates that the interstitial has presented itself */
//- (void)interstitialDidPresent:(IMInterstitial *)interstitial {
//    NSLog(@"interstitialDidPresent");
//}
///* Indicates that the interstitial is going to dismiss itself. */
//- (void)interstitialWillDismiss:(IMInterstitial *)interstitial {
//    NSLog(@"interstitialWillDismiss");
//}
///* Indicates that the interstitial has dismissed itself. */
//- (void)interstitialDidDismiss:(IMInterstitial *)interstitial {
//    NSLog(@"interstitialDidDismiss");
//}
///* Indicates that the user will leave the app. */
//- (void)userWillLeaveApplicationFromInterstitial:(IMInterstitial *)interstitial {
//    NSLog(@"userWillLeaveApplicationFromInterstitial");
//}
///* Indicates that a reward action is completed */
//- (void)interstitial:(IMInterstitial *)interstitial rewardActionCompletedWithRewards:(NSDictionary *)rewards {
//    NSLog(@"rewardActionCompletedWithRewards");
//}
///* interstitial:didInteractWithParams: Indicates that the interstitial was interacted with. */
//- (void)interstitial:(IMInterstitial *)interstitial didInteractWithParams:(NSDictionary *)params {
//    NSLog(@"InterstitialDidInteractWithParams");
//}
///* Not used for direct integration. Notifies the delegate that the ad server has returned an ad but assets are not yet available. */
//- (void)interstitialDidReceiveAd:(IMInterstitial *)interstitial {
//    NSLog(@"interstitialDidReceiveAd");
//}

///#vundelAD
//- (void)vungleSDKwillShowAd{
//    NSLog(@"vungleSDKwillShowAd");
//}
//- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet;
//{
//    double time=[[viewInfo objectForKey:@"playTime"] doubleValue];
//    
//    if(willPresentProductSheet || time>10){
//        [self send:@"play_back" Value:@"1|success"];
//    }else{
//        [self send:@"play_back" Value:@"0|fail"];
//    }
//    
//    NSLog(@"vungleSDKwillCloseAdWithViewInfo");
//}
//- (void)vungleSDKwillCloseProductSheet:(id)productSheet;
//{
//    NSLog(@"vungleSDKwillCloseProductSheet");
//}
//- (void)vungleSDKAdPlayableChanged:(BOOL)isAdPlayable;
//{
//    NSLog(@"vungleSDKAdPlayableChanged");
//}
////#end vundleAD

static NSString* playerID;

-(void)login{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    
    GKLocalPlayer *localPlayer=[GKLocalPlayer localPlayer];
    
    if(localPlayer.isAuthenticated){
        [self loginBack];
    }else if(localPlayer.authenticateHandler==nil){
        
        localPlayer.authenticateHandler=^(UIViewController* uiViewController,NSError* error){
            
            if(uiViewController!=nil){
                UIViewController *rootViewController=[[[[UIApplication sharedApplication] delegate] window] rootViewController];
                [rootViewController presentViewController:uiViewController animated:YES completion:nil];
                
            }else if([GKLocalPlayer localPlayer].isAuthenticated){
                [self loginBack];
            }else if(error!=nil){
                
                NSString* uuID=[[NSUserDefaults standardUserDefaults] stringForKey:@"uuid"];
                if(uuID==nil){
                    uuID=[[UIDevice currentDevice].identifierForVendor UUIDString];
                    if(uuID==nil){
                        uuID=[[NSUUID UUID] UUIDString];
                    }
                    if (uuID!=nil) {
                        [[NSUserDefaults standardUserDefaults] setValue:uuID forKey:@"uuid"];
                    }
                }
                
                if([playerID isEqual:uuID]){
                    return;
                }
                playerID=uuID;
                [self sendLoginBack];
            }
        };
    }
}

-(void)loginBack{
    GKLocalPlayer *localPlayer=[GKLocalPlayer localPlayer];
    if(localPlayer.isAuthenticated){
        NSString* uuID=[localPlayer.playerID stringByReplacingOccurrencesOfString:@":" withString:@""];
        if([playerID isEqual:uuID]){
            return;
        }
        playerID=uuID;
    }
    
    [self sendLoginBack];
}

-(void)sendLoginBack{
    
    if(playerID==nil){
        [self send:@"login_back" Value:@"0|login fail!"];
        return;
    }
    
    NSString* msg=[[NSString alloc] initWithFormat:@"1|%@|%@|%@",playerID,playerID,@"local"];
    [self send:@"login_back" Value:msg];
    
    
    
    //[self showBannerAd:@"1"];
}

-(void)send:(NSString *)key Value:(NSString *)value{
//    const char* go=[@"UICamera" UTF8String];
//    const char* method=[@"Receive" UTF8String];
//
//    NSString* msg=[[NSString alloc] initWithFormat:@"%@~%@",key,value];
//    //UnitySendMessage(go, method, [msg UTF8String]);
}


-(void)pay:(NSString *)value{
    
    if([value length]==0){
        return;
    }
    
    NSArray *temp=[value componentsSeparatedByString:@"&"];
    
    NSLog(@"%@:%lu",value,(unsigned long)[temp count]);
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\'\""];
    
    for(NSString *keyValuePair in temp)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        if (pairComponents.count !=2) {
            continue;
        }
        
        NSString *key = [pairComponents objectAtIndex:0];
        NSString *value = [pairComponents objectAtIndex:1];
        
        key = [[key componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        value = [[value componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        
        [dict setObject:value forKey:key];
    }
    
    NSString *productID=[dict objectForKey:@"appID"];
    if([productID length]==0){
        productID=@"zs01";
    }
    
    NSLog(@"product: %@",productID);
    
    [[InAppPurchasesManager sharedInAppPurchasesManager] purchase:productID jsonHelper:dict];
}

-(void) router:(NSString *)key Value:(NSString *)value
{
    if([key isEqual:@"playad"]){
        [self playAd:value];
    }else if([key isEqual:@"showbannerad"]){
        [self showBannerAd:value];
    }else if([key isEqual:@"closead"]){
        isCharge=true;
    }else if([key isEqual:@"step"]){
        
        if([value isEqualToString:@"10"]){
            [self showBannerAd:value];
        }
        
    }
}


-(void)playAd:(NSString*) v{
}

-(void)showBannerAd:(NSString*) v{
    if(isCharge){
        return;
    }
}

@end
