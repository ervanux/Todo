//
//  CreateToDoUseCase.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation
import ToDoFoundation

final class CreateToDoUseCase: UseCase {

    typealias ResultValue = (Result<Bool, Error>)
    typealias RequestValue = ToDoItem
    var repository: ToDoRepository

    init(repository: ToDoRepository) {
        self.repository = repository
    }

    func execute(requestValue: RequestValue, completion: @escaping (ResultValue) -> Void) {
        guard let title = requestValue.title, title.trimmingCharacters(in: .whitespaces).count > 0 else {
            completion(.success(false))
            return
        }

        repository.create(item: requestValue, qos: .utility) { result in
            if case let .failure(error) = result {
                Logger.error(error)
            }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success:
                completion(.success(true))
            }
        }
    }
}
