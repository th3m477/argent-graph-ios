//
//  ContentView.swift
//  Guardian Explorer
//
//  Created by Matt Marshall on 20/09/2019.
//  Copyright © 2019 Matt Marshall. All rights reserved.
//

import SwiftUI

struct LookupView: View {
    @State var walletAddress = ""
    @State var showDetail = false
        
    var body: some View {
        NavigationView() {
            Form() {
                TextField("Wallet address", text: $walletAddress)
                Button(action: {
                    self.showDetail = true
                }) {
                    HStack() {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Lookup")
                    }
                }
            }
            .navigationBarTitle("Argent Graph")
        }
        .accentColor(Color("ArgentGreen"))
        .sheet(isPresented: $showDetail) {
            NavigationView() {
                DetailView(guardianData: GuardianModel(walletAddress: self.walletAddress))
            }
            .accentColor(Color("ArgentGreen"))
        }
    }
}

struct LookupView_Previews: PreviewProvider {
    static var previews: some View {
        Group() {
            LookupView()
            LookupView().environment(\.colorScheme, .dark)
        }
    }
}
