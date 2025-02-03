//
//  GalleryView+Extensions.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import UIKit

extension GalleryView {
    func setupConstraints() {
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        btnFavorite.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            lblTitle.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            lblTitle.trailingAnchor.constraint(equalTo: stack.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            lblDate.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            lblDate.trailingAnchor.constraint(equalTo: stack.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            lblCopyright.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            lblCopyright.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            btnFavorite.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            btnFavorite.heightAnchor.constraint(equalToConstant: 30),
            btnFavorite.widthAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            imgDay.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            imgDay.trailingAnchor.constraint(equalTo: stack.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            viewPlayer.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            viewPlayer.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            viewPlayer.heightAnchor.constraint(equalToConstant: 250)
        ])

        NSLayoutConstraint.activate([
            lblExplanation.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            lblExplanation.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            lblExplanation.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            lblExplanation.heightAnchor.constraint(equalToConstant: 350)
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
            viewError.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewError.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewError.topAnchor.constraint(equalTo: topAnchor),
            viewError.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            tagActionResultView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tagActionResultView.heightAnchor.constraint(equalToConstant: 60),
            tagActionResultView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            tagActionResultView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
        ])
    }
}
