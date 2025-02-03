//
//  FavoriteView.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

import UIKit

protocol FavoriteViewLogic {
    func configureLoading(_ viewModel: FavoriteModels.Loading.ViewModel)
    func configureFavorites(_ viewModel: FavoriteModels.Favorites.ViewModel)
    func configureEmptyState(_ viewModel: FavoriteModels.EmptyState.ViewModel)
}

protocol FavoriteViewDelegate: AnyObject {
    func showFavoriteDetails(favorite: FavoriteModels.FavoriteItem)
}

final class FavoriteView: UIView {

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            FavoriteImageTableViewCell.self,
            forCellReuseIdentifier: "favoriteImageTableViewCell"
        )
        return tableView
    }()

    private(set) lazy var containerLoading: UIView = {
        let container = UIView()
        container.addSubview(loadingView)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.isHidden = true
        container.backgroundColor = .systemBackground
        return container
    }()

    private(set) lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()

    private lazy var emptyView: EmptyView = {
        let emptyView = EmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isHidden = true
        return emptyView
    }()

    // MARK: - Properties
    private(set) var model: FavoriteModels.FavoriteAPODModel?
    weak var delegate: FavoriteViewDelegate?

    init(delegate: FavoriteViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        addSubview(tableView)
        addSubview(containerLoading)
        addSubview(emptyView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            containerLoading.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerLoading.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerLoading.topAnchor.constraint(equalTo: topAnchor),
            containerLoading.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: containerLoading.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: containerLoading.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension FavoriteView: FavoriteViewLogic {
    func configureLoading(_ viewModel: FavoriteModels.Loading.ViewModel) {
        emptyView.isHidden = true
        DispatchQueue.main.async {
            self.containerLoading.isHidden = !viewModel.isActive

            if viewModel.isActive {
                self.loadingView.startAnimating()
            } else {
                self.loadingView.stopAnimating()
            }
        }
    }

    func configureFavorites(_ viewModel: FavoriteModels.Favorites.ViewModel) {
        self.model = viewModel.model

        DispatchQueue.main.async {
            self.emptyView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }

    func configureEmptyState(_ viewModel: FavoriteModels.EmptyState.ViewModel) {
        DispatchQueue.main.async {
            self.emptyView.isHidden = false
            self.tableView.isHidden = true
            self.emptyView.configure(viewModel)
        }
    }
}

extension FavoriteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "favoriteImageTableViewCell", for: indexPath
        ) as? FavoriteImageTableViewCell else {
            return UITableViewCell()
        }
        guard let favoriteItem = model?.items[indexPath.row] else {
            return UITableViewCell()
        }
        cell.condigure(favoriteItem)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favoriteItem = model?.items[indexPath.row] else { return }
        delegate?.showFavoriteDetails(favorite: favoriteItem)
    }
}
