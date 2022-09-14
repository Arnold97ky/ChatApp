//
//  Extension.swift
//  GroupKit
//
//  Created by Arnold Sylvestre on 8/12/22.
//

import Foundation
import UIKit

extension UIView {

public var width: CGFloat {
    return self.frame.size.width
}
    public var height: CGFloat {
        return self.frame.size.width
    }

    public var top: CGFloat {
        return self.frame.origin.y
    }


    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
        
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
    
    
    
    func bindToSuperView(insets: CGFloat = 8){
        guard let superSafeArea = self.superview?.safeAreaLayoutGuide else {
            fatalError("Forgot to add the view to the view hierarchy. FIX IT!")
    }
        self.topAnchor.constraint(equalTo: superSafeArea.topAnchor, constant: insets).isActive = true
        self.leadingAnchor.constraint(equalTo: superSafeArea.leadingAnchor, constant: insets).isActive = true
        self.trailingAnchor.constraint(equalTo: superSafeArea.trailingAnchor, constant: -insets).isActive = true
        self.bottomAnchor.constraint(equalTo: superSafeArea.bottomAnchor, constant: -insets).isActive = true
    }
}


extension Notification.Name {
    /// Notificaiton  when user logs in
    static let didLogInNotification = Notification.Name("didLogInNotification")
}
