//
//  LaunchScreenVC.swift
//  HotelBooking
//
//  Created by toqsoft on 11/07/25.
//
import UIKit

class LaunchScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        animationWave()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.movetoLoginScreen()
        } )
    }
    
    func animationWave() {
        let waveHeight = view.bounds.height * 0.6
           let waveY = view.bounds.height - waveHeight
           let waveView = WaveView(frame: CGRect(x: 0, y: waveY, width: view.bounds.width, height: waveHeight))
           
           waveView.setWaveProperties(height: 10, length: 100, speed: 0.003, amplitude: 20)
           view.addSubview(waveView)
    }
    
    func movetoLoginScreen(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
}
 
