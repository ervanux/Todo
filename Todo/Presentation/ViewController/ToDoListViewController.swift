//
//  ToDoListViewController.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import UIKit

class ToDoListViewController: UITableViewController {

    private let cellIdentifier = "CellWithSingleTitle"
    private var todoList = [ToDoItem]()

    private let listToDoUseCase: ListToDoUseCase
    private let deleteToDoUseCase: DeleteToDoUseCase

    required init?(coder: NSCoder, listUseCase: ListToDoUseCase, deleteUseCase: DeleteToDoUseCase) {
        listToDoUseCase = listUseCase
        deleteToDoUseCase = deleteUseCase
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Implement paging
        let page = 1
        list(page)
    }
}

// MARK: - Table view data source
extension ToDoListViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = todoList[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = todoList.remove(at: indexPath.row)
            delete(item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//Initiations for segue
extension ToDoListViewController {

    @IBSegueAction
    func createDetailViewController(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ToDoDetailViewController? {
        return RootFactory.instance.makeDetailVC(coder: coder)
    }

    @IBSegueAction
    func updateDetailViewController(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ToDoDetailViewController? {
        guard let cell = sender as? UITableViewCell else {
            return nil
        }
        guard let selectedIndex = tableView.indexPath(for: cell) else {
            return nil
        }

        return RootFactory.instance.makeDetailVC(coder: coder, item: todoList[selectedIndex.row])
    }
}

//Usecase calls
private extension ToDoListViewController {

    func list(_ page: Int) {
        listToDoUseCase.execute(requestValue: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                self.todoList = list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.showAlert(message: "error_list".localized)
                }
            }
        }
    }

    func delete(_ item: ToDoItem) {
        deleteToDoUseCase.execute(requestValue: item) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                break
            case .failure:
                DispatchQueue.main.async {
                    self.showAlert(message: "error_delete".localized)
                }
            }
        }
    }
}
