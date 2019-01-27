//
//  ViewController.swift
//  asd
//
//  Created by Alpaslan on 23.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segueTapped(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let DestinationViewController = mainStoryboard.instantiateViewController(withIdentifier: "DestinationViewController") as? DestinationViewController else {
            print("Couldn't find the view controller")
            return
            
        }
        
        DestinationViewController.modalTransitionStyle = .partialCurl
        
        present(DestinationViewController,animated: true, completion: nil)
        
        //navigationController?.pushViewController(DestinationViewController, animated: true)
    }
    
}

