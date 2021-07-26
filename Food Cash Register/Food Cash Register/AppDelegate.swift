//
//  AppDelegate.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import UIKit
import SquarePointOfSaleSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        guard SCCAPIResponse.isSquareResponse(url) else {
//            return false
//        }

        do {
            let response = try SCCAPIResponse(responseURL: url)

            if let error = response.error {
                // Handle a failed request.
                print("erroe")
            } else {
                // Handle a successful request.
                print("sucess")
            }

        } catch let error as NSError {
            // Handle unexpected errors.
            print(error.localizedDescription)
        }

        return true
    }


}

