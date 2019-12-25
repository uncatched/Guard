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
        
        let terms = NSLocalizedString("premium_label_termsOfService", comment: "")
        let termsURL = URL(string: "https://uncatched.github.io/Guard-ToS/")!
        let privacy = NSLocalizedString("premium_label_privacyPolicy", comment: "")
        let privacyURL = URL(string: "https://uncatched.github.io/Guard-Policy/")!
        let text: NSString = NSLocalizedString("premium_label_terms_and_privacy", comment: "") as NSString
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
