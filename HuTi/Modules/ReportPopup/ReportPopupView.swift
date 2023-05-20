//
//  ReportPopupView.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 17/05/2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ReportPopupViewDelegate: AnyObject {
    func dismissBottomView()
    
    func didAddReport(content: String)
    
    func didTapSubmitButtonWithEmptyContent()
}

class ReportPopupView: UIView {
    lazy private var topLine = makeTopLine()
    lazy private var titleLabel = makeLabel(text: "Báo cáo tin đăng", font: UIFont.systemFont(ofSize: 22.0, weight: .semibold), textColor: UIColor(named: ColorName.themeText)!)
    lazy private var textViewLabel = makeLabel(text: "Nội dung báo cáo", font: UIFont.systemFont(ofSize: 18, weight: .semibold), textColor: UIColor(named: ColorName.black)!)
    lazy private var textView = makeTextView()
    lazy private var submitButton = makeSubmitButton()
    
    var bottomSafeAreaPadding: CGFloat = 0
//    private var viewModel = MSRouteSelectionBottomViewModel()
    weak var delegate: ReportPopupViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addPanGestureToBottomView()
        
        self.addSubview(topLine)
        self.addSubview(titleLabel)
        self.addSubview(textViewLabel)
        self.addSubview(textView)
        self.addSubview(submitButton)
    }
    
    private func layout() {
        topLine.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(4)
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLine.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        textViewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(textViewLabel.snp.bottom).offset(5)
            make.height.equalTo(150)
        }
        
        submitButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(textView.snp.bottom).offset(10)
        }
    }
    
    @objc private func dismissBottomView() {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0) {
            self.transform = CGAffineTransform(translationX: 0, y: 330)
        } completion: { _ in
            self.removeFromSuperview()
            self.delegate?.dismissBottomView()
        }
    }
    
    @objc private func didTapSubmitButton() {
        guard let text = textView.text,
              text.count > 0
        else {
            delegate?.didTapSubmitButtonWithEmptyContent()
            return
        }
        delegate?.didAddReport(content: text)
        self.dismissBottomView()
    }
    
    private func addPanGestureToBottomView() {
        let swipeDown = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        self.addGestureRecognizer(swipeDown)
    }
    
    @objc private func handleGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        gesture.location(in: self)
        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                self.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            if translation.y > 100 {
                UIView.animateKeyframes(withDuration: 0.3, delay: 0) {
                    self.transform = CGAffineTransform(translationX: 0, y: 330)
                } completion: { _ in
                    self.removeFromSuperview()
                    self.delegate?.dismissBottomView()
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 1) {
                    self.transform = .identity
                }
            }
        default:
            return
        }
    }
}

extension ReportPopupView {
    private func makeTopLine() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        view.layer.cornerRadius = 2
        return view
    }
    
    private func makeLabel(text: String, font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = .center
        return label
    }
    
    private func makeTextView() -> UITextView {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 8.0
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }
    
    private func makeSubmitButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Gửi báo cáo", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: ColorName.themeText)
        button.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        return button
    }
}
