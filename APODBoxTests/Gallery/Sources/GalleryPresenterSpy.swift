//
//  GalleryPresenterSpy.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
@testable import APODBox

class GalleryPresenterSpy: GalleryPresentationLogic {
    var presentLoadingCalled = false
    var presentAPODCalled = false
    var presentFavoriteCalled = false
    var presentTagCalled = false
    var presentErrorCalled = false
    var presentMediaDayCalled = false

    func presentLoading(_ response: GalleryModels.Loading.Response) {
        presentLoadingCalled = true
    }

    func presentAPOD(_ response: GalleryModels.APOD.Response) {
        presentAPODCalled = true
    }

    func presentFavorite(_ response: GalleryModels.Favorite.Response) {
        presentFavoriteCalled = true
    }

    func presentTag(_ response: GalleryModels.TagType) {
        presentTagCalled = true
    }

    func presentError(_ response: APODBox.GalleryModels.Error.Response) {
        presentErrorCalled = true
    }

    func presentMediaDay(_ response: APODBox.GalleryModels.Media.Response) {
        presentMediaDayCalled = true
    }
}
