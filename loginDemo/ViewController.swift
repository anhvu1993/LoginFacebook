//
//  ViewController.swift
//  loginDemo
//
//  Created by Bui Van Tuan on 7/3/19.
//  Copyright © 2019 Nguyen khac vu. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {

    @IBOutlet weak var showLoginFacebook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginLogout = LoginButton(readPermissions: [ .publicProfile ])
        loginLogout.center = CGPoint(x: view.frame.size.width/2, y: 150)
        view.addSubview(loginLogout)
       
    }

    @IBAction func loginWithFacebook(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .cancelled:
                print("User cancel login process")
                break
            case .failed(let error):
                print("login failed with error = \(error.localizedDescription)")
                break
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!\(accessToken)")
               self.getUser()
            }
        }
    }
    func getUser(){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, about, birthday"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: GraphAPIVersion.defaultVersion)) {
            response , result in
            switch result {
            case .success(let response):
                print("longged in user facebook id ==\(response.dictionaryValue!["id"])")
                print("longged in user facebook name ==\(response.dictionaryValue!["name"])")
               
                break
            case .failed(let error):
                print("We havw error fetching loggedin user profile ==\(error.localizedDescription)")
            }
        }
        connection.start()
    }
    
}


