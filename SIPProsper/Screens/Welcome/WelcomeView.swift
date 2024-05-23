//
//  WelcomView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

struct WelcomeView: View {
    @State var isLoading : Bool = true
    
    var body: some View {
        ZStack{
            if(isLoading){
                LoadingView(label: "")
            }else{
                WelcomeScreenContentView()
            }
            
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                isLoading.toggle()
            })
        })
        
    }
}


struct WelcomeScreenContentView: View {
    @State var openHomeView : Bool = false
   
    var body: some View {
        if(openHomeView){
            HomeView()
        }else{
            ZStack {
                Image("calc")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Welcome to SIPProsper")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .gradientForeground(colors: [.random,.random,.random]).padding()
                    
                    Spacer()
                    Button(action: {
                        withAnimation {
                            openHomeView = true
                        }
                        
                    }, label: {
                        Text("Let's Start")
                            .font(.title)
                            .padding()
                            .background(Color.random.opacity(0.7))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }).padding()
                    
                }
            }
        }
    }
}





#Preview {
    WelcomeView()
}
