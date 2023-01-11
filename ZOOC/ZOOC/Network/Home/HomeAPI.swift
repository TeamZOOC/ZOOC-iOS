//
//  HomeAPI.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit
import Moya

struct HomeAPI {
    static let shared = HomeAPI()
    var homeProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
}

extension HomeAPI{
    
    public func getTotalPet(familyID: String ,completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getTotalPet(familyID: familyID)) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, [PetResult].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
        private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr((decodedData.message ?? "") as String)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}


