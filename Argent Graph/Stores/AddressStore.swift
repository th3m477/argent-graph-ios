//
//  AddressStore.swift
//  Argent Graph
//
//  Created by Matt Marshall on 25/09/2019.
//  Copyright © 2019 Argent. All rights reserved.
//

import Foundation

final class AddressStore: ObservableObject {
    @Published private(set) var domainsPerAddress = [String:[String]]()
  
    func loadDomains(for address: String) {
        print("Lookup domains for \(address)")
        guard !domainsPerAddress.keys.contains(address) else { return }
        
        let q = DomainsQuery(address: address)
        Apollo.shared.ens.fetch(query: q) { result in
            guard let data = try? result.get().data else { return }
            let domainObjs = data.accounts.flatMap { $0.domains }
            let domains = domainObjs.compactMap { $0.name }
            if !domains.isEmpty {
                self.domainsPerAddress[address] = domains
            }
        }
    }
}

let addressStore = AddressStore()
