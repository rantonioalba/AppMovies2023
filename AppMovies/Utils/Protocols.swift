//
//  Protocols.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 18/02/23.
//

import Foundation
import UIKit

protocol SpinnerDelegate {
    var spinnerView : UIView? { get set }
    func displaySpinner()
    func removeSpinner()
}
