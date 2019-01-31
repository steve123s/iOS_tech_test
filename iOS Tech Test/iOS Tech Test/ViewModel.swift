//
//  ViewModel.swift
//  iOS Tech Test
//
//  Created by Luis Armando Chávez Soto on 18/04/18.
//  Copyright © 2018 Urbvan Trantist. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ViewModel {
    
    func getISSPosition(completion: @escaping (_ response: ISSResponse?) -> ()) {
        
        Alamofire.request("http://api.open-notify.org/iss-now.json").responseObject { (response: DataResponse<ISSResponse>) in
            guard let response = response.result.value else {
                completion(nil)
                return
            }
            print(response.message ?? "ERROR")
            completion(response)

        }

    }
    
    
}
