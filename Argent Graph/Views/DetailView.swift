//
//  DetailView.swift
//  Guardian Explorer
//
//  Created by Matt Marshall on 21/09/2019.
//  Copyright © 2019 Matt Marshall. All rights reserved.
//

import SwiftUI

fileprivate var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .medium
    df.timeStyle = .medium
    return df
}()

extension String {
    var date: Date {
        guard let secs = UInt(self) else { preconditionFailure("Expected to create date") }
        return Date(timeIntervalSince1970: TimeInterval(secs))
    }
    
    var shortAddress: String {
        guard let startTo = index(startIndex, offsetBy: 7, limitedBy: endIndex),
            let endFrom = index(endIndex, offsetBy: -6, limitedBy: startIndex) else {
                return self
        }
        
        return String(self[startIndex..<startTo]) + "..." + self[endFrom..<endIndex]
    }
}

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var guardianData: GuardianModel
        
    var body: some View {
        List() {
            Section(header: Text("Pending Guardians")) {
                if guardianData.pending.isEmpty {
                    EmptyInfoView(guardianType: "pending Guardians")
                }
                ForEach(guardianData.pending) { g in
                    PendingGuardianRowView(guardian: g)
                }
            }
            Section(header: Text("Active Guardians")) {
                if guardianData.active.isEmpty {
                    EmptyInfoView(guardianType: "active Guardians")
                }
                ForEach(guardianData.active) { g in
                    GuardianRowView(guardian: g)
                }
            }
            Section(header: Text("Guardian History")) {
                if guardianData.activity.isEmpty {
                    EmptyInfoView(guardianType: "history")
                }
                ForEach(guardianData.activity) { a in
                    GuardianActivityRowView(activity: a)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(guardianData.walletAddress.shortAddress)
        .navigationBarItems(trailing: Button(action: {
self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        }))
    }
}

struct PendingGuardianRowView: View {
    let guardian: PendingGuardian
    
    var body: some View {
        NavigationLink(destination: DetailView(guardianData: GuardianModel(walletAddress: guardian.address))) {
            VStack() {
                Text(guardian.address.shortAddress)
                Text(dateFormatter.string(from: guardian.addAfter.date))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct GuardianRowView: View {
    let guardian: Guardian
    
    var subtitle: String? {
        if let date = guardian.removeAfter?.date {
            return "Remove after \(dateFormatter.string(from: date))"
        }
        
        return nil
    }
    
    var body: some View {
        NavigationLink(destination: DetailView(guardianData: GuardianModel(walletAddress: guardian.address))) {
            VStack() {
                Text(guardian.address.shortAddress)
                if subtitle != nil {
                    Text(subtitle!)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

extension GuardianState {
    public func description(date: Date) -> String {
        let dateStr = dateFormatter.string(from: date)
        
        switch self {
        case .requestedAddition:
            return "Requested addition at \(dateStr)"
        case .requestedRevocation:
            return "Requested removal at \(dateStr)"
        case .added:
            return "Added at \(dateStr)"
        case .revoked:
            return "Removed at \(dateStr)"
        case .canceledAddition:
            return "Canceled addition at \(dateStr)"
        case .canceledRevocation:
            return "Canceled removal at \(dateStr)"
        case .__unknown(_):
            return "Unknown"
        }
    }
}

struct GuardianActivityRowView: View {
    let activity: GuardianActivity
    
    var body: some View {
        NavigationLink(destination: DetailView(guardianData: GuardianModel(walletAddress: activity.address))) {
            VStack(alignment: .leading) {
                Text(activity.address.shortAddress)
                Text(activity.state.description(date: activity.date.date))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct EmptyInfoView: View {
    let guardianType: String
    
    var body: some View {
        Text("No \(guardianType)")
            .foregroundColor(.gray)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView() {
            DetailView(guardianData: GuardianModel(walletAddress: "0x0"))
        }
    }
}
