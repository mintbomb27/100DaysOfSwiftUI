//
//  ContentView.swift
//  Project1_WeSplit
//
//  Created by Alok N on 16/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = "0"
    @State private var numberPeople = 2
    @State private var tipPercentage = 2
    let tips = [2,5,10,15,20]
    
    var finalAmount: Double {
        let peopleCount = Double(numberPeople + 2)
        let tipP = Double(tips[tipPercentage])
        let dAmount = Double(amount) ?? 0
        var finalAmt = Double((tipP/100.0)*dAmount + dAmount)
        finalAmt = finalAmt/peopleCount
        return finalAmt
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberPeople){
                        ForEach(2 ..< 101){
                            Text("\($0)")
                        }
                    }
                }
                Section(header: Text("How much do you wanna tip?")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0 ..< tips.count){
                            Text("\(self.tips[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Text("Amount: ₹\(finalAmount, specifier:"%0.2f")")
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
