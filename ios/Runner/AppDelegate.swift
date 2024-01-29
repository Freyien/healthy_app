import UIKit
import Flutter
import workmanager
// import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)


    // This is required to make any communication available in the action isolate.
    // FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    //     GeneratedPluginRegistrant.register(with: registry)
    // }
      
    // if #available(iOS 10.0, *) {
    //     UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    // }

    // Work manager
    UNUserNotificationCenter.current().delegate = self
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in  
      GeneratedPluginRegistrant.register(with: registry)
    }
    WorkmanagerPlugin.registerTask(withIdentifier: "com.freyien.healthy.app.water.reminder")
    
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler(.alert) // shows banner even if app is in foreground
  }
}
