//
//  ViewError.swift
//  APODBox
//
//  Created by Denis Couras on 02/02/25.
//
import UIKit

final class ViewError: UIView {
    private lazy var imgError: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
        img.contentMode = .scaleAspectFit
        img.tintColor = .systemRed
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private(set) lazy var lblMessage: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byTruncatingTail
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
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

    func configure(message: String) {
        lblMessage.text = message
    }

    private func buildHierarchy() {
        addSubview(imgError)
        addSubview(lblMessage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imgError.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgError.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            imgError.heightAnchor.constraint(equalToConstant: 60),
            imgError.widthAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            lblMessage.centerXAnchor.constraint(equalTo: centerXAnchor),
            lblMessage.centerYAnchor.constraint(equalTo: centerYAnchor),
            lblMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lblMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
