//
//  ViewController.swift
//  NewsAppAssignment
//
//  Created by M1066900 on 25/08/21.
//

//https://itunes.apple.com/search?term=perfect&limit=1&media=podcast

//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=03867cfa9d994cca9d353d625a007729

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let getArticlesButton = ButtonFrontPage(bgColor: .systemBlue, title: readNewsArticles)
    let getWatchNewsButton = ButtonFrontPage(bgColor: .systemBlue, title: watchVideos)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGetArticleButton()
        configureWatchNewsButton()
    }
    
    
    
//MARK:- UIDesign for getWatchNewsButton button
    func configureWatchNewsButton(){
        view.addSubview(getWatchNewsButton)
        
        NSLayoutConstraint.activate([
            getWatchNewsButton.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            getWatchNewsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            getWatchNewsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            getWatchNewsButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    
//MARK:- UIDesign for getArticlesButton button
    func configureGetArticleButton(){
        view.addSubview(getArticlesButton)
        getArticlesButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getArticlesButton.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            getArticlesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            getArticlesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            getArticlesButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
//MARK:-Button Action Target for getArticlesButton
    @objc private func didTapButton(){
        
    let splitVC = UISplitViewController(style: .doubleColumn)
        splitVC.viewControllers = [
            UINavigationController(rootViewController: MenuController(style: .plain)),
            UINavigationController(rootViewController: WebArticleViewController())
                ]
        splitVC.preferredDisplayMode=UISplitViewController.DisplayMode.oneBesideSecondary
        splitVC.presentsWithGesture = false
        let widthFraction = 2.45
        splitVC.preferredPrimaryColumnWidthFraction = 0.40
        let minimumWidth = min((splitVC.view.bounds.size.width),(splitVC.view.bounds.height))
        splitVC.minimumPrimaryColumnWidth = minimumWidth / CGFloat(widthFraction)
        splitVC.maximumPrimaryColumnWidth = minimumWidth / CGFloat(widthFraction)
        present(splitVC, animated: true)
        
        }
}
