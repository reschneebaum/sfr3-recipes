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
                ), let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
                    self.attributedString = attributedString
                }
            }
        }
    }
}

#Preview {
    HTMLView(
        html: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire. One portion of this dish contains approximately <b>19g of protein </b>,  <b>20g of fat </b>, and a total of  <b>584 calories </b>. For  <b>$1.63 per serving </b>, this recipe  <b>covers 23% </b> of your daily requirements of vitamins and minerals. This recipe serves 2. It is brought to you by fullbellysisters.blogspot.com. 209 people were glad they tried this recipe. A mixture of scallions, salt and pepper, white wine, and a handful of other ingredients are all it takes to make this recipe so scrumptious. From preparation to the plate, this recipe takes approximately  <b>45 minutes </b>. All things considered, we decided this recipe  <b>deserves a spoonacular score of 83% </b>. This score is awesome. If you like this recipe, take a look at these similar recipes: <a href=\"https://spoonacular.com/recipes/cauliflower-gratin-with-garlic-breadcrumbs-318375\">Cauliflower Gratin with Garlic Breadcrumbs</a>, < href=\"https://spoonacular.com/recipes/pasta-with-cauliflower-sausage-breadcrumbs-30437\">Pasta With Cauliflower, Sausage, & Breadcrumbs</a>, and <a href=\"https://spoonacular.com/recipes/pasta-with-roasted-cauliflower-parsley-and-breadcrumbs-30738\">Pasta With Roasted Cauliflower, Parsley, And Breadcrumbs</a>."
    )
}
