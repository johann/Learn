//
//  LearnColor.swift
//  Learn
//
//  Created by Luke Ghenco on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import UIKit

// MARK LearnColor
enum LearnColor {
    case black
    case white
    case grey
    case greyFaint
    case greyFaintest
    case greyLight
    case greyLighter
    case greyLightest
    case greyDark
    case greyDarker
    case greyDarkest
    case yellow
    case yellowDark
    case orange
    case red
    case redLighter
    case redDark
    case redDarker
    case blue
    case blueLight
    case blueLighter
    case blueDark
    case blueDarker
    case navyDark
    case navyDarker
    case navyDarkest
    case purple
    case purpleLight
    case purpleLighter
    case purpleDark
    case green
    case greenLight
    case greenLighter
    case greenDark
    case aquaGreen
    case aquaGreenLight
    case aquaGreenDark
    case gold
    case goldLight
    case goldLighter
    case goldDark
    case custom(hexCode: String, alpha: Double)
    
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}

// Mark LearnColor CaseIteratable Extension
extension LearnColor: CaseIterable {
    typealias AllCases = [LearnColor]
    
    static var allCases: [LearnColor] {
        // TODO Add Additional Cases for colors needed for randomization
        return [.black, .white, .grey, .yellow, .orange, .red, .blue, .navyDark, .purple, .green, .aquaGreen, .gold]
    }
}

// MARK LearnColor Value Setting
extension LearnColor {
    var value: UIColor {
        var color = UIColor.clear
        
        switch self {
        case .black:
            color = UIColor("#000")
        case .white:
            color = UIColor("#fff")
        case .purple:
            color = UIColor("#7a7db7")
        case .purpleLight:
            color = UIColor("#9b9dc9")
        case .purpleLighter:
            color = UIColor("#bcbedb")
        case .purpleDark:
            color = UIColor("#595da5")
        case .green:
            color = UIColor("#75b74f")
        case .greenLight:
            color = UIColor("#91c673")
        case .greenLighter:
            color = UIColor("#e1f0d9")
        case .greenDark:
            color = UIColor("#67a443")
        case .aquaGreen:
            color = UIColor("#00c8ad")
        case .aquaGreenLight:
            color = UIColor("#e8f9f6")
        case .aquaGreenDark:
            color = UIColor("#00a993")
        case .gold:
            color = UIColor("#f9C304")
        case .goldLight:
            color = UIColor("#fcd034")
        case .goldLighter:
            color = UIColor("#fddb66")
        case .goldDark:
            color = UIColor("#c79c03")
        case .grey:
            color = UIColor("#7d7d7d")
        case .greyLight:
            color = UIColor("#a9a9a9")
        case .greyLighter:
            color = UIColor("#c4c4c4")
        case .greyLightest:
            color = UIColor("#e0e0e0")
        case .greyDark:
            color = UIColor("#5c5c5c")
        case .greyDarker:
            color = UIColor("#3a3a3a")
        case .greyDarkest:
            color = UIColor("#111")
        case .greyFaint:
            color = UIColor("#efefef")
        case .greyFaintest:
            color = UIColor("#f8f8f8")
        case .yellow:
            color = UIColor("#f9c51a")
        case .yellowDark:
            color = UIColor("#f3bc06")
        case .orange:
            color = UIColor("#f77304")
        case .red:
            color = UIColor("#ff5b5b")
        case .redLighter:
            color = UIColor("#ffc1c1")
        case .redDark:
            color = UIColor("#ff2828")
        case .redDarker:
            color = UIColor("#f40000")
        case .blue:
            color = UIColor("#00bce1")
        case .blueLight:
            color = UIColor("#b0f3ff")
        case .blueLighter:
            color = UIColor("#e8f8fb")
        case .blueDark:
            color = UIColor("#00a7c8")
        case .blueDarker:
            color = UIColor("#0091ae")
        case .navyDark:
            color = UIColor("#3c3f4e")
        case .navyDarker:
            color = UIColor("#31343f")
        case .navyDarkest:
            color = UIColor("#262831")
        case .custom(let hexCode, let alpha):
            color = UIColor(hexCode).withAlphaComponent(CGFloat(alpha))
        }
        
        return color
    }
}

// UIColor Extension For UIColor(hexCode: String)
extension UIColor {
    convenience init(_ hexCode: String) {
        let hexString = hexCode.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        let mask = 0x0000FF
        var color: UInt32 = 0
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        scanner.scanHexInt32(&color)
        
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
