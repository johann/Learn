//
//  CollapsibleTableViewHeader.swift
//  CollapsibleTableSectionViewController
//
//  Created by Yong Su on 7/20/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ section: Int)
}

open class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    let titleLabel = UILabel()
    let arrowImageView = UIImageView()
    
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Content View
//        contentView.backgroundColor = UIColor(hex: 0x2E3944)
        contentView.backgroundColor = UIColor.white
        
        let marginGuide = contentView.layoutMarginsGuide
        arrowImageView.image = UIImage(named: "up-arrow")
        contentView.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        // Title label
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        
        _ = delegate?.toggleSection(cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        arrowImageView.rotate(collapsed ? 0.0 : .pi)
    }
    
}

extension UIColor {
    
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
}

extension UIView {
    // TODO: Handle arrow orientation
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
}


