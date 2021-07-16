//
//  ContentView.swift
//  Project1_WeSplit
//
//  Created by Alok N on 16/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = ""
    @State private var numberPeople = "2"
    @State private var tipPercentage = 2
    let tips = [2,5,10,15,20]
    
    var total: Double {
        let tipP = Double(tips[tipPercentage])
        let dAmount = Double(amount) ?? 0
        let finalAmt = Double((tipP/100.0)*dAmount + dAmount)
        return finalAmt
    }
    
    var perPerson: Double {
        let peopleCount = Double(numberPeople) ?? 0 + 2
        var finalAmt = total
        finalAmt = finalAmt/peopleCount
        return finalAmt
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Amount Details")){
                    TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberPeople){
//                        ForEach(2 ..< 101){
//                            Text("\($0)")
//                        }
                        TextField("Number of People", text: $numberPeople)
                            .keyboardType(.numberPad)
                    }
                }
                Section(header: Text("How much do you wanna tip?")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0 ..< tips.count){
                            Text("\(self.tips[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total Amount")){
                    Text("Amount: ₹ \(total, specifier:"%0.2f")")
                }
                Section(header: Text("Amount per Person")){
                    Text("Amount: ₹ \(perPerson, specifier:"%0.2f")")
                }
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
