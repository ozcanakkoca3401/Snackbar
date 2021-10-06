//
//  SnackBarView.swift
//  Snackbar
//
//  Created by Ozcan Akkoca on 6.10.2021.
//

import UIKit
import SnapKit

class SnackBarView:UIView{
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .green
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "swiftmessages-success-icon")
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.tag = 94321
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitle("DONE", for: .normal)
        button.addTarget(self, action:#selector(btnDoneAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    private let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top
    var action:(()->())?
    
    init(success: Bool, message:String?){
        super.init(frame: .zero)
        
        tag = 943210
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        statusUpdate(success: success, message: message)
        
        setupUI()
        prepareGesture()
         
    }
    
    func setupUI() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        imageContainerView.addSubview(imageView)
        
        stackView.addArrangedSubview(imageContainerView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)

        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    func prepareGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
        gesture.direction = .up
        containerView.addGestureRecognizer(gesture)
    }
    
    
    func showSnackBar(action:(()->())?){
        layoutIfNeeded()
        self.action = action
        let height = (-2 * frame.height) - (topPadding ?? 0)
        transform = CGAffineTransform(translationX: 0, y: height)
        
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (finished) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if let _ = self.superview{
                    self.removeSnackBar()
                }
            }
        }
    }
    
    
    private func removeSnackBar(){
        layoutIfNeeded()
        let height = (-2 * frame.height) - (topPadding ?? 0)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.transform = .init(translationX: 0, y: height)
        }) { (finished) in
            UIViewController.isSnackBarShown = false
            self.layer.removeAllAnimations()
            self.layoutIfNeeded()
            self.removeFromSuperview()
        }
    }
    
    func statusUpdate(success: Bool, message:String?) {
        label.text = message
        
        if success {
            containerView.backgroundColor = .green
            label.textColor = .black
            imageView.image = UIImage(named: "success-icon")
        } else {
            containerView.backgroundColor = .red
            label.textColor = .black
            imageView.image = UIImage(named: "error-icon")
        }
        
    }
    
    @objc func btnDoneAction(){
        action?()
        removeSnackBar()
    }
    
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        removeSnackBar()
    }
    
    
    deinit {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

