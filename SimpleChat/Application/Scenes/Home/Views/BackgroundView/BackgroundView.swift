//
//  BackgroundView.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/23.
//

import UIKit

protocol BackgroundViewDelegate : class {
    func userDidInteractWithMessageInBackgroundView()
}

final class BackgroundView: UIView {
    
    weak var delegate: BackgroundViewDelegate!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    var viewModel: BackgroundViewViewModel? {
        didSet {
            setUpModel()
        }
    }
    
    static func instantiate(delegate: BackgroundViewDelegate) -> BackgroundView {
        guard let view = UINib(nibName: "BackgroundView", bundle: nil).instantiate(withOwner: self, options: nil).first as? BackgroundView else {
            fatalError("The view could not be instantiated.")
        }
        
        view.delegate = delegate
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTitleLabel()
        setUpSubtitleLabel()
        
        isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(didReceiveTap))
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func didReceiveTap() {
        delegate.userDidInteractWithMessageInBackgroundView()
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setUpSubtitleLabel() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        
    }
    
    private func setUpModel() {
        titleLabel.text = viewModel?.title
        subtitleLabel.text = viewModel?.subtitle
    }
}
