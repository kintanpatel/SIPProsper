//
//  SIPView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

struct SIPCalculatorView: View {
    @State private var monthlyInvestment: String = ""
    @State private var annualInterestRate: String = ""
    @State private var investmentPeriod: String = ""
    @State private var maturityAmount: String = "Result will be shown here"
    @State private var investmentData: [InvestmentData] = []
    @State private var isLoading: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Investment Details")) {
                TextField("Monthly Investment", text: $monthlyInvestment)
                    .keyboardType(.decimalPad)
                
                TextField("Annual Interest Rate (%)", text: $annualInterestRate)
                    .keyboardType(.decimalPad)
                
                TextField("Investment Period (Years)", text: $investmentPeriod)
                    .keyboardType(.numberPad)
            }
            
            Section {
                Button(action: {
                    isLoading = true
                    withAnimation {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            calculateMaturityAmount()
                            isLoading = false
                        }
                    }
                    
                }) {
                    Text("Calculate")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            
            Section(header: Text("Maturity Amount")) {
                if isLoading {
                    GeometryReader { geometry in
                        LoadingView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(Color.clear)
                    }
                    .frame(height: 100)
                } else {
                    Text(maturityAmount)
                        .font(.title)
                }
            }
            
            if !investmentData.isEmpty {
                Section(header: Text("Investment Growth Over Time")) {
                    ScrollView(.horizontal) {
                        InvestmentChartView(data: investmentData)
                            .frame(height: 300)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: HowSIPWorkView()) {
                    Image(systemName: "questionmark.circle")
                }
            }
        }
        .navigationTitle("SIP Calculator")
        
    }
    
    private func calculateMaturityAmount() {
        let P = Double(monthlyInvestment) ?? 0.0
        let r = (Double(annualInterestRate) ?? 0.0) / 100 / 12
        let n = (Double(investmentPeriod) ?? 0.0) * 12
        
        if P > 0 && r > 0 && n > 0 {
            let amount = P * ((pow(1 + r, n) - 1) / r) * (1 + r)
            maturityAmount = String(format: "₹ %.2f", amount)
            calculateInvestmentData(P: P, r: r, n: n)
        } else {
            maturityAmount = "Invalid Input"
            investmentData = []
        }
    }
    
    private func calculateInvestmentData(P: Double, r: Double, n: Double) {
        investmentData = []
        for year in 1...Int(n / 12) {
            let yearMonths = Double(year * 12)
            let amount = P * ((pow(1 + r, yearMonths) - 1) / r) * (1 + r)
            investmentData.append(InvestmentData(year: year, amount: amount))
        }
    }
}


#Preview {
    SIPCalculatorView()
}

