//
//  GalleryRouter.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import UIKit

protocol GalleryRoutingLogic {
    func routeToDatePicker(delegate: DataSelectionDelegate)
}

protocol DataSelectionDelegate: AnyObject {
    func didSelectDate(_ date: String)
}

class GalleryRouter: GalleryRoutingLogic {
    typealias ViewController = UIViewController
    & GalleryDisplayLogic
    weak var viewController: ViewController?
    weak var delegate: DataSelectionDelegate?
    weak var tabBarController: UITabBarController?

    func routeToDatePicker(delegate: DataSelectionDelegate) {
        let datePickerVC = DatePickerViewController()
        datePickerVC.delegate = delegate
        viewController?.present(datePickerVC, animated: true)
    }
}
