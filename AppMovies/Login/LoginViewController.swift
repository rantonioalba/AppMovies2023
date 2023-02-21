//
//  LoginViewController.swift
//  AppMovies
//
//  Created Roberto Antonio Alba Hernández on 17/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol, SpinnerDelegate {
    var spinnerView: UIView?
    
    
    

	var presenter: LoginPresenterProtocol?

    var scrollView : UIScrollView!
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textUserName : UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.placeholder = "Username"
        view.text = "dr_robert"
        view.layer.cornerRadius = 5.0
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        view.returnKeyType = .next
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textPassword : UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.placeholder = "Password"
        view.text = "newDEVXV_2015"
        view.layer.cornerRadius = 5.0
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        view.leftViewMode = .always
        view.autocorrectionType = .no
        view.textContentType = .none
        view.autocapitalizationType = .none
        view.returnKeyType = .done
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonLogin : UIButton = {
        let view = UIButton()
        view.setTitle("Log In", for: .normal)
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let labelError : UILabel = {
        let view = UILabel()
        view.textColor = .red
        view.numberOfLines = 0
        view.isHidden = true
        view.adjustsFontSizeToFitWidth = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
	override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "primaryColor")
        self.view.backgroundColor = UIColor(red: 9/255.0, green: 22/255.0, blue: 26/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: 21/255.0, green: 39/255.0, blue: 46/255.0, alpha: 1.0)
        setupView()
        
        //Keyboard dismiss
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if scrollView != nil {
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupView()  {
        scrollView = UIScrollView()
        
        
        let containerImageView = UIView()
        
        containerImageView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: containerImageView.centerYAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 130.0).isActive = true
        
        scrollView.addSubview(containerImageView)
        containerImageView.translatesAutoresizingMaskIntoConstraints = false
        containerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80).isActive = true
//        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        containerImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        containerImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        containerImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0).isActive = true
        containerImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
//        stackView.addArrangedSubview(containerImageView)
//        containerImageView.translatesAutoresizingMaskIntoConstraints = false
//        containerImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        let containerTextUserName = UIView()
        containerTextUserName.addSubview(textUserName)
        textUserName.delegate  = self
        textUserName.topAnchor.constraint(equalTo: containerTextUserName.topAnchor).isActive = true
        textUserName.leadingAnchor.constraint(equalTo: containerTextUserName.leadingAnchor, constant: 30.0).isActive = true
        textUserName.trailingAnchor.constraint(equalTo: containerTextUserName.trailingAnchor, constant: -30.0).isActive = true
        textUserName.bottomAnchor.constraint(equalTo: containerTextUserName.bottomAnchor, constant: 0).isActive = true
        stackView.addArrangedSubview(containerTextUserName)
        containerTextUserName.translatesAutoresizingMaskIntoConstraints = false
        containerTextUserName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let containerTextPassword = UIView()
        containerTextPassword.addSubview(textPassword)
        textPassword.delegate = self
        textPassword.topAnchor.constraint(equalTo: containerTextPassword.topAnchor).isActive = true
        textPassword.leadingAnchor.constraint(equalTo: containerTextPassword.leadingAnchor, constant: 30.0).isActive = true
        textPassword.trailingAnchor.constraint(equalTo: containerTextPassword.trailingAnchor, constant: -30.0).isActive = true
        textPassword.bottomAnchor.constraint(equalTo: containerTextPassword.bottomAnchor, constant: 0).isActive = true
        stackView.addArrangedSubview(containerTextPassword)
        containerTextPassword.translatesAutoresizingMaskIntoConstraints = false
        containerTextPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let containerButtonLogin = UIView()
        containerButtonLogin.addSubview(buttonLogin)
        
        buttonLogin.addTarget(self, action: #selector(tapButtonLogin), for:.touchUpInside)
        
        buttonLogin.topAnchor.constraint(equalTo: containerButtonLogin.topAnchor).isActive = true
        buttonLogin.leadingAnchor.constraint(equalTo: containerButtonLogin.leadingAnchor, constant: 30.0).isActive = true
        buttonLogin.trailingAnchor.constraint(equalTo: containerButtonLogin.trailingAnchor, constant: -30.0).isActive = true
        buttonLogin.bottomAnchor.constraint(equalTo: containerButtonLogin.bottomAnchor, constant: 0).isActive = true
        stackView.addArrangedSubview(containerButtonLogin)
        containerButtonLogin.translatesAutoresizingMaskIntoConstraints = false
        containerButtonLogin.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.addArrangedSubview(labelError)
        labelError.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: containerImageView.bottomAnchor,constant: 0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0, constant: -50).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func tapButtonLogin(_ sender: UIButton)  {
        displaySpinner()
        self.labelError.isHidden = true
        self.presenter?.validateLogin(withUserName: self.textUserName.text ?? "", andPassword: self.textPassword.text ?? "", completion: { [weak self] response, error in
            
            guard self != nil else {
                return
            }
            
            self?.removeSpinner()
            if response {
                self?.presenter?.goToHome()
            } else {
                self?.labelError.text = error
                self?.labelError.isHidden = false
            }
        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.view.frame = UIScreen.main.bounds
    }
    
    // MARK: Notifications
    @objc func handleKeyboardNotification(notification:NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            if isKeyboardShowing {
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardFrame.size.height) + 50, right: 0)

                scrollView.contentInset = contentInsets
            } else {
                let contentInset:UIEdgeInsets = UIEdgeInsets.zero
                scrollView.contentInset = contentInset
            }
        }
    }
    
    
    //MARK: - SpinnerDelegate
    func displaySpinner() {
        self.spinnerView = self.view.viewWithTag(2000)
        
        if self.spinnerView == nil {
            if let window = UIApplication.shared.keyWindow {
                spinnerView = UIView.init(frame: window.frame)
                spinnerView!.tag = 2000
                spinnerView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
                
                let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
                
                
                indicatorView.startAnimating()
                
                indicatorView.center = (spinnerView?.center)!
                
                let label = UILabel()
                label.text = "Cargando"
                label.textColor = .white
                
                DispatchQueue.main.async {
                    self.spinnerView?.addSubview(indicatorView)
                    self.spinnerView?.addSubview(label)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.centerXAnchor.constraint(equalTo: self.spinnerView!.centerXAnchor).isActive = true
                    label.centerYAnchor.constraint(equalTo: self.spinnerView!.centerYAnchor, constant: 50).isActive = true
                    
                    self.view.addSubview(self.spinnerView!)
                }
            }
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinnerView?.removeFromSuperview()
        }
    }
}

extension LoginViewController : UITextFieldDelegate {
    
}
