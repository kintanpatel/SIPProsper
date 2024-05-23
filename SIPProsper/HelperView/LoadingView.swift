//
//  LoadingView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

struct LoadingView: View {
   @State private var isAnimating: Bool = false
    var label : String = "Calculating..."
   
   var body: some View {
       VStack {
           Image(systemName: "gear")
               .resizable()
               .frame(width: 50, height: 50)
               .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
               .animation(
                   Animation.linear(duration: 1)
                       .repeatForever(autoreverses: false)
               )
               .onAppear {
                   self.isAnimating = true
               }
           Text(label)
               .font(.headline)
               .padding(.top, 10)
       }
   }
}
#Preview{
   LoadingView()
}
