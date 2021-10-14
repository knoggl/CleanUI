//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

public extension UIDevice {
    
    /// Returns true if the current device is an iPad, false if not
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// Returns true if the current device is an iPhone, false if not
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

