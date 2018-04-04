//
//  AppDelegate.swift
//  JustDoIt
//
//  Created by Brandon Wilmott on 3/13/18.
//  Copyright © 2018 Brandon Wilmott. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
  //      print(Realm.Configuration.defaultConfiguration.fileURL)
    
        do{
            _ =  try Realm()
   
        }catch{
            print("error persisting data, \(error)")
        }
    
        
        return true
    }

 



}

