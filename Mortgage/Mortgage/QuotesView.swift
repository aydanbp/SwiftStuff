//
//  ContentView.swift
//  Mortgage
//
//  Created by Philip Trwoga on 14/10/2024.
//

import SwiftUI
import SwiftData

struct QuotesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var quotes: [MortgageModel]
    
    var body: some View {
        VStack{
            Text("Quotes List")
            List(quotes){quote in
                VStack{
                    HStack{
                        Image(systemName: "house.fill")
                            .foregroundStyle(Color(.blue))
                        Text("Lender")
                        Text(quote.lender)
                            .bold()
                    }
                    HStack{
                        Image(systemName: "banknote")
                            .foregroundStyle(Color(.blue))
                        Text("Loan amount")
                        Text("£\(quote.amount)")
                    }
                    HStack{
                        Image(systemName: "percent")
                            .foregroundStyle(Color(.blue))
                        Text("Interest")
                        Text("\(quote.interest)%")
                    }
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundStyle(Color(.blue))
                        Text("Period")
                        Text("\(quote.period) years")
                    }
                    HStack{
                        Image(systemName: "sterlingsign")
                            .foregroundStyle(Color(.blue))
                        Text("Payment")
                        Text("\(quote.payment)")
                    }
                }
            }
        }
    }
}

#Preview {
    QuotesView()
}



