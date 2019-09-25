//
//  GuardianModel.swift
//  Argent Graph
//
//  Created by Matt Marshall on 22/09/2019.
//  Copyright © 2019 Matt Marshall. All rights reserved.
//

import Foundation

final class GuardianStore {
    private var guardianModels = [GuardianModel]()
    
    func getModel(for identifier: String) -> GuardianModel {
        if let model = guardianModels.first(where: { $0.ensOrAddress == identifier }) {
            return model
        }
        
        let newModel = GuardianModel(ensOrAddress: identifier)
        guardianModels.append(newModel)
        return newModel
    }
}

let guardianStore = GuardianStore()

final class GuardianModel: ObservableObject {
    var resolvedAddress: String?
    let ensOrAddress: String
    @Published private(set) var pending = [PendingGuardian]()
    @Published private(set) var active = [Guardian]()
    @Published private(set) var activity = [GuardianActivity]()
    
    fileprivate init(ensOrAddress: String) {
        self.ensOrAddress = ensOrAddress
        if ensOrAddress.count == 42, ensOrAddress.starts(with: "0x") {
            resolvedAddress = ensOrAddress
        }
        reload()
    }
    
    private func reload() {
        if ensOrAddress.count == 42, ensOrAddress.starts(with: "0x") {
            reload(address: ensOrAddress)
            addressStore.loadDomains(for: ensOrAddress)
        } else if ensOrAddress.contains(".") {
            lookupENSThenReload(ens: ensOrAddress)
        } else {
            lookupENSThenReload(ens: "\(ensOrAddress.lowercased()).argent.xyz")
            addressStore.loadDomains(for: ensOrAddress)
        }
    }
    
    private func lookupENSThenReload(ens: String) {
        let q = AddressQuery(domain: ens)
        Apollo.shared.ens.fetch(query: q) { result in
            guard let data = try? result.get().data else { return }
            let potentialAddresses = data.domains.compactMap { $0.resolvedAddress }
            if let anyAddress = potentialAddresses.first {
                self.resolvedAddress = anyAddress.id
                self.reload(address: anyAddress.id)
            }
        }
    }
    
    private func reload(address: String) {
        print("Reload data for \(address)")
        let q = GuardiansQuery(wallet: address)
        Apollo.shared.argent.fetch(query: q) {
            result in
            guard let data = try? result.get().data else { return }
            self.pending = data.pendingGuardians
            self.active = data.guardians
            self.activity = data.guardianActivities
                .sorted(by: { (lhs, rhs) -> Bool in
                    lhs.date.date > rhs.date.date
            })
            
            let allAddresses = data.pendingGuardians.compactMap { $0.address }
                + data.guardians.compactMap { $0.address }
                + data.guardianActivities.compactMap { $0.address }
            _ = allAddresses.map { addressStore.loadDomains(for: $0) }
        }
    }
}
