//  See LICENSE folder for this project’s licensing information.

import UIKit
import Firebase
import Fabric
import Crashlytics
import OneSignal
import Siren

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor(named: "PANTONE 18-3838 Ultra Violet")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.white
        
        FirebaseApp.configure()
        
        Fabric.sharedSDK().debug = true
        Fabric.with([Crashlytics.self])
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            self.window                     = UIWindow(frame: UIScreen.main.bounds)
            let storyboard                  = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController       = storyboard.instantiateViewController(withIdentifier: "NavigationControllerScene")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
            OneSignal.initWithLaunchOptions(launchOptions,
                                            appId: "27e0850b-03ef-43de-9d27-408c280161bd",
                                            handleNotificationAction: nil,
                                            settings: onesignalInitSettings)
            OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                print("User accepted notifications: \(accepted)")
            })
            print("\nUser presented Main Scene\n")
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            self.window                     = UIWindow(frame: UIScreen.main.bounds)
            let storyboard                  = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController       = storyboard.instantiateViewController(withIdentifier: "OnboardingScene")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            print("\nUser presented Onboarding Scene\n")
        }
        
        setupSiren()
        
        // TODO: Move this to where you establish a user session
        self.logUser()
        
        return true
    }
    
    func setupSiren() {
        let siren            = Siren.shared
        siren.delegate       = self
        siren.debugEnabled   = true
        siren.alertType      = .option // .option, .force, .skip, .none
        siren.alertMessaging = SirenAlertMessaging(updateTitle: "New Version Now Available",
                                                   updateMessage: "Would you like this update?",
                                                   updateButtonMessage: "Right Now Please",
                                                   nextTimeButtonMessage: "Maybe Next Time",
                                                   skipVersionButtonMessage: "Keep Things “Glitchy”")
        siren.showAlertAfterCurrentVersionHasBeenReleasedForDays = 1
    }
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
        Crashlytics.sharedInstance().setUserIdentifier("12345")
        Crashlytics.sharedInstance().setUserName("Test User")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        Siren.shared.checkVersion(checkType: .immediately)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        Siren.shared.checkVersion(checkType: .daily)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate: SirenDelegate {

    func sirenDidShowUpdateDialog(alertType: Siren.AlertType) {
        print(#function, alertType)
    }
    
    func sirenUserDidCancel() {
        print(#function)
    }
    
    func sirenUserDidSkipVersion() {
        print(#function)
    }
    
    func sirenUserDidLaunchAppStore() {
        print(#function)
    }
    
    func sirenDidFailVersionCheck(error: Error) {
        print(#function, error)
    }
    
    func sirenLatestVersionInstalled() {
        print(#function, "Latest version of app is installed")
    }
    
    // This delegate method is only hit when alertType is initialized to .none
    func sirenDidDetectNewVersionWithoutAlert(message: String, updateType: UpdateType) {
        print(#function, "\(message).\nRelease type: \(updateType.rawValue.capitalized)")
    }
}
