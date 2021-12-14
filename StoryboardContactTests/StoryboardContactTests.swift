//
//  StoryboardContactTests.swift
//  StoryboardContactTests
//
//  Created by Mahmudov Asrbek Ulug'bek o'g'li on 23/10/21.
//

import XCTest
@testable import StoryboardContact

class StoryboardContactTests: XCTestCase {

    func testContactListApiResponseNotNil() {
        let ex = expectation(description: "testContactListApiResponseNotNil")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("error \(error)")
            }
        }
    }
    
    func testContactListApiResponseCount() {
        let ex = expectation(description: "testContactListApiResponseCount")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                XCTAssertEqual(contacts.count, 13)
                print(contacts)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("error \(error)")
            }
        }
    }
    
    func testContactListApiResponseName() {
        let ex = expectation(description: "testContactListApiResponseName")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                XCTAssertEqual(contacts.first!.name, "Asrbek")
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("error \(error)")
            }
        }
    }
    
    func testContactListApiResponseDelete() {
        let ex = expectation(description: "testContactListApiResponseDelete")
        var contact = Contact(name: "Doniyor", phone: "+998977654321")
        contact.id = "15"
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error) // returs nil because already contact was deleted
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("error \(error)")
            }
        }
    }
    
    func testContactListApiResponseCreate() {
        let ex = expectation(description: "testContactListApiResponseCreate")
        let contact = Contact(name: "Elon", phone: "1234567")
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact), handler: { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("error \(error)")
            }
        }
    }
    
    func testContactListApiResponseEdit() {
        let ex = expectation(description: "testContactListApiResponseEdit")
        var contact = Contact(name: "Elon Musk", phone: "+998971234567")
        contact.id = "20"
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + contact.id!, params: AFHttp.paramsContactUpdate(contact: contact), handler: { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("error \(error)")
            }
        }
    }

}
