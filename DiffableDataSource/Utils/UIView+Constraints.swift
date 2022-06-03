//
//  UIView+Constraints.swift
//  DiffableDataSource
//
//  
//

import UIKit

public struct AnchoredContraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}


extension UIView {
    
    @discardableResult
    open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?,
                     bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                     padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredContraints {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredConstraints = AnchoredContraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach {
            $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    @discardableResult
    open func anchorGreaterThanOrEqual(top: NSLayoutYAxisAnchor) -> AnchoredContraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredContraints()
        anchoredConstraints.top = topAnchor.constraint(greaterThanOrEqualTo: top)
        return anchoredConstraints
    }
    
    @discardableResult
    open func anchorGreaterThanOrEqual(bottom: NSLayoutYAxisAnchor) -> AnchoredContraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredContraints()
        anchoredConstraints.bottom = bottomAnchor.constraint(greaterThanOrEqualTo: bottom)
        return anchoredConstraints
    }
    
    @discardableResult
    open func anchorGreaterThanOrEqual(leading: NSLayoutXAxisAnchor) -> AnchoredContraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredContraints = AnchoredContraints()
        anchoredContraints.leading = leadingAnchor.constraint(greaterThanOrEqualTo: leading)
        return anchoredContraints
    }
    
    @discardableResult
    open func anchorGreaterThanOrEqual(trailing: NSLayoutXAxisAnchor) -> AnchoredContraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredContraints = AnchoredContraints()
        anchoredContraints.trailing = trailingAnchor.constraint(greaterThanOrEqualTo: trailing)
        return anchoredContraints
    }
    
    @discardableResult
    open func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredContraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredContraints()
        guard let superviewTopAnchor = superview?.topAnchor,
              let superviewBottomAnchor = superview?.bottomAnchor,
              let superviewleadingAnchor = superview?.leadingAnchor,
              let superviewTrailingAnchor = superview?.trailingAnchor else {
            return anchoredConstraints
        }
        
        return anchor(top: superviewTopAnchor,
                      leading: superviewleadingAnchor,
                      bottom: superviewBottomAnchor,
                      trailing: superviewTrailingAnchor,
                      padding: padding)
        
    }
    
    
    @discardableResult
    open func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredContraints {
        let anchoredConstraints = AnchoredContraints()
        if #available(iOS 11.0, *) {
            guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
                  let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
                  let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
                  let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
                return anchoredConstraints
            }
            return anchor(top: superviewTopAnchor,
                          leading: superviewLeadingAnchor,
                          bottom: superviewBottomAnchor,
                          trailing: superviewTrailingAnchor,
                          padding: padding)
        } else {
            return anchoredConstraints
        }
        
    }
    
    open func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func centerXTo(_ anchor: NSLayoutXAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    open func centerYTo(_ anchor: NSLayoutYAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    open func centerXToSuperview(){
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }
    
    open func centerYToSuperView(){
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
    }
    
    @discardableResult
    open func constrainHeight(_ constant: CGFloat) -> AnchoredContraints {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredConstraints = AnchoredContraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    open func constrainWidth(_ constant: CGFloat) -> AnchoredContraints {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredContraints = AnchoredContraints()
        anchoredContraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredContraints.width?.isActive = true
        return anchoredContraints
    }
    
    @discardableResult
    open func constrainSize(_ constant: CGSize) -> AnchoredContraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredContraints = AnchoredContraints()
        anchoredContraints.width = widthAnchor.constraint(equalToConstant: constant.width)
        anchoredContraints.height = heightAnchor.constraint(equalToConstant: constant.height)
        anchoredContraints.width?.isActive = true
        anchoredContraints.height?.isActive = true
        
        return anchoredContraints
    }
   
    
    
}
