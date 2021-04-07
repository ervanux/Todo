//
//  Log.swift
//  ToDoFoundation
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation

public struct Logger {

    public static func error(_ closure: @autoclosure () -> Any) {
        print("E: \(closure())")
    }

    public static func warning(_ closure: @autoclosure () -> Any) {
        print("W: \(closure())")
    }
}
