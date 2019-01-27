//
//  SafakViewController.swift
//  asd
//
//  Created by Alpaslan on 24.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import Foundation
import UIKit

class SafakViewController: UIViewController {
    
    @IBOutlet weak var askerBasladıView: UIView!
    @IBOutlet weak var sayacView: KDCircularProgress!
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var askerButton: UIButton!
    @IBOutlet weak var writeNewDiaryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        circularProgressView.angle = newAngle()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func askerButtonPressed(_ sender: Any) {
        sayacView.isHidden = false
        //circularProgressView.isHidden = false
        writeNewDiaryButton.isHidden = false
        askerBasladıView.isHidden = true
        runTimer()
        
    }
    
    @IBAction func askerBaslamadıButtonPressed(_ sender: Any) {
        sayacView.isHidden = true
        askerBasladıView.isHidden = false
    }
    
    @IBAction func writeNewDiaryButtonPressed(_ sender: Any) {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        
//        guard let DestinationViewController = mainStoryboard.instantiateViewController(withIdentifier: "DiaryViewNavigationBarViewController") as? DestinationViewController else {
//            print("Couldn't find the view controller")
//            return
//            
//        }
//        
        //DiaryViewNavigationBarViewController.modalTransitionStyle = .partialCurl
        
        //present(DiaryViewNavigationBarViewController,animated: true, completion: nil)
    }
    
    var currentCount = 21.0
    let maxCount = 21.0
    
    var timer = Timer()
    //var isTimerRunning = false
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1*3, target: self, selector: (#selector(SafakViewController.updateTimer)), userInfo: nil, repeats: true)
        //timeInterval => ne kadar zaman bekleyecekse onu tutuyor. Benim kodumda 1 gün bekleyecek yani 24*60*60
    }
    
    @objc func updateTimer() {
        if currentCount <= maxCount, currentCount > 0 {
            currentCount -= 1
            progressLabel.text = String(Int(currentCount))
            let newAngleValue = newAngle()
            circularProgressView.animate(toAngle: newAngleValue, duration: 0.5, completion: nil)
        }
    }
    
    func newAngle() -> Double {
        return 360 * (currentCount / maxCount)
    }
    
}
