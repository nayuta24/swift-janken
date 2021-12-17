//
//  ContentView.swift
//  CSEdApp2
//
//  Created by admin on 2021/12/13.
//

import SwiftUI

struct ContentView: View {
    // onAppearで手の画像を決定するために切り替わり続ける値
    @State private var counter = 0
    // counterに応じてonAppear内で画像が代入される
    @State private var enemyRandomImage = "gu"
    
    //自分の手を格納（0:グー, 1:チョキ, 2:パー）
    @State private var playerHand = 0
    
    //手を選択できるかを判定する
    @State private var canGame = false
    //相手の手を格納
    @State private var enemyHand = 0
    
    //じゃんけんの結果を判定する
    @State private var result = 0
    
    //自分と相手の勝利数
    @State private var playerWin = 0
    @State private var enemyWin = 0
    
    //現在何回戦目なのか
    @State private var gameCount = 1
    
    var body: some View {
        if(gameCount<6){
            VStack{
                //現在何回戦目か
                Text(String(gameCount) + "回戦目")
                /** 顔 */
                Image("gu")
                    .resizable()
                    .scaledToFit()
                //相手の手
                HStack{
                    if(self.canGame){
                        if(enemyHand == 0){
                            Image("gu")
                                .resizable()
                                .scaledToFit()
                        }else if(enemyHand == 1) {
                            Image("choki")
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image("pa")
                               .resizable()
                               .scaledToFit()
                        }

                    }else{
                        Image(self.enemyRandomImage)
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: 180))
                    }
                    Text("相手の勝利数:" + String(enemyWin)).padding(10)
                }.onAppear(){
                    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true){timer in
                        self.counter += 1
                        if(self.counter == 1){
                            self.enemyRandomImage = "gu"
                        }else if(self.counter == 2){
                            self.enemyRandomImage = "choki"
                        }else{
                            self.enemyRandomImage = "pa"
                            self.counter = 0
                        }
                    }
                }
                //勝負の結果
                if(self.result == 0){
                    Text("じゃんけん")
                        .font(.title)
                }else if(self.result == 1){
                    Text("勝ち！")
                        .font(.title)
                }else if(self.result == 2){
                    Text("負け。")
                        .font(.title)
                }else{
                    Text("あいこ")
                        .font(.title)
                }
                
                
                //自分の手
                HStack{
                    VStack{
                        Text("自分の勝利数 :" + String(playerWin))
                        //つぎへボタン
                        Button(action: {
                            self.canGame = false
                            self.result = 0
                            self.gameCount+=1
                        }) {
                            Text("次へ")
                        }.disabled(!self.canGame)
                    }
                    if(playerHand == 0){
                        Image("gu")
                            .resizable()
                            .scaledToFit()
                    }else if(playerHand == 1) {
                        Image("choki")
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image("pa")
                           .resizable()
                           .scaledToFit()
                    }
                }
                .padding(.top, 6.0)
                //一番下の３つの手Button
                HStack{
                    Button(action: {//自分のグーのボタン
                        onHandButton(handNum: 0)
                        
                    }) {
                        Image("gu")
                            .resizable()
                            .scaledToFit()
                    }.disabled(self.canGame)
                    Button(action: {//自分のチョキのボタン
                        onHandButton(handNum: 1)

                    }) {
                        Image("choki")
                            .resizable()
                            .scaledToFit()
                    }.disabled(self.canGame)
                    Button(action: {//自分のパーのボタン
                        onHandButton(handNum: 2)

                    }) {
                        Image("pa")
                            .resizable()
                            .scaledToFit()
                    }.disabled(self.canGame)
                }
            }
        }else{
            VStack{
                Text("自分の勝利数 :" + String(playerWin))
                Text("相手の勝利数:" + String(enemyWin))
                if(playerWin>enemyWin){
                    Text("あなたの勝ちです！")
                }else if(playerWin<enemyWin){
                    Text("あなたの負けです。")
                }else{
                    Text("あいこです。")
                }
                //もう一回遊ぶボタン(初期化処理)
                Button(action: {
                    self.playerHand = 0
                    
                    self.canGame = false
                    
                    self.result = 0
                    
                    self.playerWin = 0
                    self.enemyWin = 0
                    
                    self.gameCount = 1


                }) {
                    Text("もう一回遊ぶ")
                }
            }
        }
        
    }
    //勝ち負けを判定する
    func onHandButton(handNum:Int){
        self.playerHand = handNum
        self.enemyHand = Int.random(in: 0..<3)
        self.canGame = true
        //自分の手がグーの場合の判定
        if(handNum==0){
            if(enemyHand==1){
                result=1
                self.playerWin+=1
            }else if(enemyHand==2){
                result=2
                self.enemyWin+=1
            }else{
                result=3
            }
        }
        //自分の手がチョキの場合の判定
        else if(handNum==1){
            if(enemyHand==2){
                result=1
                self.playerWin+=1
            }else if(enemyHand==0){
                result=2
                self.enemyWin+=1
            }else{
                result=3
            }
        }
        //自分の手がパーの場合の判定
        else{
            if(enemyHand==0){
                result=1
                self.playerWin+=1
            }else if(enemyHand==1){
                result=2
                self.enemyWin+=1
            }else{
                result=3
            }

        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
