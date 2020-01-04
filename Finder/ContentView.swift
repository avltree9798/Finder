//
//  ContentView.swift
//  Finder
//
//  Created by Anthony Viriya on R 2/01/04.
//  Copyright © Reiwa 2 AVL. All rights reserved.
//

import SwiftUI

struct ObjectRow: View{
    var object: Object
    var body: some View{
        HStack{
            Text(object.type)
            Text(object.name)
        }
    }
}

struct ContentView: View {
    var directory:String = "/"
    var files = ObjectController.ls(directory: "/")
    var body: some View {
        TabView{
            NavigationView{
                List(files){ object in
                    //
                    if object.type == "dir" {
                        NavigationLink(destination:Dest(directory: "/"+object.name+"/", files: ObjectController.ls(directory: self.directory+object.name))){
                            ObjectRow(object:object)
                        }
                    }else{
                        NavigationLink(destination:FileViewer(file: "/"+object.name, content: ObjectController.cat(file: self.directory+object.name))){
                            ObjectRow(object:object)
                        }
                    }
                    
                }.navigationBarTitle(Text(directory))
            }.tabItem{
                Image(systemName: "folder")
                Text("File Manager")
            }
            MyPhone().tabItem{
               Image(systemName: "cloud.sleet")
                Text("About")
            }
        }
    }
}

struct MyPhone:View{
    
    var body: some View{
        VStack{
            Image("Logo")
                .shadow(radius: 10)
            VStack(alignment: .leading){
                HStack{
                    Text("Device Model")
                    Text(DeviceInfo.modelName)
                }
                HStack{
                    Text("OS Version")
                    Text(UIDevice.current.systemVersion)
                }
                HStack{
                    Text("Made with 💚 by avltree9798")
                }
            }
        }
    }
}

struct FileViewer:View{
    var file:String
    var content:String
    var body: some View{
        Text(content)
    }
}
struct Dest:View{
    var directory:String
    var files:Array<Object>
    var body: some View {
        List(files){ object in
            //
            if object.type == "dir" {
                NavigationLink(destination:Dest(directory: "/"+object.name+"/", files: ObjectController.ls(directory: self.directory+object.name))){
                    ObjectRow(object:object)
                }
            }else{
                NavigationLink(destination:FileViewer(file: "/"+object.name, content: ObjectController.cat(file: self.directory+object.name))){
                    ObjectRow(object:object)
                }
            }
            
        }.navigationBarTitle(Text(directory))
    }
}
