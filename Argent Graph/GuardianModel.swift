//
//  GuardianModel.swift
//  Argent Graph
//
//  Created by Matt Marshall on 22/09/2019.
//  Copyright © 2019 Matt Marshall. All rights reserved.
//

import Foundation

final class GuardianModel: ObservableObject {
    let walletAddress: String
    @Published private(set) var pending = [Guardian]()
    @Published private(set) var active = [Guardian]()
    @Published private(set) var activity = [GuardianActivity]()
    
    init(walletAddress: String) {
        self.walletAddress = walletAddress
        reload()
    }
    
    private func reload() {
        let q = GuardiansQuery(wallet: walletAddress)
        Apollo.shared.client.fetch(query: q) {
            result in
            guard let data = try? result.get().data else { return }
            self.pending = data.guardians.filter { !$0.active }
            self.active = data.guardians.filter { $0.active }
        }
        
        let q2 = GuardianActivityQuery(wallet: walletAddress)
        Apollo.shared.client.fetch(query: q2) {
            result in
            guard let data = try? result.get().data else { return }
            self.activity = data.guardianActivities
                .sorted(by: { (lhs, rhs) -> Bool in
                    lhs.date.date > rhs.date.date
            })
        }
    }
}
