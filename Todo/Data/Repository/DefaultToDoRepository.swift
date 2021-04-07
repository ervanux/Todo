//
//  DefaultToDoRepository.swift
//  Todo
//
//  Created by Erkan Ugurlu on 29.03.2021.
//

import Foundation

final class DefaultToDoRepository: ToDoRepository {
    var dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func create(item: ToDoItem, qos: DispatchQoS.QoSClass, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: qos).async { [weak self] in
            guard let self = self else { return }

            do {
                try self.dataSource.create(item: item)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetch(page: Int, qos: DispatchQoS.QoSClass, completion: @escaping (Result<[ToDoItem], Error>) -> Void) {
        DispatchQueue.global(qos: qos).async { [weak self] in
            guard let self = self else { return }

            do {
                let list = try self.dataSource.fetch(page: page)
                completion(.success(list))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func delete(item: ToDoItem, qos: DispatchQoS.QoSClass, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: qos).async { [weak self] in
            guard let self = self else { return }

            do {
                try self.dataSource.delete(item: item)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func update(key: Date, item: ToDoItem, qos: DispatchQoS.QoSClass, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: qos).async { [weak self] in
            guard let self = self else { return }

            do {
                try self.dataSource.update(key: key, item: item)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
