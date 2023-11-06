//
//  HTMLView.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI

struct HTMLView: View {
    let html: String
    @State private var attributedString: AttributedString?
    
    var body: some View {
        VStack {
            if let attributedString {
                Text(attributedString)
            }
        }
        .onAppear {
            // html -> attributed string conversion *must* be done on main thread
            // to prevent attribute graph warnings.
            DispatchQueue.main.async {
                if let nsAttributedString = try? NSAttributedString(
                    data: .init(html.utf8),
                    options: [.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil
                ), var attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
                    for run in attributedString.runs {
                        var container = AttributeContainer()
                        // Set custom link + non-link font styles to handle light/dark modes
                        if run.link != nil {
                            container.foregroundColor = .accentColor
                            container.font = .system(.body, design: .rounded, weight: .semibold)
                        } else {
                            container.foregroundColor = .defaultText
                        }
                        attributedString[run.range].setAttributes(container)
                    }
                    
                    self.attributedString = attributedString
                }
            }
        }
    }
}

#Preview {
    HTMLView(html: MockData.info.summary)
        .padding()
}
