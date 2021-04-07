//
//  UpdateToDoUseCase.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation
import ToDoFoundation

final class UpdateToDoUseCase: UseCase {

    typealias ResultValue = (Result<Bool, Error>)
    typealias RequestValue = (oldItem: ToDoItem, newItem: ToDoItem)
    var repository: ToDoRepository

    init(repository: ToDoRepository) {
        self.repository = repository
    }

    func execute(requestValue: RequestValue, completion: @escaping (ResultValue) -> Void) {
        guard requestValue.oldItem.title != requestValue.newItem.title
                || requestValue.oldItem.detail != requestValue.newItem.detail else {
            completion(.success(false))
            return
        }

        guard let title = requestValue.newItem.title, title.trimmingCharacters(in: .whitespaces).count > 0 else {
            completion(.success(false))
            return
        }

        repository.update(key: requestValue.oldItem.createDate, item: requestValue.newItem, qos: .utility) { result in
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
