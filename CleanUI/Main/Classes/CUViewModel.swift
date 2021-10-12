//
//  CUViewModel.swift
//  CleanUI
//
//  Created by Julian Gerhards on 12.10.21.
//

import SwiftUI

/// This is the base class for every view model
public class CUViewModel: ObservableObject {
    
    public init () {}

    /// Every ``CUViewModel`` gets its own unique id
    public let id: UUID = UUID()
    
    /// We save the `Date` when the ``CUViewModel`` got created
    public let createdDate: Date = Date()
    
    /// This method returns the number of seconds since the time the ``CUViewModel`` got created
    /// - Returns: The number of seconds since the time the ``CUViewModel`` got created
    public func activeSinceSeconds() -> Int {
        return Int(Date().timeIntervalSince(createdDate))
    }
}