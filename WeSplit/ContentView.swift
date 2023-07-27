//
//  ContentView.swift
//  WeSplit
//
//  Created by Abu Sayeed Roni on 2023-07-25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var billAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Double = 0.2
    let tipPercentages: [Double] = [0.25, 0.2, 0.15, 0.1, 0.05, 0.0]
    
    private var individualBillAmount: Double {
        // Calculate individual bill amount.
        (billAmount + billAmount * tipPercentage) / Double(numberOfPeople)
    }
    
    @FocusState private var isFocusedBillAmount: Bool
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Bill amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocusedBillAmount)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1..<100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Overall")
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tips")
                }
                
                Section {
                    Text(individualBillAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Individual")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocusedBillAmount = false
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
