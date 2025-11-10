import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Register for remote notifications if needed in the future
        UNUserNotificationCenter.current().delegate = self

        return true
      }

      // [START receive_message]
      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // Print full message.
        print("push userInfo 1:", userInfo)
        sendPushToWebView(userInfo: userInfo)
      }

      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Print full message.
        print("push userInfo 2:", userInfo)
        sendPushToWebView(userInfo: userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
      }

      // [END receive_message]
      func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
      }
    }

    // [START ios_10_message_handling]
    extension AppDelegate : UNUserNotificationCenterDelegate {

      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        // Print full message.
        print("push userInfo 3:", userInfo)
        sendPushToWebView(userInfo: userInfo)

        // Change this to your preferred presentation option
        completionHandler([[.banner, .list, .sound]])
      }

      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse,
                                  withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        // Print full message.
        print("push userInfo 4:", userInfo)
        sendPushClickToWebView(userInfo: userInfo)

        completionHandler()
      }
    }
    // [END ios_10_message_handling]
