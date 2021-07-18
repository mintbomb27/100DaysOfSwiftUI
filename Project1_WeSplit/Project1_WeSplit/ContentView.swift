//
//  ContentView.swift
//  Project1_WeSplit
//
//  Created by Alok N on 16/07/21.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: VARIABLES
    @State private var amount = ""
    @State private var numberPeople = ""
    @State private var tipPercentage = 2
    let tips = [2,5,10,15,20]
    
    //TOTAL CALCUATION
    var total: Double {
        let tipP = Double(tips[tipPercentage])
        let dAmount = Double(amount) ?? 0
        let finalAmt = Double((tipP/100.0)*dAmount + dAmount)
        return finalAmt
    }
    //CONVERTING TO PER PERSON
    var perPerson: Double {
        let peopleCount = Double(numberPeople) ?? 0 + 2
        var finalAmt = total
        finalAmt = finalAmt/peopleCount
        return finalAmt
    }
    //MARK: BODY
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Amount Details")){
                    TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberPeople){
                        TextField("Number of People", text: $numberPeople)
                            .keyboardType(.numberPad)
                    }//PICKER
                }//INPUT SECTION 1
                Section(header: Text("How much do you wanna tip?")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0 ..< tips.count){
                            Text("\(self.tips[$0])%")
                        }//FOR
                    }//PICKER 2
                    .pickerStyle(SegmentedPickerStyle())
                }//INPUT SECTION 2
                Section(header: Text("Total Amount")){
                    Text("Amount: ₹ \(total, specifier:"%0.2f")")
                }//OUTPUT SECTION 3
                Section(header: Text("Amount per Person")){
                    Text("Amount: ₹ \(perPerson, specifier:"%0.2f")")
                }//OUTPUT SECTION 4
            }//FORM
        .navigationBarTitle("WeSplit")
        }//NAVIGATION VIEW
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
