//
//  ContentView.swift
//  WeSplit
//
//  Created by Sajid Shanta on 7/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        return (checkAmount + (checkAmount * tipSelection / 100)) / peopleCount
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        return checkAmount + (checkAmount * tipSelection / 100)
    }
    
    var dollarFormat : FloatingPointFormatStyle<Double>.Currency {
       let currencyCode = Locale.current.currencyCode ?? "USD"  // Get user's preference, or use default
       return FloatingPointFormatStyle<Double>.Currency( code: currencyCode )
    }
     
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your name", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) Peoples")
                        }
                    }
                }
                
//                Section {
//                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                } header: {
//                    Text("How much tip do you want to leave?")
//                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmount, format: dollarFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("Total amount for the check")
                }
                
                
                Section {
                    Text(totalPerPerson, format: dollarFormat)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//NavigationView {
//    Form {
//        Text("Hello, world!")
//
//        Group {
//            Text("Hello, world!")
//            Text("Hello, world!")
//        }
//
//        Group {
//            Text("Hello, world!")
//            Text("Hello, world!")
//        }
//
//        Section {
//            Text("Hello, world!")
//            Text("Hello, world!")
//        }
//    }
//    .navigationTitle("SwiftUI")
//    .navigationBarTitleDisplayMode(.inline)
//}



//@State private var tapCount = 0
//@State private var name = ""
//var body: some View {
//    Form {
//        TextField("Enter your name", text: $name)
//        Text("Your name is \(name)")
//    }
////        Button("Tap Count \(tapCount)"){
////            tapCount += 1
////        }
//}
