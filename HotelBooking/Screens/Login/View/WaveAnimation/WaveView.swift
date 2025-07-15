//
//  WaveView.swift
//  HotelBooking
//
//  Created by toqsoft on 11/07/25.
//

import UIKit

class WaveView: UIView {

    private var waveOffset: CGFloat = 0
    private var displayLink: CADisplayLink?

    private var amplitude: CGFloat = 40
    private var waveSpeed: CGFloat = 0.03

    private var wave1Height: CGFloat = 60
    private var wave2Height: CGFloat = 80
    private var wave3Height: CGFloat = 100
    private var wave4Height: CGFloat = 120

    private var wave1Length: CGFloat = 250
    private var wave2Length: CGFloat = 320
    private var wave3Length: CGFloat = 400
    private var wave4Length: CGFloat = 180

    private let waveColor1 = UIColor(hex: "#80003b95")
    private let waveColor2 = UIColor(hex: "#60003b95")
    private let waveColor3 = UIColor(hex: "#40003b95")
    private let waveColor4 = UIColor(hex: "#30003b95")

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        startWaves()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        startWaves()
    }

    private func startWaves() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateWaves))
        displayLink?.add(to: .main, forMode: .common)
    }

    @objc private func updateWaves() {
        waveOffset += waveSpeed
        if waveOffset > .pi * 2 {
            waveOffset -= .pi * 2
        }
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        let bottomOffset: CGFloat = 10 
        drawWave(height: wave1Height, length: wave1Length, offsetMultiplier: 1.0, amplitudeMultiplier: 1.0, color: waveColor1, heightOffset: bottomOffset, phase: 0)
        drawWave(height: wave2Height, length: wave2Length, offsetMultiplier: 1.3, amplitudeMultiplier: 0.6, color: waveColor2, heightOffset: bottomOffset, phase: 0.5)
        drawWave(height: wave3Height, length: wave3Length, offsetMultiplier: 0.9, amplitudeMultiplier: 0.8, color: waveColor3, heightOffset: bottomOffset, phase: 1.0)
        drawWave(height: wave4Height, length: wave4Length, offsetMultiplier: 1.7, amplitudeMultiplier: 0.4, color: waveColor4, heightOffset: bottomOffset, phase: 1.5)
    }

    private func drawWave(
        height: CGFloat,
        length: CGFloat,
        offsetMultiplier: CGFloat,
        amplitudeMultiplier: CGFloat,
        color: UIColor,
        heightOffset: CGFloat,
        phase: CGFloat
    ) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.height))

        let adjustedAmplitude = amplitude * amplitudeMultiplier
        let centerY = bounds.height / 2 - heightOffset

        for x in stride(from: CGFloat(0), through: bounds.width + 150, by: 1) {
            let radians = ((x / length) + waveOffset * offsetMultiplier + phase) * .pi * 2
            let y = centerY + adjustedAmplitude * sin(radians)
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: bounds.width + 150, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.close()

        color.setFill()
        path.fill()
    }

    func setWaveProperties(height: CGFloat, length: CGFloat, speed: CGFloat, amplitude: CGFloat) {
        self.amplitude = amplitude
        self.waveSpeed = speed

        wave1Height = height * 1.2
        wave2Height = height * 3.6
        wave3Height = height * 2.0
        wave4Height = height * 2.4

        wave1Length = length * 5.3
        wave2Length = length * 4.5
        wave3Length = length * 3.2
        wave4Length = length * 2.4

        setNeedsDisplay()
    }

    deinit {
        displayLink?.invalidate()
    }
}

