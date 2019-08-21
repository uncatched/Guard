//
//  PremiumTermsCell.swift
//  Guard
//
//  Created by Denys on 8/21/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

class PremiumTermsCell: UITableViewCell {

    @IBOutlet private weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let terms = "Terms of Service"
        let termsURL = URL(string: "https://uncatched.github.io/Guard-ToS/")!
        let privacy = "Privacy Policy"
        let privacyURL = URL(string: "https://uncatched.github.io/Guard-Policy/")!
        let text: NSString = "By upgrading your account, you agree to the Terms of Service and Privacy Policy"
        let termsRange = text.range(of: terms)
        let privacyRange = text.range(of: privacy)
        
        let attributedText = NSMutableAttributedString(string: text as String, attributes: [.foregroundColor: UIColor.gray,
                                                                                            .font: UIFont.systemFont(ofSize: 13)])
        attributedText.addAttributes([.link: termsURL], range: termsRange)
        attributedText.addAttributes([.link: privacyURL], range: privacyRange)
        textView.attributedText = attributedText
        
        textView.linkTextAttributes = [.foregroundColor: UIColor.blue]
    }
}
