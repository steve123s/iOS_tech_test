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

/*
La clase ViewModel se va a encargar de hacer el request a la API de la ISS. Se utiliza Alamofire para facilitar el proceso.
 AlamofireObjectMapper nos ayuda a automáticamente convertir la respuesta json de Alamofire a un objeto de Swift, gracias a ObjectMapper.
 En este caso se desea converir la respuesta a un ISSResponse, si se tiene éxito y hay una respuesta, se imprime el mensaje de la respuesta (o "ERROR") si éste es nulo y se ejecuta nuestro completion pasando el parámetro de la respuesta (ISSResponse).
 
 */
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
