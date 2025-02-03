//
//  FavoriteImageTableViewCell.swift
//  APODBox
//
//  Created by Denis Couras on 02/02/25.
//

import UIKit

class FavoriteImageTableViewCell: UITableViewCell {

    private(set) lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 18, weight: .light)
        return lbl
    }()

    private(set) lazy var lblDate: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        lbl.textColor = .lightGray
        return lbl
    }()

    private(set) lazy var btnFavorite: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .systemYellow
        return btn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildHierarchy() {
        addSubview(lblTitle)
        addSubview(lblDate)
        addSubview(btnFavorite)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: btnFavorite.leadingAnchor, constant: -8),
            lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        ])

        NSLayoutConstraint.activate([
            lblDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lblDate.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 4),
            lblDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])

        NSLayoutConstraint.activate([
            btnFavorite.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            btnFavorite.heightAnchor.constraint(equalToConstant: 32),
            btnFavorite.widthAnchor.constraint(equalToConstant: 32),
            btnFavorite.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func condigure(_ favoriteItem: FavoriteModels.FavoriteItem) {
        lblTitle.text = favoriteItem.title
        lblDate.text = favoriteItem.date
    }
}
