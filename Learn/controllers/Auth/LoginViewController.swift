//
//  ViewController.swift
//  Learn
//
//  Created by Johann Kerr on 7/15/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import UIKit
import OAuthSwift

//learn-auth://learn/callback


class LoginViewController: UIViewController {
    
    let store = UserDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let oauthswift = OAuth2Swift(consumerKey: Constants.consumerKey, consumerSecret: Constants.consumerSecret, authorizeUrl: "https://learn.co/oauth/authorize", accessTokenUrl: "https://learn.co/oauth/token", responseType: "code")

        oauthswift.allowMissingStateCheck = true
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)

        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "learn-auth://learn/callback")!,
            scope: "", state: "",
            success: { credential, response, parameters in
                print(credential.oauthToken)
                UserDefaults.standard.set(credential.oauthToken, forKey: "token")
                Switcher.updateVC()
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
}

