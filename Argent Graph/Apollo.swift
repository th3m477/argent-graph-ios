//
//  Apollo.swift
//  Argent Graph
//
//  Created by Matt Marshall on 22/09/2019.
//  Copyright © 2019 Matt Marshall. All rights reserved.
//

import Foundation
import Apollo

typealias Guardian = GuardiansQuery.Data.Guardian
typealias GuardianActivity = GuardianActivityQuery.Data.GuardianActivity

final class Apollo {
  static let shared = Apollo()
    
  private(set) lazy var client = ApolloClient(url: URL(string: "https://api.thegraph.com/subgraphs/name/th3m477/argent")!)
}
