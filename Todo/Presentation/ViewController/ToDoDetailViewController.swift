//
//  ToDoDetailViewController.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import UIKit
import ToDoFoundation

//There can be a good way to split view states for update and create.
class ToDoDetailViewController: UIViewController {
    private static let titleCharacterLimit = 20
    private static let detailCharacterLimit = 200

    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var detailTv: UITextView!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!

    var createUseCase: CreateToDoUseCase?
    var deleteUseCase: DeleteToDoUseCase?
    var updateUseCase: UpdateToDoUseCase?

    var currentItem: ToDoItem?

    required init?(coder: NSCoder, createUseCase: CreateToDoUseCase) {
        self.createUseCase = createUseCase
        super.init(coder: coder)
        self.title = "addNewTitle".localized
        navigationItem.rightBarButtonItems?.removeFirst()
    }

    required init?(coder: NSCoder, item: ToDoItem, deleteUseCase: DeleteToDoUseCase, updateUseCase: UpdateToDoUseCase) {
        self.deleteUseCase = deleteUseCase
        self.updateUseCase = updateUseCase
        currentItem = item
        super.init(coder: coder)
        self.title = "updateTitle".localized
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = currentItem {
            titleTf.text = item.title
            detailTv.text = item.detail
        } else {
            titleTf.becomeFirstResponder()
        }
    }
}

//UI actions
extension ToDoDetailViewController {

    @IBAction func pressedSaveBtn(_ sender: Any) {
        let newItem = ToDoItem(title: titleTf.text, detail: detailTv.text, createDate: Date())
        if let currentItem = currentItem {
            update(oldItem: currentItem, newItem: newItem)
        } else {
            create(item: newItem)
        }
    }

    @IBAction func pressedDeleteBtn(_ sender: Any) {
        guard let item = currentItem else {
            return
        }

        delete(item: item)
    }
}

//Usecase calls
private extension ToDoDetailViewController {

    func update(oldItem: ToDoItem, newItem: ToDoItem) {
        updateUseCase?.execute(requestValue: (oldItem, newItem), completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let updated):
                guard updated else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "warning_update".localized)
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.showAlert(message: "error_update".localized)
                }
            }
        })
    }

    func create(item: ToDoItem) {
        createUseCase?.execute(requestValue: item, completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let created):
                guard created else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "warning_create".localized)
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.showAlert(message: "error_create".localized)
                }
            }
        })
    }

    func delete(item: ToDoItem) {
        deleteUseCase?.execute(requestValue: item, completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.showAlert(message: "error_delete".localized)
                }
            }
        })
    }
}

extension ToDoDetailViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= ToDoDetailViewController.titleCharacterLimit
    }
}

extension ToDoDetailViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text else { return true }
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= ToDoDetailViewController.detailCharacterLimit
    }
}
