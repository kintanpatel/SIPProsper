//
//  InvestmentChartView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

struct InvestmentChartView: View {
    var data: [InvestmentData]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            ForEach(data) { point in
                BarView(value: point.amount, maxValue: data.max(by: { $0.amount < $1.amount })?.amount ?? 1, label: "\(point.year)")
            }
        }
        .padding(.horizontal, 2) // Padding to prevent bars from touching the edges
    }
}
