//
//  AppDelegate.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 2/15/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import UIKit
import AppsFlyerLib


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,AppsFlyerTrackerDelegate {

    var window: UIWindow?
     var navigateTo: String?
    
    @objc func sendLaunch(app:Any) {
        AppsFlyerTracker.shared().trackAppLaunch()
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //add dummy user logins
        addUserLogins()
        
        AppsFlyerTracker.shared().appsFlyerDevKey = "tRiUHG43JTfCZrp6LnXrhD"
        AppsFlyerTracker.shared().appleAppID = "211122514"
        AppsFlyerTracker.shared().delegate = self
        /* Set isDebug to true to see AppsFlyer debug logs */
        AppsFlyerTracker.shared().isDebug = true
        
        AppsFlyerTracker.shared().resolveDeepLinkURLs?.append("click.sflink.afsdktests.com")
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sendLaunch),
                                               // For Swift version < 4.2 replace name argument with the commented out code
            name: UIApplication.didBecomeActiveNotification, //.UIApplicationDidBecomeActive for Swift < 4.2
            object: nil)
        return true
    }
    
    // Deeplinking
    
    // Open URI-scheme for iOS 9 and above
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, options: options)
        return true
    }
    
    // Open URI-scheme for iOS 8 and below
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }
    
    // Open Univerasal Links
    // For Swift version < 4.2 replace function signature with the commented out code
    // func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool { // this line for Swift < 4.2
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppsFlyerTracker.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
    
    // Report Push Notification attribution data for re-engagements
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppsFlyerTracker.shared().handlePushNotification(userInfo)
    }
    
    
    // Mark: AppsFlyerTrackerDelegate implementation
    
    //Mark: Handle Conversion Data (Deferred Deep Link)
    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {
       // print("\(data)")
        for (key,value) in data{
            print("GCD key: \(key), value: \(value)")
        }
        
        if let status = data["af_status"] as? String{
            if(status == "Non-organic"){
                if let sourceID = data["media_source"] , let campaign = data["campaign"]{
                    print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                }
            } else {
                print("This is an organic install.")
            }
            if let is_first_launch = data["is_first_launch"] , let launch_code = is_first_launch as? Int {
                if(launch_code == 1){
                    print("First Launch")
                    //navigate using af_sub1
                    if let navigateTo = data["af_sub1"] as? String {
                        setNavigateTo(navigateTo: navigateTo)
                    }
                } else {
                    print("Not First Launch")
                }
            }
        }
        
//        if let navigateTo = data["af_sub1"] as? String {
//            setNavigateTo(navigateTo: navigateTo)
//        }
        
    }
    func onConversionDataFail(_ error: Error) {
        print("\(error)")
    }
    
    //Handle Direct Deep Link
    func onAppOpenAttribution(_ data: [AnyHashable: Any]) {
        print("OAOA")
        if let link = data["link"]{
            print("link:  \(link)")
        }
        for (key,value) in data{
            print("key: \(key), value: \(value)")
        }
        
        //this seems to work if the user has to login.
        if let navigateTo = data["af_sub1"] as? String {
            setNavigateTo(navigateTo: navigateTo)
        }
        
        //If the app is already opena dn user is already logged in - how do we know??? Force change rootview controller? Seems sketch
        let mainStoryboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        let navigateVC : UIViewController
        switch (navigateTo){
        case "1099":
            navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "Dashboard1099ViewController") as? Dashboard1099ViewController)!
            
        case "promo":
            navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "PromotionViewController") as? PromotionViewController)!

        default:
            navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "DashboardHomeViewController") as? DashboardHomeViewController)!
        }
        print(navigateVC)
        //check logged in.
        if UserDefaults.standard.bool(forKey:"isLoggedIn")  {
//            let rootController = window?.rootViewController
//            let currentContoller
            window?.rootViewController?.dismiss(animated: false, completion: nil)
            window?.rootViewController?.present(navigateVC, animated: true, completion: nil)
            //window?.rootViewControlle?
            window?.makeKeyAndVisible()
        }

    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print("\(error)")
    }
    
    // support for scene delegate
    // MARK: UISceneSession Lifecycle
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let ud = UserDefaults.standard
        ud.set(false,forKey: "isLoggedIn")
    }

    private func addUserLogins(){
        //SA AppsFlyer - add username and password to use.
        let username = "appsflyer"
        let password = "password"
        let defaults = UserDefaults.standard
        defaults.set(username,forKey: "username")
        defaults.set(password,forKey: "password")
        
    }
    
    func getNavigateTo() -> String? {
        return navigateTo
    }
    
    func setNavigateTo(navigateTo: String?) {
        self.navigateTo = navigateTo
    }

}

