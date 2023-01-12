//
//  BaseAPI.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import Foundation

import Moya

class BaseAPI{
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            guard decodedData.data != nil else {
                print("⛔️ \(self)애서 디코딩 오류가 발생했습니다 ⛔️")
                return .decodedErr
            }
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr(decodedData.message ?? "요청에러")
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    func disposeNetwork<T: Codable>(_ result: Result<Response, MoyaError>, dataModel: T.Type, completion: @escaping (NetworkResult<Any>) -> Void) {
        switch result{
        case .success(let response):
            let statusCode = response.statusCode
            let data = response.data
            let networkResult = self.judgeStatus(by: statusCode, data, dataModel.self)
            
           completion(networkResult)
            
        case .failure(let err):
            print(err)
            
        }
    }
}
