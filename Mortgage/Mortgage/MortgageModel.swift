//
//  MortgageModel.swift
//  Mortgage
//
//  Created by Philip Trwoga on 16/10/2024.
//

import Foundation
import SwiftData

@Model class MortgageModel : Identifiable{
    
    
    var lender: String
    var amount : String
    var interest : String
    var period : String
    var payment : String
 
    init(lender: String, amount: String, interest: String, period: String, payment : String) {
        self.lender = lender
        self.amount = amount
        self.interest = interest
        self.period = period
        self.payment = payment
    }
    
}
