//
//  DetailsShowTVRouter.swift
//  AppMovies
//
//  Created Roberto Antonio Alba Hernández on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailsShowTVRouter: DetailsShowTVWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(showTV:Result) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailsShowTVViewController(nibName: nil, bundle: nil)
        let interactor = DetailsShowTVInteractor()
        let router = DetailsShowTVRouter()
        let presenter = DetailsShowTVPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.showTV = showTV
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
