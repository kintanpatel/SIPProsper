//
//  SIPProsperApp.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

@main
struct SIPProsperAppWrapper {
    static func main() {
        if #available(iOS 14.0, *) {
            SIPProsperApp.main()
        }
        else {
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(SceneDelegate.self))
        }
    }
}
 

@available(iOS 14.0, *)
struct SIPProsperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
