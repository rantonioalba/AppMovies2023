//
//  ProfileProtocols.swift
//  AppMovies
//
//  Created Roberto Antonio Alba Hernández on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ProfileWireframeProtocol: AnyObject {

}
//MARK: Presenter -
protocol ProfilePresenterProtocol: AnyObject {
    func getInfoProfile(completion: @escaping ((Profile?) -> ()))
}

//MARK: Interactor -
protocol ProfileInteractorProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol?  { get set }
    func getInfoProfile(completion: @escaping ((Profile?) -> ()))
}

//MARK: View -
protocol ProfileViewProtocol: AnyObject {

  var presenter: ProfilePresenterProtocol?  { get set }
}