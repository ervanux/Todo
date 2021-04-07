//
//  RootFactory.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation
import UIKit

class RootFactory {
    static let instance = RootFactory()
    private let repository: ToDoRepository

    private init() {
        let dataSource = CodeDataSource()
        repository = DefaultToDoRepository(dataSource: dataSource)
    }

    func makeDetailVC(coder: NSCoder) -> ToDoDetailViewController? {
        let createUseCase = CreateToDoUseCase(repository: repository)
        return ToDoDetailViewController(coder: coder, createUseCase: createUseCase)
    }

    func makeDetailVC(coder: NSCoder, item: ToDoItem) -> ToDoDetailViewController? {
        let deleteUseCase = DeleteToDoUseCase(repository: repository)
        let updateUseCase = UpdateToDoUseCase(repository: repository)
        return ToDoDetailViewController(coder: coder, item: item, deleteUseCase: deleteUseCase, updateUseCase: updateUseCase)
    }

    func makeListVC(coder: NSCoder) -> ToDoListViewController? {
        let listUseCase = ListToDoUseCase(repository: repository)
        let deleteUseCase = DeleteToDoUseCase(repository: repository)
        return ToDoListViewController(coder: coder, listUseCase: listUseCase, deleteUseCase: deleteUseCase)
    }
}
