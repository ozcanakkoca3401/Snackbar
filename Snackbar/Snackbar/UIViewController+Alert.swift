//
//  UIViewController+Alert.swift
//  Snackbar
//
//  Created by Ozcan Akkoca on 6.10.2021.
//

import UIKit

extension UIViewController {
    
    static var isSnackBarShown = false
    
    func showSnackBar(success: Bool, message:String?,action:(()->())? = nil){
        guard let window = UIApplication.shared.windows.last else {return}
        guard !UIViewController.isSnackBarShown else {
            if let snackBarView = window.viewWithTag(943210) as? SnackBarView{
                snackBarView.statusUpdate(success: success, message: message)
                snackBarView.action = action
            }
            return
        }
        UIViewController.isSnackBarShown = true
        
        let snackBarView = SnackBarView(success: success, message: message)
        
        window.addSubview(snackBarView)
        
        snackBarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(window.safeAreaLayoutGuide.snp.top)
        }
        
        snackBarView.showSnackBar(action:action)
    }
    
}
