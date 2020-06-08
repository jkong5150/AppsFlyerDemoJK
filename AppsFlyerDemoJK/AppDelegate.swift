//
//  AppDelegate.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 2/15/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import UIKit
import AppsFlyerLib
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,AppsFlyerTrackerDelegate {

    var window: UIWindow?
     var navigateTo: String?
    
    @objc func sendLaunch(app:Any) {
        AppsFlyerTracker.shared().trackAppLaunch()
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*** CHANGE THE VERTICAL!!! (Retail, Finance, etc.) *****/
        let vertical : String = Verticals.finance.rawValue
        /*** SA CHANGE THIS!!!!   *****/
        
        //add dummy user logins
        configure(vertical: vertical)
        //define the vertical
        
        //push
        registerForPushNotifications()
        
        
        AppsFlyerTracker.shared().appsFlyerDevKey = "tRiUHG43JTfCZrp6LnXrhD"
        AppsFlyerTracker.shared().appleAppID = "211122514"
        AppsFlyerTracker.shared().delegate = self
        /* Set isDebug to true to see AppsFlyer debug logs */
        AppsFlyerTracker.shared().isDebug = true
        
        AppsFlyerTracker.shared().resolveDeepLinkURLs = ["click.sflink.afsdktests.com"]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sendLaunch),
                                               // For Swift version < 4.2 replace name argument with the commented out code
            name: UIApplication.didBecomeActiveNotification, //.UIApplicationDidBecomeActive for Swift < 4.2
            object: nil)
        setRootVC()
        return true
    }
    
    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register: \(error)")
    }
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
    }
    
    // Deeplinking
    
    // Open URI-scheme for iOS 9 and above
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("Here is the URL: \(url)")
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
    
    
    // MARK: *** AppsFlyerTrackerDelegate implementation ***
    
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
            //push the modal
            pushDeepLinkVC()
        }
        
    }
    
//Mark:  CUSTOMIZE
    private func pushDeepLinkVC(){
        let mainStoryboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        let navigateVC : UIViewController
        switch (navigateTo){
            case DeepLinkConfig.DEEPLINK1:
                //PUSH the screen on not set root.
                navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: DeepLink1ViewController.identifier) as? DeepLink1ViewController)!

            case DeepLinkConfig.DEEPLINK2:
                navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: DeepLink2ViewController.identifier) as? DeepLink2ViewController)!

            default:
                //navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: VerticalLoaderViewController.identifier) as? VerticalLoaderViewController)!
                navigateVC = navigateToVertical()
        }
        
        //CUSOTMIZE UI
        //navigateVC.modalPresentationStyle = .fullScreen
        navigateVC.view.backgroundColor = .black
        navigateVC.view.alpha = 0.95
        let labels = navigateVC.view.subviews.compactMap { $0 as? UILabel }
        let buttons = navigateVC.view.subviews.compactMap { $0 as? UIButton }

        for label in labels {
        //Do something with label
            label.textColor = .white
        }
        for button in buttons {
            button.titleLabel?.textColor = .white
            
        }
        window?.rootViewController?.present(navigateVC, animated: true, completion: nil)
    }
    
//    private func getTopVC()->UIViewController {
//        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//        var vc: UIViewController
//        if var topController = keyWindow?.rootViewController {
//            while let presentedViewController = topController.presentedViewController {
//                topController = presentedViewController
//            }
//            vc = topController
//        }
//        return vc
//    }
    
    private func setRootVC(){
        let navigateVC : UIViewController
        switch (navigateTo){
//            case DeepLinkConfig.DEEPLINK1:
//                //PUSH the screen on not set root.
//                navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: DeepLink1ViewController.identifier) as? DeepLink1ViewController)!
//
//            case DeepLinkConfig.DEEPLINK2:
//                navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: DeepLink2ViewController.identifier) as? DeepLink2ViewController)!

            default:
                //navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: VerticalLoaderViewController.identifier) as? VerticalLoaderViewController)!
                navigateVC = navigateToVertical()
        }
        //check logged in.
//        if UserDefaults.standard.bool(forKey:"isLoggedIn")  {
//            let rootController = window?.rootViewController
//            let currentContoller
        //window?.rootViewController?.dismiss(animated: false, completion: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController?.modalPresentationStyle = .fullScreen
        window?.rootViewController = navigateVC
        //window?.rootViewController?.present(navigateVC, animated: true, completion: nil)
        window?.makeKeyAndVisible()
//        }
    }
    
    private func navigateToVertical() -> UIViewController{
        let vc: UIViewController
        let vertical = UserDefaults.standard.object(forKey: "vertical") as? String
        switch (vertical){
        case Verticals.retail.rawValue:
            vc =  naviagateToRetail()
        case Verticals.finance.rawValue:
            vc =  navigateToFinance()
        default:
            vc =  navigateToFinance()
        }
        return vc
    }

    // MARK: Vertical View controllers (Retail, Finance, etc.)
    private func navigateToFinance() -> UIViewController {
        let mainStoryboard = UIStoryboard(name:"Main",bundle:nil)//Bundle.main)
        let navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: FinanceLoginViewController.identifier) as? FinanceLoginViewController)!
        return navigateVC
    }
    
    private func naviagateToRetail() -> UIViewController {
        let mainStoryboard = UIStoryboard(name:"Retail",bundle:Bundle.main)
        let navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: RetailViewController.identifier) as? RetailViewController)!
        return navigateVC
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

    private func configure(vertical: String){
        //SA AppsFlyer - add username and password to use.
        let username = "appsflyer"
        let password = "password"
        let defaults = UserDefaults.standard
        defaults.set(username,forKey: "username")
        defaults.set(password,forKey: "password")
        defaults.set(vertical,forKey: "vertical")
        
    }
        
    func getNavigateTo() -> String? {
        return navigateTo
    }
    
    func setNavigateTo(navigateTo: String?) {
        self.navigateTo = navigateTo
    }
    // MARK: *** Push Notifications ***
    func registerForPushNotifications() {
//            UNUserNotificationCenter.current()
//                .requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
//                    print("Permission granted: \(granted)")
//            }
        UNUserNotificationCenter.current()
          .requestAuthorization(options: [.alert, .sound, .badge]) {
            [weak self] granted, error in
              
            print("Permission granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
        }
    }
    

    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }

}

