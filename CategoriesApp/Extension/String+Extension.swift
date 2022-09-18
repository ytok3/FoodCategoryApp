//
//  String+Extension.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 15.09.2022.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let string = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            
               var attrs = string.attributes(at: 0, effectiveRange: nil)
            attrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 18)
                string.setAttributes(attrs, range: NSRange(location: 0, length: string.length))

            return string
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
