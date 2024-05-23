//
//  HowSIPWorkView.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import SwiftUI

import SwiftUI

struct HowSIPWorkView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("How do SIP calculators work?")
                    .font(.title)
                    .padding(.bottom, 10)
                
                Text("""
A SIP plan calculator works on the following formula –

M = P × ({[1 + i]^n – 1} / i) × (1 + i).

In the above formula –

M is the amount you receive upon maturity.
P is the amount you invest at regular intervals.
n is the number of payments you have made.
i is the periodic rate of interest.

Take for example you want to invest Rs. 1,000 per month for 12 months at a periodic rate of interest of 12%.

then the monthly rate of return will be 12%/12 = 1/100=0.01

Hence, M = 1,000X ({[1 +0.01 ]^{12} – 1} / 0.01) x (1 + 0.01)

which gives Rs 12,809 Rs approximately in a year.

The rate of interest on a SIP will differ as per market conditions. It may increase or decrease, which will change the estimated returns.
""")
                    .padding(.bottom, 10)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("How SIP Works")
    }
}

 
#Preview {
    HowSIPWorkView()
}
