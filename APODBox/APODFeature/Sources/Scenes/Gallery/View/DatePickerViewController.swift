//
//  DatePickerViewController.swift
//  APODBox
//
//  Created by Denis Couras on 02/02/25.
//
import UIKit

class DatePickerViewController: UIViewController {
    weak var delegate: DataSelectionDelegate?
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()

    private lazy var selectButton: UIButton = {
        let selectButton = UIButton(type: .system)
        selectButton.setTitle("Selecionar", for: .normal)
        selectButton.addTarget(self, action: #selector(confirmSelectDate), for: .touchUpInside)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        return selectButton
    }()

    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancelar", for: .normal)
        cancelButton.addTarget(self, action: #selector(closeCalendar), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        return cancelButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildHierarchy()
        setupConstraints()
    }

    private func buildHierarchy() {
        view.addSubview(datePicker)
        view.addSubview(selectButton)
        view.addSubview(cancelButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            selectButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            cancelButton.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 10),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func confirmSelectDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dataSelecionada = dateFormatter.string(from: datePicker.date)

        delegate?.didSelectDate(dataSelecionada)
        dismiss(animated: true)
    }

    @objc func closeCalendar() {
        dismiss(animated: true)
    }
}
