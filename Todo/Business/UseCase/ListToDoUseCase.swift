//
//  ListToDoUseCase.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation
import ToDoFoundation

final class ListToDoUseCase: UseCase {

    typealias ResultValue = (Result<[ToDoItem], Error>)
    typealias RequestValue = Int
    var repository: ToDoRepository

    init(repository: ToDoRepository) {
        self.repository = repository
    }

    func execute(requestValue: RequestValue, completion: @escaping (ResultValue) -> Void) {
        repository.fetch(page: requestValue, qos: .utility) { result in
            if case let .failure(error) = result {
                Logger.error(error)
            }
            completion(result)
        }
    }
}
