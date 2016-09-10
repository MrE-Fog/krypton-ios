//
//  ViewController.swift
//  krSSH
//
//  Created by Alex Grinman on 8/26/16.
//  Copyright © 2016 KryptCo Inc. All rights reserved.
//

import UIKit


class MainController: UITabBarController, UITabBarControllerDelegate {

    var blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setKrLogo()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.app
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.tabBar.tintColor = UIColor.app
        self.delegate = self
        
        // add a blur view
        view.addSubview(blurView)
        
        //let res = KeyManager.destroyKeyPair()
        //log("destroy result: \(res)")
        
        /*API().send(to: "https://sqs.us-east-1.amazonaws.com/911777333295/q76vMVJ4altKsevcFyIKGpVmYSYMhLgeFUofMImHO5j", message: "hi kevdog") { (result) in
            switch result {
            case .failure(let e):
                log("send error: \(e)", .error)
            case .sent:
                log("send success!")
            default:
                log("unknown")
            }
        }

        do {
            let peer = Peer(email: "blah", fingerprint: "sdfsdf", publicKey: "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEkzVpXcGl9E9vaX5T42LwcqkQo7xnlofns8EwG_QHr6S9iivyO00G56oCny5GiD59_nPIdiPWMEmXq4vTpRxvJw==")
            let key = try Data.random(size: 32).toBase64()
            log(key)
            let sealed = try peer.seal(key: key)
            log(sealed)
            let unsealedPeer = try Peer(key: key, sealed: sealed)
            log("\(unsealedPeer)")
            
        } catch (let e) {
            log("\(e)")
        }
         */

    }
    
    override func viewWillAppear(_ animated: Bool) {
        blurView.frame = view.frame
        self.blurView.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // temp delete
        
        
        guard KeyManager.hasKey() else {
            
            if let createNav = Resources.Storyboard.Main.instantiateViewController(withIdentifier: "CreateNavigation") as? UINavigationController
            {
                self.present(createNav, animated: true, completion: nil)
            }
            
            return
        }
        
        do {
            let kp = try KeyManager.sharedInstance().keyPair
            let pk = try kp.publicKey.exportSecp()
            
            log("started with: \(pk)")
            
            UIView.animate(withDuration: 0.2, animations: { 
                self.blurView.isHidden = true
            })
            
        } catch (let e) {
            log("\(e)", LogType.error)
            showWarning(title: "Fatal Error", body: "\(e)")
            return
        }
        
        //(self.viewControllers?.first as? MeController)?.updateCurrentUser()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
