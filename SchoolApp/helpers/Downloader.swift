//
//  Downloader.swift
//  MobilyStore
//
//  Created by yassine dabbous on 2/22/19.
//  Copyright © 2019 yassine dabbous. All rights reserved.
//

import Foundation

/*
var request: Alamofire.Request?
func downloadDirctUrl(_ urlString:String) {
    print("\n\n :D Found URL => ", urlString, "\n\n")
    let destination = DownloadRequest.suggestedDownloadDestination()
    
    request = Alamofire.download(urlString, to: destination)
        .downloadProgress(closure: { (progress) in
            print("progress completedUnitCount", progress.completedUnitCount, "progress.totalUnitCount", progress.totalUnitCount)
            DispatchQueue.main.async {
                print("main")
                //self.delegate?.downloadComplate(progress.fractionCompleted)
                //self.delegate?.counterDownload(Float(progress.completedUnitCount), totalUnitCount: Float(progress.totalUnitCount))
            }
            
        })
        .response { response in // method defaults to `.get`
            
            if let urlVideo = response.destinationURL {
                self.filePath = urlVideo.absoluteString
                print("\n\n Downloaded Mp4 => " , urlVideo , "\n\n")
                //self.saveVideoToLibrary(urlVideo)
            }
    }
    
}

func saveVideoToLibrary(_ urlVideo:URL) {
    PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: urlVideo)
    }) { saved, error in
        if saved {
            print("saved")
            //self.delegate?.downloadIsSuccess(true)
        }else {
            print("not saved")
            //self.delegate?.downloadIsSuccess(false)
        }
    }
    
}
*/
/*
private lazy var urlSession: URLSession = {
    let config = URLSessionConfiguration.background(withIdentifier: "\(Bundle.main.bundleIdentifier ?? "").backgrouns")
    config.isDiscretionary = true
    config.sessionSendsLaunchEvents = true
    return URLSession(configuration: config, delegate: self, delegateQueue: nil)
}()
 
extension ViewController: URLSessionDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print(totalBytesExpectedToWrite)
        print(totalBytesWritten)
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print("Progress \("") \(progress)")
    }
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let backgroundCompletionHandler =
                appDelegate.backgroundCompletionHandler else {
                    return
            }
            backgroundCompletionHandler()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
        guard let httpResponse = downloadTask.response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                print ("server error")
                return
        }
        do {
            let documentsURL = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            let savedURL = documentsURL.appendingPathComponent(
                "\(randomString(length: 2)).mp4")
            filePath = savedURL.absoluteString
            print(location)
            print(savedURL)
            try FileManager.default.moveItem(at: location, to: savedURL)
        } catch {
            print ("file error: \(error)")
        }
    }
    func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
}
*/
