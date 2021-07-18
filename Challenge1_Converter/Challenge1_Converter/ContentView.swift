//
//  ContentView.swift
//  Challenge1_Converter
//
//  Created by Alok N on 18/07/21.
//

import SwiftUI

struct ContentView: View {
    
    let measures: [String:[String]] = [
        "Length": ["m","km", "ft", "yd", "mi"],//4
        "Temperature": ["C","F", "K"], //2
        "Time": ["sec","min", "hrs", "days"],//3
        "Volume": ["ml","l", "cup", "pint", "gal"]//4
    ]
    
    @State var selectedMeasure = 0;
    @State var selectedInput = 0;
    @State var selectedOutput = 0;
    @State var measurement = "";
    var selectedUnit: String{
        return "\(Array(measures.keys)[selectedMeasure])"
    }
    var inputs: [String]{
        return measures[selectedUnit] ?? [""]
    }
    var inputValue: Double {
        var convertedMeasure = Double(measurement) ?? 0;
        switch(selectedUnit){
        case "Length":
            switch(inputs[selectedInput>4 ? 0:selectedInput]){//converting everything to Meter
            case "km": convertedMeasure*=1000;
            case "ft": convertedMeasure/=3.281;
            case "yd": convertedMeasure/=1.094;
            case "mi": convertedMeasure*=1609.34;
                default:break;
            }
        case "Temperature":
            switch(inputs[selectedInput>2 ? 0:selectedInput]){//converting everything to kelvin
            case "C": convertedMeasure+=273.15;
            case "F": convertedMeasure = (convertedMeasure-32)*(5/9.0)+273.15;
                default:break;
            }
        case "Time":
            switch(inputs[selectedInput>3 ? 0:selectedInput]){//converting everything to seconds
            case "min": convertedMeasure*=60;
            case "hrs": convertedMeasure*=3600;
            case "days": convertedMeasure*=86400;
                default:break;
            }
        case "Volume":
            switch(inputs[selectedInput>3 ? 0:selectedInput]){//converting everything to ml
            case "l": convertedMeasure*=1000;
            case "cup": convertedMeasure*=236.588;
            case "pint": convertedMeasure*=473.176;
            case "gal": convertedMeasure*=3785.41
                default:break;
            }
        default:
            break
        }
        return convertedMeasure;
    }
    var outputValue: Double {
        var convertedMeasure = inputValue;
        switch(selectedUnit){
        case "Length":
            switch(inputs[selectedOutput>4 ? 0:selectedOutput]){//converting everything to Meter
            case "km": convertedMeasure/=1000;
            case "ft": convertedMeasure*=3.281;
            case "yd": convertedMeasure*=1.094;
            case "mi": convertedMeasure/=1609.34;
                default:break;
            }
        case "Temperature":
            switch(inputs[selectedOutput>2 ? 0:selectedOutput]){//converting everything to kelvin
            case "C": convertedMeasure-=273.15;
            case "F": convertedMeasure = (convertedMeasure-273.15)*(9.0/5.0)+32;
                default:break;
            }
        case "Time":
            switch(inputs[selectedOutput>3 ? 0:selectedOutput]){//converting everything to seconds
            case "min": convertedMeasure/=60;
            case "hrs": convertedMeasure/=3600;
            case "days": convertedMeasure/=86400;
                default:break;
            }
        case "Volume":
            switch(inputs[selectedOutput>4 ? 0:selectedOutput]){//converting everything to ml
            case "l": convertedMeasure/=1000;
            case "cup": convertedMeasure/=236.588;
            case "pint": convertedMeasure/=473.176;
            case "gal": convertedMeasure/=3785.41
                default:break;
            }
        default:
            break
        }
        return convertedMeasure;
    }
    
    var body: some View {
        NavigationView{
            Form{
                Picker(selection: $selectedMeasure, label:Text("Select your measure")){
                    ForEach(0 ..< measures.count){
                        Text(Array(measures.keys)[$0])
                    }
                }
                Section(header: Text("Input Measurement")){
                    TextField("Input your measurement", text: $measurement)
                        .keyboardType(.decimalPad)
                    Picker(selection: $selectedInput, label:Text("Select your input")){
                        ForEach(0 ..< inputs.count, id:\.self){
                            Text(inputs[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Output Measurement")){
                    Text("\(outputValue)")
                    Picker(selection: $selectedOutput, label:Text("Select your output")){
                        ForEach(0 ..< inputs.count, id:\.self){
                            Text(inputs[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Convert!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
