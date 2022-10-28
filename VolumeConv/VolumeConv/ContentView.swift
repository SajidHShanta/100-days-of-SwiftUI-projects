//
//  ContentView.swift
//  VolumeConv
//
//  Created by Sajid Shanta on 8/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber: Double = 0.0
    @State private var inputUnit: String = "milliliter"
    @State private var convertedUnit: String = "cup"
    
    let volumeUnits = ["milliliter", "liter", "cup", "pint", "gallon"]

    func toMl(number: Double, unit: String) -> Double {
        switch(unit) {
        case volumeUnits[0]:
            return number
        case volumeUnits[1]:
            return number*1000
        case volumeUnits[2]:
            return number*236.6
        case volumeUnits[3]:
            return number*473.2
        case volumeUnits[4]:
            return number*3785
        default:
            return 0
        }
    }
    
    func mlTo(number: Double, unit: String) -> Double{
        // to-do
        switch(unit) {
        case volumeUnits[0]:
            return number
        case volumeUnits[1]:
            return number/1000
        case volumeUnits[2]:
            return number/236.6
        case volumeUnits[3]:
            return number/473.2
        case volumeUnits[4]:
            return number/3785
        default:
            return 0
        }
    }
    
    var convertedVolume: Double {
        let ml = toMl(number: inputNumber, unit: inputUnit)
        
        return mlTo(number: ml, unit: convertedUnit)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter the Number", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                    Picker("Select Inpur Unit", selection: $inputUnit) {
                        ForEach(volumeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input Volume")
                }
                
                Section {
                    Picker("Select unit to convert", selection: $convertedUnit) {
                        ForEach(volumeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("Select unit to convert")
                }
                
                Section {
                    Text("\(convertedVolume.formatted()) \(convertedUnit)")
                } header: {
                    Text("Converted Volume")
                }
            }
            .navigationTitle("VolumeConv")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
