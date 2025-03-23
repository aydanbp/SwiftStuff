//
//  MortgageMainView.swift
//  Mortgage
//
//  Created by Philip Trwoga on 14/10/2024.
//

import SwiftUI
import SwiftData

struct MortgageMainView: View {
    @FocusState private var fieldIsFocused: Bool
    @State var lender : String = "none"
    @State var amount : String = "300000"
    @State var interest : String = "4"
    @State var period : String = "25"
    @State var payment : String = ""
    @State private var MAlert = false
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        VStack{
            Text("Mortgage Calculator")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            //your code here for main UI
            //pattern is:
            //labels and textfields
            //button
            //payment output
            
            //lender
            HStack{
                Image(systemName: "house.fill")
                Text("Lender")
                Spacer()
                Spacer()
                TextField("", text: $lender)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            //Amount
            HStack{
                Image(systemName: "sterlingsign")
                Text("Amount")
                Spacer()
                Spacer()
                TextField("", text: $amount)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            //Interest
            HStack{
                Image(systemName: "percent")
                Text("Interest")
                Spacer()
                Spacer()
                TextField("", text: $interest)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            //Period
            HStack{
                Image(systemName: "calendar")
                Text("Period (years)")
                Spacer()
                Spacer()
                TextField("", text: $period)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
            .padding()
            Button(action:{
                if period == "" || interest == "" || amount == "" || lender == "" {
                    MAlert = true
                }
                calculateMortgage()
            } ){
                Text("Calculate Payment")
            }
            .alert("Error, one or more fields are empty.\n Please fill in all fields", isPresented: $MAlert){
                Button("Ok") {
                    
                }
            }
            
            
            Text("Payment is \(payment)")

            

        }

    }
    func calculateMortgage(){
        var amountD = 0.0
        var interestD = 0.0
        var periodD = 0.0
        //convert to doubles
        if !amount.isEmpty {
            amountD = Double(amount)!
        }
        if !interest.isEmpty {
            interestD = Double(interest)!
            interestD = interestD/100.0/12
        }
        if !period.isEmpty {
            periodD = Double(period)!
            periodD = periodD*12
        }
        
        let top = (amountD * interestD) * pow((1.0 + interestD),Double(periodD))
        let lower = pow((1.0 + interestD),Double(periodD)) - 1
        let paymentValue = top/lower
        payment = String(format: "£%.2f",paymentValue)
        //add code to insert a new MortgageModel object into the Swift Datat context
        let m = MortgageModel(lender: lender, amount: amount, interest: interest,period: period, payment: payment)
        modelContext.insert(m)
        hideKeyboard()
    }
    
    
    
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
#Preview {
    MortgageMainView()
}
