//
//  GalleryView.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import UIKit

protocol GalleryViewLogic {
    func configure()
    func configureError(_ viewModel: GalleryModels.Error.ViewModel)
    func configureLoading(_ viewModel: GalleryModels.Loading.ViewModel)
    func configureImageDay(_ viewModel: GalleryModels.MediaDay.ViewModel)
    func configureVideoDay(_ viewModel: GalleryModels.MediaDay.ViewModel)
    func configureAPOD(_ viewModel: GalleryModels.APOD.ViewModel)
    func configureTag(_ viewModel: GalleryModels.Tag.ViewModel)
    func configureFavorite(_ viewModel: GalleryModels.Favorite.ViewModel)
}

protocol GalleryViewDelegate: AnyObject {
    func saveFavorite()
}

final class GalleryView: UIView {
    private(set) lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            horizontalStack,
            lblTitle,
            lblDate,
            imgDay,
            viewPlayer,
            lblCopyright,
            lblExplanation
        ])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        return stack
    }()

    private(set) lazy var containerLoading: UIView = {
        let container = UIView()
        container.addSubview(loadingView)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.isHidden = true
        container.backgroundColor = .white
        return container
    }()

    private(set) lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()

    private(set) lazy var spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var btnFavorite: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(saveFavorite), for: .touchUpInside)
        return btn
    }()

    private(set) lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [spacerView, btnFavorite])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()

    private(set) lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byTruncatingTail
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        lbl.numberOfLines = 1
        return lbl
    }()

    private(set) lazy var lblDate: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        lbl.textColor = .lightGray
        return lbl
    }()

    private(set) lazy var lblExplanation: UITextView = {
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        lbl.isEditable = false
        return lbl
    }()

    private(set) lazy var imgDay: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isHidden = true
        return img
    }()

    private(set) lazy var lblCopyright: UILabel = {
        let copyright = UILabel()
        copyright.numberOfLines = 0
        copyright.lineBreakMode = .byWordWrapping
        copyright.translatesAutoresizingMaskIntoConstraints = false
        copyright.font = .systemFont(ofSize: 12, weight: .light)
        copyright.textColor = .lightGray
        return copyright
    }()

    private(set) lazy var viewPlayer: VideoPlayerView = {
        let viewPlayer = VideoPlayerView()
        viewPlayer.translatesAutoresizingMaskIntoConstraints = false
        viewPlayer.isHidden = true
        return viewPlayer
    }()

    private(set) lazy var viewError: ViewError = {
        let error = ViewError()
        error.translatesAutoresizingMaskIntoConstraints = false
        error.isHidden = true
        return error
    }()

    private(set) lazy var tagActionResultView: TagActionResultView = {
        let tagActionResultView = TagActionResultView()
        tagActionResultView.translatesAutoresizingMaskIntoConstraints = false
        tagActionResultView.isHidden = true
        tagActionResultView.alpha = 0
        return tagActionResultView
    }()

    weak var delegate: GalleryViewDelegate?

    init(delegate: GalleryViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     @objc private func saveFavorite() {
         delegate?.saveFavorite()
    }

    private func buildHierarchy() {
        addSubview(stack)
        addSubview(containerLoading)
        addSubview(viewError)
        addSubview(tagActionResultView)
    }
}

extension GalleryView: GalleryViewLogic {
    func configure() {
        DispatchQueue.main.async {
            self.viewPlayer.isHidden = true
            self.imgDay.isHidden = true
            self.viewError.isHidden = true
        }
    }

    func configureImageDay(_ viewModel: GalleryModels.MediaDay.ViewModel) {
        DispatchQueue.main.async {
            self.imgDay.image = nil
            self.imgDay.loadImage(from: viewModel.url, contentMode: .scaleAspectFit)
            self.imgDay.isHidden = false
        }
    }

    func configureVideoDay(_ viewModel: GalleryModels.MediaDay.ViewModel) {
        DispatchQueue.main.async {
            self.viewPlayer.isHidden = false
            self.viewPlayer.configure(url: viewModel.url)
        }
    }

    func configureLoading(_ viewModel: GalleryModels.Loading.ViewModel) {
        DispatchQueue.main.async {
            self.containerLoading.isHidden = !viewModel.isActive

            if viewModel.isActive {
                self.loadingView.startAnimating()
            } else {
                self.loadingView.stopAnimating()
            }
        }
    }

    func configureAPOD(_ viewModel: GalleryModels.APOD.ViewModel) {
        DispatchQueue.main.async {
            self.lblTitle.text = viewModel.title
            self.lblExplanation.text = viewModel.explanation
            self.lblCopyright.text = viewModel.copyright
            self.lblDate.text = viewModel.date
        }
    }

    func configureError(_ viewModel: GalleryModels.Error.ViewModel) {
        DispatchQueue.main.async {
            self.viewError.isHidden = false
            self.viewError.configure(message: "Erro ao tentar carregar o conteúdo. Por favor, tente selecionar outra data")
        }
    }

    func configureTag(_ viewModel: GalleryModels.Tag.ViewModel) {
        tagActionResultView.configure(viewModel)

        UIView.animate(
            withDuration: 0.25,
            delay: .zero,
            animations: { [weak self] in
                self?.tagActionResultView.alpha = 1
                self?.tagActionResultView.isHidden = false
            }) { [weak self] _ in
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] timer in
                    timer.invalidate()
                    UIView.animate(
                        withDuration: 0.25,
                        animations: { [weak self] in
                            self?.tagActionResultView.alpha = 0
                        })
                }
            }
    }

    func configureFavorite(_ viewModel: GalleryModels.Favorite.ViewModel) {
        DispatchQueue.main.async {
            self.btnFavorite.tintColor = viewModel.isFavorite ? .systemYellow : .systemBlue
        }
    }
}
