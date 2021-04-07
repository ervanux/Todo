//
//  DataSource.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation

protocol DataSource {

    func fetch(page: Int) throws -> [ToDoItem]
    func create(item: ToDoItem) throws
    func delete(item: ToDoItem) throws
    func update(key: Date, item: ToDoItem) throws
}
