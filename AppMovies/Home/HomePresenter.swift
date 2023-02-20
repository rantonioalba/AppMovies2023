//
//  HomePresenter.swift
//  AppMovies
//
//  Created Roberto Antonio Alba Hernández on 18/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomePresenter: HomePresenterProtocol {
        
    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    private let router: HomeWireframeProtocol

    init(interface: HomeViewProtocol, interactor: HomeInteractorProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getPopularShows(completion: @escaping ((ShowsTV?) -> ())) {
        interactor?.getPopularShows(completion: completion)
    }
    
    func getShowsTV(completion: @escaping (([ShowsTV?]) -> ())) {
        interactor?.getShowsTV(completion: completion)
    }
    
    func goToShowTV(showTV: Result) {
        router.goToShowTV(showTV: showTV)
    }
    
    func logOut(completion: @escaping ((Bool) -> ())) {
        interactor?.logOut(completion: completion)
    }
    
    func showProfile() {
        router.showProfile()
    }
    
    func closeSession() {
        router.closeSession()
    }
}
