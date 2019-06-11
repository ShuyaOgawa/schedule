//
//  SelectClassViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/05/29.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase

class SelectClassViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var SelectClassTable: UITableView!
    
    
    @IBOutlet weak var searchField: UITextField!
    
    
    
    @IBOutlet weak var title_label: UILabel!
    
    var receive_indexPath: String = ""
    var receive_day: String = ""
    var give_indexPath: String = ""
    var give_day: String = ""
    
    let daigaku = UserDefaults.standard.string(forKey: "daigaku")
    let gakubu = UserDefaults.standard.string(forKey: "gakubu")
    
    var classList: Array<String> = []
    var subClassList: Array<String> = []
    var roomList: Array<String> = []
    var subRoomList: Array<String> = []
    var profList: Array<String> = []
    var subProfList: Array<String> = []
    var subscriberList: Array<Int> = []
    var subSubscriberList: Array<Int> = []
    var indexPathList: Array<String> = []
    var subscribeNumber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        title_label.text = receive_day
        
        getClassesName()
        
        searchTextFieldConfig()
        
        

        // Do any additional setup after loading the view.
    }
    
    func searchTextFieldConfig() {
        
        //検索ボタン
        searchField.returnKeyType = UIReturnKeyType.google
        
        searchField.clearButtonMode = UITextField.ViewMode.always
        
        searchField.delegate = self
    }
    
    func getClassesName() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(daigaku!)/\(gakubu!)/").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value != nil {
                var classNumber = 0
                while classNumber < 36 {
                    var className = value![String(classNumber)] as? [String : Any]
                    if className != nil {
                        for (key, value) in className! {
                            self.classList.append(key)
                            self.subClassList.append(key)
                            if let room_dictionary = value as? NSDictionary {
                                self.roomList.append(room_dictionary["room_name"]! as! String)
                                self.subRoomList.append(room_dictionary["room_name"]! as! String)
                                self.profList.append(room_dictionary["prof_name"]! as! String)
                                self.subProfList.append(room_dictionary["prof_name"]! as! String)
                                self.subscriberList.append(room_dictionary["subscriber"]! as! Int)
                                self.subSubscriberList.append(room_dictionary["subscriber"]! as! Int)
                                self.indexPathList.append(String(classNumber))
                            }
                        }
                    }
                    classNumber += 1
                    self.SelectClassTable.reloadData()

                }

            }
        })
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "selectClassItem", for: indexPath) as! SelectClassTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let selectClassName = cell.contentView.viewWithTag(1) as? UILabel
        selectClassName?.text = classList[indexPath.row]
        
        let classRoomLabel = cell.contentView.viewWithTag(2) as? UILabel
        classRoomLabel?.text = roomList[indexPath.row]
        
        let profNameLabel = cell.contentView.viewWithTag(3) as? UILabel
        profNameLabel?.text = profList[indexPath.row]
        
        let subsceriberLabel = cell.contentView.viewWithTag(5) as? UILabel
        subsceriberLabel?.text = String(subscriberList[indexPath.row])
        
        let register_button = cell.contentView.viewWithTag(4) as? UIButton
        register_button?.tag = indexPath.row
        register_button?.addTarget(self, action: "register_button:", for: .touchUpInside)

        
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "new_class" {
            let vc = segue.destination as! new_class_ViewController
            vc.receive_indexPath = self.receive_indexPath
            vc.receive_day = self.receive_day
        }
        
        
        
    }
    
    @IBAction func register_button(_ sender: Any) {
        let row = (sender as AnyObject).tag
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "登録", message: "この授業を登録しますか？", preferredStyle:  UIAlertController.Style.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            //        UserDefaiultsのuser_id、class_name、room_name削除
            //                UserDefaultに授業を登録
            var class_array = UserDefaults.standard.array(forKey: "class_name")! as! Array<String>
            class_array[Int(self.receive_indexPath)!] = self.classList[row!]
            UserDefaults.standard.set(class_array, forKey: "class_name")
            //                UserDeafultsに教室を登録
            var room_array = UserDefaults.standard.array(forKey: "room_name")! as! Array<String>
            room_array[Int(self.receive_indexPath)!] = self.roomList[row!]
            UserDefaults.standard.set(room_array, forKey: "room_name")
            
//            登録者数にアクセスして+1する
            var ref: DatabaseReference!
            ref = Database.database().reference()
            print("countttttttttttt")
            print(self.subscriberList[row!]+1)
            ref.child("classes/\(self.daigaku!)/\(self.gakubu!)/\(self.indexPathList[row!])/\(self.classList[row!])").updateChildValues(["subscriber": self.subscriberList[row!]+1])
            
            self.go_to_timeSchedule()
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        self.present(alert, animated: true, completion: nil)
        
    }

    
    //    timeScheduleに移動するメソッド
    func go_to_timeSchedule() {
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let timeschedule = storyboard.instantiateViewController(withIdentifier: "timeschedule")
        //ここが実際に移動するコードとなります
        self.present(timeschedule, animated: true, completion: nil)
    }
    
    
    func classSearch() {
        let searchClass: String = searchField.text!
        var removeNumber: Int
        for className in classList {
            if !className.contains(searchClass) {
                removeNumber = classList.index(of: className)!
                classList.remove(at: removeNumber)
                roomList.remove(at: removeNumber)
                profList.remove(at: removeNumber)
                subscriberList.remove(at: removeNumber)
            }
        }
        
    }
    
//    キーボードの検索ボタンが押された時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.resignFirstResponder()
        
//        テキストフィールドに何も書かれないで検索ボタンが押された時
        if searchField.text! == "" {
            classList = subClassList
            roomList = subRoomList
            profList = subProfList
            subscriberList = subSubscriberList
            self.SelectClassTable.reloadData()
        } else{
            classSearch()
        }
        
        self.SelectClassTable.reloadData()
        return true
        
    }
    
//    テキストフィールドの削除ボタンが押された時
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        classList = subClassList
        roomList = subRoomList
        profList = subProfList
        subscriberList = subSubscriberList
        self.SelectClassTable.reloadData()
        return true
    }
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
