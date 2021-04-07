//
//  ToDoRepository.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation

protocol ToDoRepository {
    var dataSource: DataSource { get set }
    init(dataSource: DataSource)
    func fetch(page: Int, qos: DispatchQoS.QoSClass, completion: @escaping (Result<[ToDoItem], Error>) -> Void)
    func create(item: ToDoItem, qos: DispatchQoS.QoSClass, completion: @escaping (Result<Void, Error>) -> Void)
    func delete(item: ToDoItem, qos: DispatchQoS.QoSClass, completion: @escaping (Result<Void, Error>) -> Void)
    func update(key: Date, item: ToDoItem, qos: DispatchQoS.QoSClass, completion: @escaping (Result<Void, Error>) -> Void)
}
