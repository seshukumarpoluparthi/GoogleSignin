//
//  ViewController.swift
//  GS1
//
//  Created by apple on 11/5/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var profile_img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        signInBtn.addTarget(self, action: #selector(signinGoogleUser(_:)), for: .touchUpInside)
    }
    @objc func signinGoogleUser(_ sender : UIButton){
        if signInBtn.title(for: .normal) == "Sign Out" {
            GIDSignIn.sharedInstance().signOut()
            lbl_Title.text = ""
            signInBtn.setTitle("Sign In using Google", for: .normal)
        } else {
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().signIn()
        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print(error.localizedDescription)
        } else{
            if let gmailUser = user{
                lbl_Title.text = gmailUser.profile.email
                
                print(gmailUser.profile.email)
                print(gmailUser.profile.name)
                 print(gmailUser.profile.givenName)
                print(gmailUser.profile.familyName)
                let dimension = round(100 * UIScreen.main.scale)
                print(gmailUser.profile.imageURL(withDimension: UInt(dimension)))
                print(gmailUser.userID)
                let img_url = gmailUser.profile.imageURL(withDimension: UInt(dimension))
                print(img_url)
           
//                if let imageurl = URL(\)  {
//                    DispatchQueue.global().async {
//                        let data = try? Data(contentsOf : imageurl)
//                        if let data = data {
//                            let image = UIImage(data: data)
//                            DispatchQueue.main.async {
//                               profile_img.image = image
//                            }
//                        }
//                    }
//                }
                profile_img.load(url: img_url!)
                
                
                signInBtn.setTitle("Sign Out", for: .normal)
            }
        }
    }
    
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

