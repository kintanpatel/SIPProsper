//
//  PieChartView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

struct PieChartView: View {
    var data: [(value: Double, label: String, color: Color)]
    
    private var total: Double {
        data.reduce(0) { $0 + $1.value }
    }

    private func angle(for value: Double) -> Angle {
        .degrees(360 * (value / total))
    }

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let radius = size / 2
            let center = CGPoint(x: radius, y: radius)
            
            ZStack {
                ForEach(0..<data.count) { index in
                    let startAngle = index == 0 ? .degrees(0) : angle(for: data[0..<index].map { $0.value }.reduce(0, +))
                    let endAngle = startAngle + angle(for: data[index].value)
                    
                    PieSlice(startAngle: startAngle, endAngle: endAngle)
                        .fill(data[index].color)
                }
            }
            .frame(width: size, height: size)
            
            VStack {
                ForEach(data, id: \.label) { segment in
                    HStack {
                        Text(segment.label)
                            .foregroundColor(segment.color)
                            .font(.headline)
                        Spacer()
                        Text(String(format: "%.2f", segment.value))
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
