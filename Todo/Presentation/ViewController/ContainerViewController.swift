//
//  ContainerViewController.swift
//  Todo
//
//  Created by Erkan Ugurlu on 29.03.2021.
//

import UIKit

class ContainerViewController: UIViewController {

    /*
     There was a bug on ibsegueaction in case of relationship segues (rootviewcontroller of uinavigationVC).
     Workaround: I created a container view controller and put ibsegueaction in it.
     */
    @IBSegueAction
    func createListViewController(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ToDoListViewController? {
        RootFactory.instance.makeListVC(coder: coder)
    }
}
