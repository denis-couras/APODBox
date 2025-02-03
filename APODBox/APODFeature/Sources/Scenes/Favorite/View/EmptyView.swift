//
//  EmptyView.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//

import UIKit

final class EmptyView: UIView {
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lblMessage)
        view.layer.cornerRadius = 20
        return view
    }()

    private(set) lazy var lblMessage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.textColor = .systemGray
        return lbl
    }()

    init() {
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ viewModel: FavoriteModels.EmptyState.ViewModel) {
        lblMessage.text = viewModel.message
    }

    private func buildHierarchy() {
        addSubview(container)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            lblMessage.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            lblMessage.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}
