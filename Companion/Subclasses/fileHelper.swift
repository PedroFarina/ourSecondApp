//
//  fileHelper.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 13/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class FileHelper{
    private static let fileManager:FileManager = FileManager()
    
    public static func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    public static func saveImage(image:UIImage, nameWithoutExtension:String){
        if let data = image.pngData(){
            let filename = getDocumentsDirectory().appendingPathComponent("\(nameWithoutExtension).png")
            do{
                try data.write(to: filename)
            }
            catch{
                fatalError("Não foi possível salvar a imagem")
            }
        }
    }
    
    public static func getFile(filePathWithoutExtension:String) -> String?{
        let imagePath:URL = getDocumentsDirectory().appendingPathComponent("\(filePathWithoutExtension).png")
        if fileManager.fileExists(atPath: imagePath.relativePath){
            return imagePath.relativePath
        }
        else{
            return nil
        }
    }
    
    public static func deleteImage(filePathWithoutExtension:String) -> Bool{
        do{
            let imagePath:URL = getDocumentsDirectory().appendingPathComponent("\(filePathWithoutExtension).png")
            if fileManager.fileExists(atPath: imagePath.relativePath){
                try fileManager.removeItem(at: imagePath)
            }
            else{
                return false
            }
        }
        catch{
            fatalError("Não foi possível deletar o arquivo desejado")
        }
        return true
    }
}
