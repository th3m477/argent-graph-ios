//  This file was automatically generated and should not be edited.

import Apollo

public final class AddressQuery: GraphQLQuery {
  /// query address($domain: String) {
  ///   domains(where: {name: $domain}) {
  ///     __typename
  ///     name
  ///     resolvedAddress {
  ///       __typename
  ///       id
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query address($domain: String) { domains(where: {name: $domain}) { __typename name resolvedAddress { __typename id } } }"

  public let operationName = "address"

  public var domain: String?

  public init(domain: String? = nil) {
    self.domain = domain
  }

  public var variables: GraphQLMap? {
    return ["domain": domain]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("domains", arguments: ["where": ["name": GraphQLVariable("domain")]], type: .nonNull(.list(.nonNull(.object(Domain.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(domains: [Domain]) {
      self.init(unsafeResultMap: ["__typename": "Query", "domains": domains.map { (value: Domain) -> ResultMap in value.resultMap }])
    }

    public var domains: [Domain] {
      get {
        return (resultMap["domains"] as! [ResultMap]).map { (value: ResultMap) -> Domain in Domain(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Domain) -> ResultMap in value.resultMap }, forKey: "domains")
      }
    }

    public struct Domain: GraphQLSelectionSet {
      public static let possibleTypes = ["Domain"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("resolvedAddress", type: .object(ResolvedAddress.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, resolvedAddress: ResolvedAddress? = nil) {
        self.init(unsafeResultMap: ["__typename": "Domain", "name": name, "resolvedAddress": resolvedAddress.flatMap { (value: ResolvedAddress) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var resolvedAddress: ResolvedAddress? {
        get {
          return (resultMap["resolvedAddress"] as? ResultMap).flatMap { ResolvedAddress(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "resolvedAddress")
        }
      }

      public struct ResolvedAddress: GraphQLSelectionSet {
        public static let possibleTypes = ["Account"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "Account", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class DomainsQuery: GraphQLQuery {
  /// query domains($address: ID) {
  ///   accounts(where: {id: $address}) {
  ///     __typename
  ///     domains {
  ///       __typename
  ///       name
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query domains($address: ID) { accounts(where: {id: $address}) { __typename domains { __typename name } } }"

  public let operationName = "domains"

  public var address: GraphQLID?

  public init(address: GraphQLID? = nil) {
    self.address = address
  }

  public var variables: GraphQLMap? {
    return ["address": address]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("accounts", arguments: ["where": ["id": GraphQLVariable("address")]], type: .nonNull(.list(.nonNull(.object(Account.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(accounts: [Account]) {
      self.init(unsafeResultMap: ["__typename": "Query", "accounts": accounts.map { (value: Account) -> ResultMap in value.resultMap }])
    }

    public var accounts: [Account] {
      get {
        return (resultMap["accounts"] as! [ResultMap]).map { (value: ResultMap) -> Account in Account(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Account) -> ResultMap in value.resultMap }, forKey: "accounts")
      }
    }

    public struct Account: GraphQLSelectionSet {
      public static let possibleTypes = ["Account"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("domains", type: .nonNull(.list(.nonNull(.object(Domain.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(domains: [Domain]) {
        self.init(unsafeResultMap: ["__typename": "Account", "domains": domains.map { (value: Domain) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var domains: [Domain] {
        get {
          return (resultMap["domains"] as! [ResultMap]).map { (value: ResultMap) -> Domain in Domain(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Domain) -> ResultMap in value.resultMap }, forKey: "domains")
        }
      }

      public struct Domain: GraphQLSelectionSet {
        public static let possibleTypes = ["Domain"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Domain", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}
