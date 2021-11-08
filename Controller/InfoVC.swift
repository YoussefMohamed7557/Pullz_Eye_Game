//
//  InfoVC.swift
//  PullzEyeGame
//
//  Created by Youssef on 09/09/2021.
//

import UIKit
import WebKit
class InfoVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var infoWedView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHTMLPage()
    }
    //MARK: - IBActions
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helper Methods
    func loadHTMLPage() {
        guard let HTMLPagePath = Bundle.main.path(forResource: "BullsEye", ofType: "html") else {return}
        let HTMLPageURL = URL(fileURLWithPath: HTMLPagePath)
        let HTMLPageURLRequest = URLRequest(url: HTMLPageURL)
        infoWedView.load(HTMLPageURLRequest)
    }
    
}
