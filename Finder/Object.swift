//
//  Object.swift
//  Finder
//
//  Created by Anthony Viriya on R 2/01/04.
//  Copyright © Reiwa 2 AVL. All rights reserved.
//

import Foundation

struct Object:Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var parent: String
    var childs: Array<Object>
}

class ObjectController:NSObject{
    static func ls(directory:String) -> Array<Object>{
        var retval = Array<Object>()
        do{
            let fm = FileManager.default
            let files = try fm.contentsOfDirectory(atPath: directory)
            files.compactMap{$0}.forEach{(file:String) in
                var isDir : ObjCBool = false
                let path = directory+file
                var type : String = ""
                if fm.fileExists(atPath: path, isDirectory:&isDir) {
                    type = isDir.boolValue ? "dir" : "file"
                }
                let obj = Object(name:file, type:type, parent:directory, childs:[])
                retval.append(obj)
            }
        }catch{
            print(error)
        }
        return retval
    }
    
    static func cat(file:String) -> String{
        var retval:String = ""
        do{
            retval = try String(contentsOfFile: file)
        }catch{
            print(error)
        }
        return retval
    }
}
