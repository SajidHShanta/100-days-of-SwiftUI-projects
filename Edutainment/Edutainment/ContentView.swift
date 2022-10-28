//
//  ContentView.swift
//  Edutainment
//
//  Created by Sajid Shanta on 27/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 1
    @State private var howManyQuestion = 5
    let howManyQuestionOptions = [5, 10, 20]
    
    @State private var multiplier = Int.random(in: 1...5)
    @State private var answer = "0"
    
    @State private var score = 0
    @State private var showingResult = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var numberOfQuestion = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Which multiplication table?")) {
                        Stepper("\(multiplicationTable)", value: $multiplicationTable, in: 1...12)
                    }
                    
                    Section(header: Text("How many question you want to be asked?")) {
                        Picker("How many question you want to be asked?", selection: $howManyQuestion) {
                            ForEach(howManyQuestionOptions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Form {
                    Text("What is \(multiplicationTable) x \(multiplier)?")
                    
                    TextField("Answer", text: $answer)
                        .keyboardType(.numberPad)
                    
                    Button("Answer") {
                        if(Int(answer) == multiplicationTable*multiplier) {
                            score += 1
                            scoreTitle = "Correct!"
                            scoreMessage = numberOfQuestion == howManyQuestion ? "Your final score is: \(score)/\(numberOfQuestion)" : "\(multiplicationTable) x \(multiplier) = \(answer)"
                        } else {
                            scoreTitle = "Wrong!"
                            scoreMessage = "Correct answer will be: \(multiplicationTable) x \(multiplier) = \(multiplicationTable*multiplier)"
                        }
                        showingResult = true
                        askNext()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    
                    Text("Score: \(score)/\(numberOfQuestion)")
                        .font(.headline)
                }
            }
            .padding()
            .navigationBarTitle("Multiplication Table")
        }
        .alert(scoreTitle, isPresented: $showingResult) {
            Button("Ok") { }
        } message: {
            Text(scoreMessage)
        }
    }
    
    func askNext() {
        multiplier = Int.random(in: 1...howManyQuestion)
        if (numberOfQuestion != howManyQuestion) {
            numberOfQuestion += 1
        } else {
            numberOfQuestion = 0
            score = 0
        }
        answer = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
