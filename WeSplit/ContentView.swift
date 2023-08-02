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
    
    let tipPercentages: [Double] = (0...100).map {
        Double($0) / 100.0
    }
    
    private var totalBillAmount: Double {
        billAmount + billAmount * tipPercentage
    }
    
    private var individualBillAmount: Double {
        totalBillAmount / Double(numberOfPeople)
    }
    
    private var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    private var currency: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: currencyCode)
    }
    
    @FocusState private var isFocusedBillAmount: Bool
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Bill amount", value: $billAmount, format: currency)
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
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Tips")
                }
                
                Section {
                    Text(individualBillAmount, format: currency)
                } header: {
                    Text("Individual")
                }
                
                Section {
                    Text(totalBillAmount, format: currency)
                        .foregroundColor(tipPercentage == 0 ? .red : .black)    // if the user leaves no tip, the total bill is displayed in red.
                } header: {
                    Text("Total Bill")
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
