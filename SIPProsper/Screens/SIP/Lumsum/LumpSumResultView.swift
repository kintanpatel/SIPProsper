//
//  LumpSumResultView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

struct LumpSumResultView: View {
    var principalAmount: Double
    var maturityAmount: Double
    var interestEarned: Double

    var body: some View {
        VStack {
            Text("LumpSum Investment Result")
                .font(.title)
                .padding()

            Text(String(format: "Principal Amount: ₹ %.2f", principalAmount))
                .font(.headline)
            Text(String(format: "Maturity Amount: ₹ %.2f", maturityAmount))
                .font(.headline)
            Text(String(format: "Interest Earned: ₹ %.2f", interestEarned))
                .font(.headline)

            PieChartView(data: [
                (value: principalAmount, label: "Principal", color: .blue),
                (value: interestEarned, label: "Interest", color: .green)
            ])
            .frame(height: 300)
            .padding()
        }
        .navigationTitle("Investment Summary")
    }
}

struct LumpSumResultView_Previews: PreviewProvider {
    static var previews: some View {
        LumpSumResultView(principalAmount: 1000, maturityAmount: 1200, interestEarned: 200)
    }
}

#Preview {
    LumpSumResultView(principalAmount: 1000, maturityAmount: 1200, interestEarned: 200)

}
