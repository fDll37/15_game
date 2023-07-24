//
//  InfoViewController.swift
//  God picture
//
//  Created by Данил Менделев on 19.07.2023.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {
    
    var webView: WKWebView!
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.backgroundColor = UIColor(named: "orange")
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://www.privacypolicyonline.com/live.php?token=c38XqImvsMfG4CBT8BQNJv6zsEe3DGtZ")!
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
        
    }
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        view = webView
        layout()
    }
    
    @objc private func tapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func layout() {
        
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

extension InfoViewController: WKUIDelegate {

}
