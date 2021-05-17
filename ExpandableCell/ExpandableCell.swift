//
//  ExpandableCell.swift
//  ExpandableCell
//
//  Created by Seungyoun Yi on 2017. 8. 10..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

open class ExpandableCell: UITableViewCell {
    
    private var _arrowImageView : UIImageView!
    private var _rightMargin: CGFloat = 16
    private var _highlightAnimation = HighlightAnimation.animated
    private var _isOpen = false
    private var _initialExpansionAllowed = true
    private var _isInitiallyExpanded = false
    private var _isSelectable = false

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        initView()
    }

    func initView() {
        self._arrowImageView = UIImageView();
        
        self._arrowImageView.image = UIImage(named: "expandableCell_arrow", in: Bundle(for: ExpandableCell.self), compatibleWith: nil)
        self.contentView.addSubview(self._arrowImageView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.width
        let height = self.bounds.height
        self._arrowImageView.frame = CGRect(x: width - self._rightMargin, y: (height - 11)/2, width: 22, height: 11)
    }

    @objc
    func open() {
        self._isOpen = true
        self._initialExpansionAllowed = false
        
        if self._highlightAnimation == .animated {
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?._arrowImageView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 1.0, 0.0, 0.0)
            }
        }
    }
    
    @objc
    func openWithoutAnimation() {
        guard !self._isOpen else {
            return
        }
        
        self._isOpen = true
        self._arrowImageView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 1.0, 0.0, 0.0)
    }

    @objc
    func close() {
        self._isOpen = false
        
        if self._highlightAnimation == .animated {
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?._arrowImageView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0.0, 0.0, 0.0)
            }
        }
    }
    
    @objc
    func closeWithoutAnimation() {
        guard self._isOpen else {
            return
        }
        
        self._isOpen = false
        self._arrowImageView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0.0, 0.0, 0.0)
    }
    
    func isInitiallyExpandedInternal() -> Bool {
        return self._initialExpansionAllowed && self._isInitiallyExpanded
    }

    @objc
    func isExpanded() -> Bool {
        return self._isOpen
    }
    
    func isInitiallyExpanded() -> Bool {
        return self._isInitiallyExpanded
    }
    
    func isSelectable() -> Bool {
        return self._isSelectable
    }
    
    @objc
    public func setIsInitiallyExpanded(_ isInitiallyExpanded: Bool){
        self._isInitiallyExpanded = isInitiallyExpanded
    }
    
    @objc
    public func setIsSelectable(_ isSelectable: Bool){
        self._isSelectable = isSelectable
    }
    
    @objc
    public func setRightMargin(_ margin: CGFloat){
        self._rightMargin = margin
    }
    
    @objc
    public func seHighlightAnimation(_ animation: HighlightAnimation){
        self._highlightAnimation = animation
    }
    
    @objc
    public func getArrowImageView() -> UIImageView{
        return self._arrowImageView!
    }
}

@objc
public enum HighlightAnimation : Int {
    case animated = 0
    case none = 1
}
