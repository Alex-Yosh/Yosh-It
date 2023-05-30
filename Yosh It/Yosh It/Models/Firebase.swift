//
//  Firebase.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-30.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class Firebase{
    
    var ref: DatabaseReference!
    var user: User
    
    init(){
        ref = Database.database().reference()
        user = User.userObj
    }
    
    //    func sendSplitNames(splitName: String){
    //        self.ref.child("data/\(user.username)/splits").update(splitName)
    //    }
    //
    //    func sendExcerciseNames(splitName: String){
    //        let user = User.userObj
    //        let userData: NSMutableArray = []
    //        let indexSplit = user.getSplitIndex(name: splitName)
    //
    //        for i in user.splits[indexSplit].excercises{
    //            userData.add(i.name)
    //        }
    //
    //
    //        self.ref.child("data/\(user.username)/splits/").child(1).setValue(userData)
    //    }
    
    func sendNames(){
        for i in user.splits{
            let excerciseNames: NSMutableArray = []
            for j in i.excercises{
                excerciseNames.add(j.name)
            }
            
            //means it is empty
            if excerciseNames.isEqual(to: []){
                excerciseNames.add("")
            }
            
            self.ref.child("data/\(user.username)/splits/\(i.name)/excercises").setValue(excerciseNames)
        }
    }
    
    
    func readNames(){
        ref.child("data/\(user.username)/splits").getData(completion:  { [self] error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            if let snapshot = snapshot{
                let value = snapshot.value! as? [String:Any]
                if (value != nil){
                    for splitName in value!.keys{
                        user.splits.append(Split(name: splitName))
                        ref.child("data/\(user.username)/splits/\(splitName)/excercises").getData(completion:  { [self] error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                return;
                            }
                            if let snapshot = snapshot{
                                let excerciseArray = snapshot.value! as! [String]
                                for excercise in excerciseArray{
                                    if (excercise != ""){
                                        user.splits[user.getSplitIndex(name: splitName)].excercises.append(Excercise(Name: excercise))
                                    }
                                }
                            }
                        })
                    }
                }
            }
        });
        
    }
}
