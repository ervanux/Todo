//
//  String.swift
//  ToDoFoundation
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation

public extension String {

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
