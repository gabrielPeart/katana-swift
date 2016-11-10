//
//  AppDelegate.swift
//  KatanaCodingLove
//
//  Copyright © 2016 Bending Spoons.
//  Distributed under the MIT License.
//  See the LICENSE file for more information.

import UIKit
import Katana

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var root: Renderer?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UIViewController()
        self.window?.rootViewController?.view.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
                
        let view = (self.window?.rootViewController?.view)!
        let rootBounds = UIScreen.main.bounds
        
        let store = Store<CodingLoveState>(middlewares: [], dependencies: PostsProvider.self)
        
        self.root = Renderer(rootDescription: CodingLove(props: CodingLove.Props.build({
            $0.frame = rootBounds
        })), store: store)
        
        store.dispatch(FetchMorePosts(payload: ()))
            
        self.root!.render(in: view)
        
        return true
    }
    
}
