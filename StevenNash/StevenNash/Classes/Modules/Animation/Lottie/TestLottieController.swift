//
//  TestLottieController.swift
//  StevenNash
//
//  Created by Daniel on 2020/7/10.
//  Copyright © 2020 gongsheng. All rights reserved.
//

import UIKit

import Lottie

class TestLottieController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
    }
    
    
    private func setupView() {
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 5)
        var count = 0
        for _ in 0..<40 {
            queue.async(group: group) {
                semaphore.wait()
                DispatchQueue.main.async {
                    let animationView = AnimationView(name: "girlbutterfly")
                    animationView.loopMode = .playOnce
                    let x = Double(arc4random() % 300)
                    let y = Double(arc4random() % 300) + 80
                    
                    animationView.frame = CGRect(x: x, y: y, width: 80, height: 80)
                    self.view.addSubview(animationView)
                    animationView.play { (finished) in
                        animationView.removeFromSuperview();
                        print("finished--\(count)")
                        count = count + 1
                        semaphore.signal()
                    }
                }
            }
        }
        group.notify(queue: queue) {
            print("all done")
        }
    }
}
