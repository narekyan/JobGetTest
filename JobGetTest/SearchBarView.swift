//
//  SearchBarView.swift
//  JobGetTest
//
//  Created by Narek on 3/4/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

@objc protocol SearchVarViewDelegate: class {
    func searchBarView(_ searchBarView: SearchBarView, didClickSearchWithTitle title: String, andLocation location: String)
}

class SearchBarView: UIView {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var delegate: SearchVarViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(coverViewTapped)))
        coverView.isHidden = true
        
        titleField.layer.borderColor = UIColor.lightGray.cgColor
        titleField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        titleField.leftViewMode = .always
        
        locationField.layer.borderColor = UIColor.lightGray.cgColor
        locationField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        locationField.leftViewMode = .always
    }
    
    @objc func search() {
        if let title = titleField.text, title.count > 0,
            let location = locationField.text, location.count > 0 {
            
            titleField.resignFirstResponder()
            locationField.resignFirstResponder()
            animateSearch()
            
            delegate?.searchBarView(self, didClickSearchWithTitle: title, andLocation: location)
        }
    }
    
    // animate search view back
    @objc func coverViewTapped() {
        coverView.isHidden = true
        
        heightConstraint.constant = 85
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
            self.titleField.alpha = 0
            self.locationField.alpha = 0
        }) { (f) in
            UIView.animate(withDuration: 0.1, animations: {
                self.layoutIfNeeded()
                self.titleField.alpha = 1
                self.locationField.alpha = 1
            }) { (f) in
                self.titleField.becomeFirstResponder()
            }
        }
    }

    private func animateSearch() {
        coverView.isHidden = false
        
        heightConstraint.constant = 50
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
            self.titleField.alpha = 0
            self.locationField.alpha = 0
        }) { (f) in
            UIView.animate(withDuration: 0.1, animations: {
                self.layoutIfNeeded()
                self.titleField.alpha = 1
                self.locationField.alpha = 1
            }) { (f) in
                
            }
        }
    }
}

extension SearchBarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
