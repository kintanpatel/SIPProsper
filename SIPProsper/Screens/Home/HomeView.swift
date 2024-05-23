//
//  HomeView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI
@available(iOS 14.0, *)
struct HomeView: View {
    @AppStorage("appTheme") private var appTheme: AppTheme = .system
    
    var body: some View {
        TabView {
            SIPCalculatorView()
                .tabItem {
                    Label("SIP Calculator", systemImage: "chart.bar.doc.horizontal")
                }
            
            LumpSumCalculatorView()
                .tabItem {
                    Label("LumpSum Calculator", systemImage: "chart.pie")
                }
            SettingsView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }.onAppear {
            applyTheme(appTheme)
        }
    }
    private func applyTheme(_ theme: AppTheme) {
        switch theme {
        case .light:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        case .dark:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        case .system:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
        }
    }
}
@available(iOS 14.0, *)
#Preview {
    HomeView()
}
