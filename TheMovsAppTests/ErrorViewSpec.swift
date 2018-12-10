//
//  ErrorViewSpec.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 07/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Nimble_Snapshots

@testable import TheMovsApp

class ErrorViewSpec: QuickSpec {
    
    override func spec() {
        describe("a GenericErrorView") {
            var genericView: GenericErrorView!
            
            it("should show the generic view look with the model passed") {
                let genericModel = GenericErrorModel(imageName: "errorImage", imageColor: .red, message: "Erro generico Erro generico v Erro generic Erro generico Erro generico")
                genericView = GenericErrorView.init(frame: UIScreen.main.bounds, model: genericModel)
                expect(genericView) == snapshot("GenericErrorView")
            }
        }
    }

}
