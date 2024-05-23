//
//  SettingsView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI
import StoreKit
import Photos

@available(iOS 14.0, *)
struct SettingsView: View {
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("investmentGoal") private var investmentGoal: String = ""
    @AppStorage("appTheme") private var appTheme: AppTheme = .system
    
    @State var showImagePicker: Bool = false
    @State var showHelp: Bool = false
    @AppStorage("profileImage") private var profileImageData: Data?
    @State private var permissionStatus: PHAuthorizationStatus = .notDetermined
    
    var body: some View {
        Form {
            Section(header: Text("Profile")) {
                HStack {
                    if(profileImageData == nil){
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                    }else{
                        Image(uiImage: UIImage(data: profileImageData!)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    Button("Edit Photo", action: {
                        // Action to open image picker
                        if (permissionStatus != .authorized){
                            requestPermission()
                            return
                        }
                    showImagePicker = true
                    })
                    Spacer()
                }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }
            
            Section(header: Text("Theme")) {
                Picker("Theme", selection: $appTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.rawValue.capitalized).tag(theme)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Investment")) {
                TextField("Investment Goal", text: $investmentGoal)
            }
            Section(header: Text("App")) {
                Button(action: {
                    // Action to rate the app
                    rateApp()
                }) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("Rate This App")
                    }
                }
                
                Button(action: {
                    // Action to share the app
                    shareApp()
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.blue)
                        Text("Share This App")
                    }
                }
                Button(action: {
                    showHelp = true
                }) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.blue)
                        Text("How it work")
                    }
                }
            }
            
        }
        .navigationTitle("Settings")
        .onChange(of: permissionStatus, perform: { newValue in
            if (permissionStatus == .authorized){
                showImagePicker = true
            }
        })
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                profileImageData = image.pngData()
            }
        }.sheet(isPresented: $showHelp) {
            HowSIPWorkView()
        }
        .onAppear {
            applyTheme(appTheme)
        }
        .onChange(of: appTheme) { newTheme in
            applyTheme(newTheme)
        }
    }
    private func requestPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                self.permissionStatus = status
            }
        }
    }
    func rateApp() {
        // Prompt the user to rate the app (iOS 14.0 and later)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    private func shareApp() {
        // Create a URL for your app (e.g., App Store link)
        guard let appURL = URL(string: "https://apps.apple.com/us/app/calculator/id1069511488") else { return }
        
        // Create a share sheet
        let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
        
        // Present the share sheet
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
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
    SettingsView()
}
