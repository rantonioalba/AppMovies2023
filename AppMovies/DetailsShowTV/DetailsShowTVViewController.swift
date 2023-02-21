//
//  DetailsShowTVViewController.swift
//  AppMovies
//
//  Created Roberto Antonio Alba Hernández on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailsShowTVViewController: UIViewController, DetailsShowTVViewProtocol {
    
	var presenter: DetailsShowTVPresenterProtocol?
    var scrollView:UIScrollView!
    var collectionView : UICollectionView!
    var showTV: Result!
    var watchTVProviders : [String : AnyObject] = [String : AnyObject]()
    var providersImages = [String?]()
    
    let imageView: CustomImageView = {
        let view = CustomImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 22)
        view.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        view.textAlignment = .center
//        [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0),NSAttributedString.Key.kern : -0.43]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelCountry: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        view.textAlignment = .center
//        [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0),NSAttributedString.Key.kern : -0.43]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelGenre: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = UIColor.lightGray
        view.textAlignment = .center
//        [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0),NSAttributedString.Key.kern : -0.43]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelDate: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 93/255.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let labelRating: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 93/255.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageViewRating: CustomImageView = {
        let view = CustomImageView()
        view.image = UIImage(named: "ic_star")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor(red: 29/255.0, green: 180/255.0, blue: 93/255.0, alpha: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelSummary: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor(red: 219/255.0, green: 221/255.0, blue: 253/255.0, alpha: 1.0)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Description of Show"
        self.navigationController?.navigationBar.tintColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        
        self.view.backgroundColor = UIColor(red: 21/255.0, green: 39/255.0, blue: 46/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 46/255.0, green: 55/255.0, blue: 58/255.0, alpha: 1.0)
                
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0),NSAttributedString.Key.kern : -0.43]
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        statusBar.backgroundColor = UIColor(red: 46/255.0, green: 55/255.0, blue: 58/255.0, alpha: 1.0)
        window?.addSubview(statusBar)
                
        setupView()
        
        presenter?.getProviders(idShowTV: showTV.id)
    }
    
    func setupView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        
        scrollView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.loadImageUsingUrlString(urlString: showTV.backdropPath ?? "")
        
        scrollView.addSubview(labelTitle)
        labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        labelTitle.text = showTV.name ?? ""

        scrollView.addSubview(labelCountry)
        labelCountry.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 0).isActive = true
        labelCountry.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5).isActive = true
        labelCountry.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5).isActive = true
        labelCountry.text = presenter?.getCountries(originCountry: showTV.originCountry ?? [] )

        scrollView.addSubview(labelGenre)
        labelGenre.topAnchor.constraint(equalTo: labelCountry.bottomAnchor, constant: 7).isActive = true
        labelGenre.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5).isActive = true
        labelGenre.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5).isActive = true
        labelGenre.text = presenter?.getGenres(genresIds: showTV.genreIDS ?? [])

        scrollView.addSubview(labelDate)
        labelDate.topAnchor.constraint(equalTo: labelGenre.bottomAnchor, constant: 10).isActive = true
        labelDate.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        labelDate.heightAnchor.constraint(equalToConstant: 12).isActive = true

        scrollView.addSubview(labelRating)
        labelRating.topAnchor.constraint(equalTo: labelGenre.bottomAnchor, constant: 10).isActive = true
        labelRating.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        labelRating.widthAnchor.constraint(equalToConstant: 20).isActive = true
        labelRating.heightAnchor.constraint(equalToConstant: 12).isActive = true

        scrollView.addSubview(imageViewRating)
        imageViewRating.topAnchor.constraint(equalTo: labelGenre.bottomAnchor, constant: 10).isActive = true
        imageViewRating.trailingAnchor.constraint(equalTo: labelRating.leadingAnchor, constant: -7).isActive = true
        imageViewRating.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageViewRating.heightAnchor.constraint(equalToConstant: 10).isActive = true


        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: showTV.firstAirDate ?? "")

        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        labelDate.text = dateFormatter.string(from: date ?? Date())
        labelRating.text = "\(showTV.voteAverage ?? 0)"
        
        
        let viewLabelSummary = UIView()
        viewLabelSummary.addSubview(labelSummary)
        labelSummary.topAnchor.constraint(equalTo: viewLabelSummary.topAnchor, constant: 0).isActive = true
        labelSummary.leadingAnchor.constraint(equalTo: viewLabelSummary.leadingAnchor, constant: 15).isActive = true
        labelSummary.trailingAnchor.constraint(equalTo: viewLabelSummary.trailingAnchor, constant: -15).isActive = true
        labelSummary.bottomAnchor.constraint(equalTo: viewLabelSummary.bottomAnchor, constant: 0).isActive = true
        
        stackView.addArrangedSubview(viewLabelSummary)
        
        labelSummary.text = showTV.overview
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        collectionView.register(ImageProviderCell.self, forCellWithReuseIdentifier: "\(ImageProviderCell.self)")

        collectionView.dataSource = self
        collectionView.delegate = self
        
        stackView.addArrangedSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: labelRating.bottomAnchor,constant: 10).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0, constant: 0).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
    }
    
    func didWatchTVProvidersImages(providersImages: [String?]) {
        self.providersImages = providersImages
        self.collectionView.reloadData()
    }
}

extension DetailsShowTVViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return providersImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageProviderCell.self)", for: indexPath) as? ImageProviderCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(pathImage: providersImages[indexPath.row] ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 20) / 3, height: collectionView.frame.height)
    }
    
}
