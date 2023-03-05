//
//  AppDelegate.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/21.
//

import UIKit

import AuthenticationServices
import KakaoSDKCommon
import KakaoSDKAuth

import FirebaseMessaging
import FirebaseCore


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(#function)
        
        
        KakaoSDK.initSDK(appKey: "d594d72f1d6a6935702b35865faf122f")
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()
        return true
        
        
        //        let appleIDProvider = ASAuthorizationAppleIDProvider()
        //        appleIDProvider.getCredentialState(forUserID: /* 로그인에 사용한 User Identifier */) { (credentialState, error) in
        //            switch credentialState {
        //            case .authorized:
        //                // The Apple ID credential is valid.
        //                print("해당 ID는 연동되어있습니다.")
        //            case .revoked
        //                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
        //                print("해당 ID는 연동되어있지않습니다.")
        //            case .notFound:
        //                // The Apple ID credential is either was not found, so show the sign-in UI.
        //                print("해당 ID를 찾을 수 없습니다.")
        //            default:
        //                break
        //            }
        //        }
        //        return true
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("Firebase registration token: \(String(describing: fcmToken))")

          let dataDict: [String: String] = ["token": fcmToken ?? ""]
          NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
          )
        
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
              } else if let token = token {
                  User.shared.fcmToken = token
                 print("FCM registration token: \(token)")
              }
        }
        
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication,
                      didFailToRegisterForRemoteNotificationsWithError error: Error) {
       print("Unable to register for remote notifications: \(error.localizedDescription)")
     }
    
    
    
    
}
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: /* 로그인에 사용한 User Identifier */) { (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                // The Apple ID credential is valid.
//                print("해당 ID는 연동되어있습니다.")
//            case .revoked
//                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
//                print("해당 ID는 연동되어있지않습니다.")
//            case .notFound:
//                // The Apple ID credential is either was not found, so show the sign-in UI.
//                print("해당 ID를 찾을 수 없습니다.")
//            default:
//                break
//            }
//        }
//        return true
//    }

    
    


    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
