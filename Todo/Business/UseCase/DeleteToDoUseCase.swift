//
//  DeleteToDoUseCase.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation
import ToDoFoundation

final class DeleteToDoUseCase: UseCase {

    typealias ResultValue = (Result<Void, Error>)
    typealias RequestValue = ToDoItem
    var repository: ToDoRepository

    init(repository: ToDoRepository) {
        self.repository = repository
    }

    func execute(requestValue: RequestValue, completion: @escaping (ResultValue) -> Void) {
        repository.delete(item: requestValue, qos: .utility) { result in
            if case let .failure(error) = result {
                Logger.error(error)
            }
            completion(result)
        }
    }
}
