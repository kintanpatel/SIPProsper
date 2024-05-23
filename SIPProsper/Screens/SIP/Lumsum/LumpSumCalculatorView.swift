//
//  LumpSumCalculatorView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

@available(iOS 14.0, *)
struct LumpSumCalculatorView: View {
    @State private var principalAmount: String = ""
    @State private var annualInterestRate: String = ""
    @State private var investmentPeriod: String = ""
    @State private var isLoading: Bool = false
    @State private var showResult: Bool = false
    @State private var calculatedMaturityAmount: Double = 0.0
    @State private var calculatedInterestEarned: Double = 0.0

    var body: some View {
        NavigationView {
            VStack {
                if(isLoading){
                    LoadingView()
                }else{
                    Form {
                        Section(header: Text("Investment Details")) {
                            TextField("Principal Amount", text: $principalAmount)
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
                                        showResult = true
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
                    }
                }
                

                // NavigationLink placed outside the Form to avoid taking up visible space in the Form
                NavigationLink(
                    destination: LumpSumResultView(
                        principalAmount: Double(principalAmount) ?? 0.0,
                        maturityAmount: calculatedMaturityAmount,
                        interestEarned: calculatedInterestEarned
                    ),
                    isActive: $showResult
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("LumpSum Calculator")
        }
    }

    private func calculateMaturityAmount() {
        let P = Double(principalAmount) ?? 0.0
        let r = (Double(annualInterestRate) ?? 0.0) / 100
        let t = Double(investmentPeriod) ?? 0.0

        if P > 0 && r > 0 && t > 0 {
            let amount = P * pow(1 + r, t)
            calculatedMaturityAmount = amount
            calculatedInterestEarned = amount - P
        }
    }
}
@available(iOS 14.0, *)
#Preview {
    NavigationView{
        LumpSumCalculatorView()
    }
}
