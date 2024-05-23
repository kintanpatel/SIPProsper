//
//  BarView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

struct BarView: View {
    var value: Double
    var maxValue: Double
    var label: String
    
    var body: some View {
        VStack {
            Text(String(format: "%.0f", value))
                .font(.caption)
                .padding(.bottom, 5) // Adjust padding as needed to position the text above the bar
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.blue)
                .frame(height: CGFloat(value / maxValue) * 200)
            
            Text(label)
                .font(.caption)
        }
        
    }
}
