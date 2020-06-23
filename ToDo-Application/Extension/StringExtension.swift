//
//  StringExtension.swift
//  ToDo-Application
//
//  Created by macbook on 6/22/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
