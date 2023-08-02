//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 21/06/2023.
//

import UIKit
import SmilesUtilities
import SmilesFontsManager
import Combine
import SmilesLanguageManager

public class SmilesVerifyEmailViewController: UIViewController {
    
    // MARK: -- Outlets
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var roundIconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var linkValidityLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    
    // MARK: -- Properties
    public static let storyboardVC = UIStoryboard(name: "SmilesVerifyEmail", bundle: Bundle.module).instantiateInitialViewController()
    let input: PassthroughSubject<EmailVerificationViewModel.Input, Never> = .init()
    private let viewModel = EmailVerificationViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    public var userEmail: String?
    public var didVerifyEmail: ((SmilesEmailVerificationResponseModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        setupViewUI()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initialSetup()
    }
    
    private func initialSetup() {
        emailLabel.text = userEmail ?? ""
        emailLabel.textAlignment = AppCommonMethods.languageIsArabic() ? .right : .left
        
        titleLabel.text = SmilesLanguageManager.shared.getLocalizedString(for: "EmailVerification")
        descriptionLabel.text = SmilesLanguageManager.shared.getLocalizedString(for: "EmailVerificationDescription")
        linkValidityLabel.text = SmilesLanguageManager.shared.getLocalizedString(for: "EmailLinkDuration")
        primaryButton.setTitle(SmilesLanguageManager.shared.getLocalizedString(for: "EmailVerificationSendLink"), for: .normal)
        secondaryButton.setTitle(SmilesLanguageManager.shared.getLocalizedString(for: "EmailVerificationLater"), for: .normal)
    }
    
    private func setupViewUI() {
        view.backgroundColor = .appRevampFilterTextColor.withAlphaComponent(0.6)
        
        titleLabel.fontTextStyle = .smilesHeadline2
        titleLabel.textColor = .appRevampLocationTextColor
        descriptionLabel.fontTextStyle = .smilesBody3
        descriptionLabel.textColor = UIColor(red: 109.0 / 255.0, green: 102.0 / 255.0, blue: 112.0 / 255.0, alpha: 1.0) // Add color in UIColor extension in Smiles Utilities
        
        bottomContainerView.addMaskedCorner(withMaskedCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner], cornerRadius: 16)
        handleView.addMaskedCorner(withMaskedCorner: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], cornerRadius: handleView.bounds.height / 2)
        
        roundIconView.addMaskedCorner(withMaskedCorner: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], cornerRadius: roundIconView.bounds.height / 2)
        roundIconView.backgroundColor = .appRevampEnableStateColor
        
        emailLabel.fontTextStyle = .smilesHeadline4
        emailLabel.textColor = .appRevampClosingTextGrayColor
        
        linkValidityLabel.fontTextStyle = .smilesBody3
        linkValidityLabel.textColor = .appRevampHomeSearchColor
        
        secondaryButton.addMaskedCorner(withMaskedCorner: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], cornerRadius: primaryButton.bounds.height / 2)
        secondaryButton.setBackgroundColor(.appRevampPurpleMainColor, for: .normal)
        secondaryButton.setTitleColor(.white, for: .normal)
        secondaryButton.titleLabel?.fontTextStyle = .smilesTitle1
        
        primaryButton.addMaskedCorner(withMaskedCorner: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], cornerRadius: secondaryButton.bounds.height / 2)
        let primaryButtonColor = UIColor(red: 110.0 / 255.0, green: 60.0 / 255.0, blue: 130.0 / 255.0, alpha: 1.0) // Add color in UIColor extension in Smiles Utilities
        primaryButton.setTitleColor(primaryButtonColor, for: .normal)
        primaryButton.addBorder(withBorderWidth: 2, borderColor: primaryButtonColor)
        primaryButton.titleLabel?.fontTextStyle = .smilesTitle1
    }
    
    // MARK: -- Binding
    
    func bind(to viewModel: EmailVerificationViewModel) {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        output
            .sink { [weak self] event in
                switch event {
                    // MARK: - Success cases
                    // Email Verification Success
                case .sendEmailVerificationLinkDidSucceed(let emailVerificationResponse):
                    self?.dismiss(completion: {
                        self?.didVerifyEmail?(emailVerificationResponse)
                    })
                    
                    // MARK: - Failure cases
                case .sendEmailVerificationLinkDidFail(let error):
                    print(error.localizedDescription)
                    self?.dismiss()
                }
            }.store(in: &cancellables)
    }
}

// MARK: -- Actions

extension SmilesVerifyEmailViewController {
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss()
    }
    
    @IBAction func primaryButtonTapped(_ sender: UIButton) {
        self.input.send(.sendEmailVerificationLink)
    }
    
    @IBAction func secondaryButtonTapped(_ sender: UIButton) {
        dismiss()
    }
}
