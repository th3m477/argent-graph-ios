//  This file was automatically generated and should not be edited.

import Apollo

public enum GuardianState: RawRepresentable, Equatable, Hashable, CaseIterable, JSONDecodable, JSONEncodable {
  public typealias RawValue = String
  case requestedAddition
  case requestedRevocation
  case added
  case revoked
  case canceledAddition
  case canceledRevocation
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "requestedAddition": self = .requestedAddition
      case "requestedRevocation": self = .requestedRevocation
      case "added": self = .added
      case "revoked": self = .revoked
      case "canceledAddition": self = .canceledAddition
      case "canceledRevocation": self = .canceledRevocation
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .requestedAddition: return "requestedAddition"
      case .requestedRevocation: return "requestedRevocation"
      case .added: return "added"
      case .revoked: return "revoked"
      case .canceledAddition: return "canceledAddition"
      case .canceledRevocation: return "canceledRevocation"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: GuardianState, rhs: GuardianState) -> Bool {
    switch (lhs, rhs) {
      case (.requestedAddition, .requestedAddition): return true
      case (.requestedRevocation, .requestedRevocation): return true
      case (.added, .added): return true
      case (.revoked, .revoked): return true
      case (.canceledAddition, .canceledAddition): return true
      case (.canceledRevocation, .canceledRevocation): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [GuardianState] {
    return [
      .requestedAddition,
      .requestedRevocation,
      .added,
      .revoked,
      .canceledAddition,
      .canceledRevocation,
    ]
  }
}

public final class GuardiansQuery: GraphQLQuery {
  /// query Guardians($wallet: Bytes) {
  ///   guardians(where: {wallet: $wallet}) {
  ///     __typename
  ///     id
  ///     address
  ///     active
  ///     updatedAt
  ///     activeAfter
  ///     revokeAfter
  ///   }
  /// }
  public let operationDefinition =
    "query Guardians($wallet: Bytes) { guardians(where: {wallet: $wallet}) { __typename id address active updatedAt activeAfter revokeAfter } }"

  public let operationName = "Guardians"

  public var wallet: String?

  public init(wallet: String? = nil) {
    self.wallet = wallet
  }

  public var variables: GraphQLMap? {
    return ["wallet": wallet]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("guardians", arguments: ["where": ["wallet": GraphQLVariable("wallet")]], type: .nonNull(.list(.nonNull(.object(Guardian.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(guardians: [Guardian]) {
      self.init(unsafeResultMap: ["__typename": "Query", "guardians": guardians.map { (value: Guardian) -> ResultMap in value.resultMap }])
    }

    public var guardians: [Guardian] {
      get {
        return (resultMap["guardians"] as! [ResultMap]).map { (value: ResultMap) -> Guardian in Guardian(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Guardian) -> ResultMap in value.resultMap }, forKey: "guardians")
      }
    }

    public struct Guardian: GraphQLSelectionSet, Identifiable {
      public static let possibleTypes = ["Guardian"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("active", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("updatedAt", type: .scalar(String.self)),
        GraphQLField("activeAfter", type: .scalar(String.self)),
        GraphQLField("revokeAfter", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, address: String, active: Bool, updatedAt: String? = nil, activeAfter: String? = nil, revokeAfter: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Guardian", "id": id, "address": address, "active": active, "updatedAt": updatedAt, "activeAfter": activeAfter, "revokeAfter": revokeAfter])
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

      public var address: String {
        get {
          return resultMap["address"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address")
        }
      }

      public var active: Bool {
        get {
          return resultMap["active"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "active")
        }
      }

      public var updatedAt: String? {
        get {
          return resultMap["updatedAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var activeAfter: String? {
        get {
          return resultMap["activeAfter"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "activeAfter")
        }
      }

      public var revokeAfter: String? {
        get {
          return resultMap["revokeAfter"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "revokeAfter")
        }
      }
    }
  }
}

public final class GuardianActivityQuery: GraphQLQuery {
  /// query GuardianActivity($wallet: Bytes) {
  ///   guardianActivities(where: {wallet: $wallet}) {
  ///     __typename
  ///     id
  ///     address
  ///     state
  ///     date
  ///   }
  /// }
  public let operationDefinition =
    "query GuardianActivity($wallet: Bytes) { guardianActivities(where: {wallet: $wallet}) { __typename id address state date } }"

  public let operationName = "GuardianActivity"

  public var wallet: String?

  public init(wallet: String? = nil) {
    self.wallet = wallet
  }

  public var variables: GraphQLMap? {
    return ["wallet": wallet]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("guardianActivities", arguments: ["where": ["wallet": GraphQLVariable("wallet")]], type: .nonNull(.list(.nonNull(.object(GuardianActivity.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(guardianActivities: [GuardianActivity]) {
      self.init(unsafeResultMap: ["__typename": "Query", "guardianActivities": guardianActivities.map { (value: GuardianActivity) -> ResultMap in value.resultMap }])
    }

    public var guardianActivities: [GuardianActivity] {
      get {
        return (resultMap["guardianActivities"] as! [ResultMap]).map { (value: ResultMap) -> GuardianActivity in GuardianActivity(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GuardianActivity) -> ResultMap in value.resultMap }, forKey: "guardianActivities")
      }
    }

    public struct GuardianActivity: GraphQLSelectionSet, Identifiable {
      public static let possibleTypes = ["GuardianActivity"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(GuardianState.self))),
        GraphQLField("date", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, address: String, state: GuardianState, date: String) {
        self.init(unsafeResultMap: ["__typename": "GuardianActivity", "id": id, "address": address, "state": state, "date": date])
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

      public var address: String {
        get {
          return resultMap["address"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address")
        }
      }

      public var state: GuardianState {
        get {
          return resultMap["state"]! as! GuardianState
        }
        set {
          resultMap.updateValue(newValue, forKey: "state")
        }
      }

      public var date: String {
        get {
          return resultMap["date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date")
        }
      }
    }
  }
}
