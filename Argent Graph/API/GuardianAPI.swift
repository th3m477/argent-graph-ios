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
  ///     removeAfter
  ///   }
  ///   pendingGuardians(where: {wallet: $wallet}) {
  ///     __typename
  ///     id
  ///     address
  ///     addAfter
  ///   }
  ///   guardianActivities(where: {wallet: $wallet}) {
  ///     __typename
  ///     id
  ///     address
  ///     state
  ///     date
  ///   }
  /// }
  public let operationDefinition =
    "query Guardians($wallet: Bytes) { guardians(where: {wallet: $wallet}) { __typename id address removeAfter } pendingGuardians(where: {wallet: $wallet}) { __typename id address addAfter } guardianActivities(where: {wallet: $wallet}) { __typename id address state date } }"

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
      GraphQLField("pendingGuardians", arguments: ["where": ["wallet": GraphQLVariable("wallet")]], type: .nonNull(.list(.nonNull(.object(PendingGuardian.selections))))),
      GraphQLField("guardianActivities", arguments: ["where": ["wallet": GraphQLVariable("wallet")]], type: .nonNull(.list(.nonNull(.object(GuardianActivity.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(guardians: [Guardian], pendingGuardians: [PendingGuardian], guardianActivities: [GuardianActivity]) {
      self.init(unsafeResultMap: ["__typename": "Query", "guardians": guardians.map { (value: Guardian) -> ResultMap in value.resultMap }, "pendingGuardians": pendingGuardians.map { (value: PendingGuardian) -> ResultMap in value.resultMap }, "guardianActivities": guardianActivities.map { (value: GuardianActivity) -> ResultMap in value.resultMap }])
    }

    public var guardians: [Guardian] {
      get {
        return (resultMap["guardians"] as! [ResultMap]).map { (value: ResultMap) -> Guardian in Guardian(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Guardian) -> ResultMap in value.resultMap }, forKey: "guardians")
      }
    }

    public var pendingGuardians: [PendingGuardian] {
      get {
        return (resultMap["pendingGuardians"] as! [ResultMap]).map { (value: ResultMap) -> PendingGuardian in PendingGuardian(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PendingGuardian) -> ResultMap in value.resultMap }, forKey: "pendingGuardians")
      }
    }

    public var guardianActivities: [GuardianActivity] {
      get {
        return (resultMap["guardianActivities"] as! [ResultMap]).map { (value: ResultMap) -> GuardianActivity in GuardianActivity(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GuardianActivity) -> ResultMap in value.resultMap }, forKey: "guardianActivities")
      }
    }

    public struct Guardian: GraphQLSelectionSet, Identifiable {
      public static let possibleTypes = ["Guardian"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("removeAfter", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, address: String, removeAfter: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Guardian", "id": id, "address": address, "removeAfter": removeAfter])
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

      public var removeAfter: String? {
        get {
          return resultMap["removeAfter"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "removeAfter")
        }
      }
    }

    public struct PendingGuardian: GraphQLSelectionSet, Identifiable {
      public static let possibleTypes = ["PendingGuardian"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("addAfter", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, address: String, addAfter: String) {
        self.init(unsafeResultMap: ["__typename": "PendingGuardian", "id": id, "address": address, "addAfter": addAfter])
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

      public var addAfter: String {
        get {
          return resultMap["addAfter"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "addAfter")
        }
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
