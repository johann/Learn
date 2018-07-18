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


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        let oauthswift = OAuth2Swift(consumerKey: "c00d880168abfa5409b69c9267989a60019d5757fcf5095c1bdc16513f48dd49", consumerSecret: "726ed128be992068be3ea6579d5ef49c47eb78dc82366ff20dc1fc89c472bef2", authorizeUrl: "https://learn.co/oauth/authorize", accessTokenUrl: "https://learn.co/oauth/token", responseType: "code")
        
        oauthswift.allowMissingStateCheck = true
        //2
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "learn-auth://learn/callback")!,
            scope: "", state: "",
            success: { credential, response, parameters in
                print(credential.oauthToken)
                
                // Do your request
        },
            failure: { error in
                
                print(error.localizedDescription)
        }
        )
    }



}

