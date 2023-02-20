//
//  ProfilePresenter.swift
//  AppMovies
//
//  Created Roberto Antonio Alba Hernández on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ProfilePresenter: ProfilePresenterProtocol {
    weak private var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    private let router: ProfileWireframeProtocol

    init(interface: ProfileViewProtocol, interactor: ProfileInteractorProtocol?, router: ProfileWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getInfoProfile(completion: @escaping ((Profile?) -> ())) {
        interactor?.getInfoProfile(completion: completion)
    }

}
