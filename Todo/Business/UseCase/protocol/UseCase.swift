//
//  UseCase.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation

protocol UseCase: class {
    associatedtype RequestValue
    associatedtype ResultValue

    var repository: ToDoRepository {get set}

    init(repository: ToDoRepository)
    func execute(requestValue: RequestValue, completion: @escaping (ResultValue) -> Void)
}
