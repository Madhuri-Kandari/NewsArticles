//
//  ButtonFrontPage.swift
//  NewsAppAssignment
//
//  Created by M1066900 on 27/08/21.
//

import UIKit

class ButtonFrontPage: UIButton {

    override init(frame: CGRect) {
           super.init(frame: frame)
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       init(bgColor:UIColor,title:String){
        super.init(frame: .zero)
           self.backgroundColor = bgColor
           self.setTitle(title, for: .normal)
           configureButton()
       }
      private func configureButton(){
           translatesAutoresizingMaskIntoConstraints = false
           layer.cornerRadius = 10
           titleLabel?.textColor = .white
           titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
           
       }

}
