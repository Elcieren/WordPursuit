![Ekran-Kaydı-2024-10-08-05 24 07](https://github.com/user-attachments/assets/108ee612-0213-42a1-900a-7488673fa8dd)
 <details>
    <summary><h2>Uygulma Amacı</h2></summary>
    Proje Amacı
   Swift ve UIKit kullanılarak geliştirilmiş eğlenceli ve etkileşimli bir kelime bulmaca oyunu. Bu oyun, oyuncuların verilen ipuçlarına dayanarak doğru cevapları oluşturmak için harfleri seçmelerini gerektirir. Hem günlük oyuncular hem de kelime dağarcıklarını geliştirmek isteyenler için idealdir!
  </details>  

  <details>
    <summary><h2>loadView() Metodu</h2></summary>
    Görünüm yüklenmeden önce arayüzün programlı olarak oluşturulmasını sağlar Temel view ayarlanır ve arka plan rengi belirlenir.scoreLabel, cluesLabel, answerLabel, currentAnswer, submit, clear butonları ve buttonsView gibi UI elemanları oluşturulur ve düzenlenir.Auto Layout kullanılarak elemanların konumları belirlenir.Harf butonları dinamik olarak oluşturulur ve letterButtons dizisine eklenir
    
    ```
    override func loadView() {
    view = UIView()
    view.backgroundColor = .systemPurple
    
    // UI elemanlarının kurulumu ve Auto Layout kısıtlamaları
    // Harf butonlarının oluşturulması ve düzenlenmesi
    }

    ```
  </details> 

  <details>
    <summary><h2>letterTapped(_:)</h2></summary>
    Tıklanan butonun başlığını alır ve currentAnswer metin alanına ekler.Butonu activitedButton dizisine ekler ve görünürlüğünü gizler.

    
    ```
    @objc func letterTapped(_ sender: UIButton){
    guard let buttonTitle = sender.titleLabel?.text else { return }
    
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activitedButton.append(sender)
    sender.isHidden = true
    }

    ```
  </details> 

  <details>
    <summary><h2>submitTapped(_:)</h2></summary>
    currentAnswer metin alanındaki cevabı alır.Cevabın solutions dizisinde olup olmadığını kontrol eder.Doğruysa:aktif butonları temizler.answerLabel üzerinde ilgili cevabı günceller.currentAnswer alanını sıfırlar.Puanı artırır ve günceller.Puan belirli bir değere ulaştığında (örneğin, 7), kullanıcıya bir sonraki seviyeye geçmek isteyip istemediğini soran bir uyarı gösterir.
    
    ```
     @objc func submitTapped(_ sender: UIButton){
     guard let answerText = currentAnswer.text else { return }
    
    if let solitionsPosition = solutions.firstIndex(of: answerText) {
        activitedButton.removeAll()
        
        var splitAnswer = answerLabel.text?.components(separatedBy: "\n")
        splitAnswer?[solitionsPosition] = answerText
        answerLabel.text = splitAnswer?.joined(separator: "\n")
        currentAnswer.text = ""
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        if score % 7 == 0 {
            let ac = UIAlertController(title: "Tebrikler!", message: "Bir sonraki seviyeye geçmeye hazır mısın?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Hadi Gidelim", style: .default, handler: levelUp))
            present(ac, animated: true)
        }
    }
    } 
    
    ```
  </details> 


  <details>
    <summary><h2>clearTapped(_:)</h2></summary>
    currentAnswer metin alanını sıfırlar.Daha önce aktif olan butonları tekrar görünür hale getirir.activitedButton dizisini temizler.
    
    ```
    @objc func clearTapped(_ sender: UIButton){
    currentAnswer.text = ""
    
    for button in activitedButton {
        button.isHidden = false
    }
    activitedButton.removeAll()
    }

    ```
  </details> 

  <details>
    <summary><h2>loadLevel()</h2></summary>
    Seçilen oyun ve seviyeye göre ilgili metin dosyasını bulur.Dosyanın içeriğini okur ve satırlara böler.Satırları karıştırır ve her satırı ipucu ve cevap olarak ayırır.cluesLabel ve answerLabel etiketlerini günceller.Harfleri letterButtons dizisine dağıtır ve başlıklarını ayarlar.
    
    ```
    func loadLevel() {
    var clueString = ""
    var solutionsString = ""
    var letterBits = [String]()
    
    if let levelFileURL  = Bundle.main.url(forResource: "\(selectedGame!)Level\(level)", withExtension: "txt") {
        if let levelContents = try? String(contentsOf: levelFileURL) {
            
            var lines = levelContents.components(separatedBy: "\n")
            lines.shuffle()
            
            for (index , line) in lines.enumerated() {
                let parts = line.components(separatedBy: ": ")
                let answer = parts[0]
                let clu = parts[1]
                
                clueString += "\(index + 1). \(clu)\n"
                
                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                solutionsString += "\(solutionWord.count) harf\n"
                solutions.append(solutionWord)
                
                let bit = answer.components(separatedBy: "|")
                letterBits += bit
            }
        }
    }
    
    cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
    answerLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    letterButtons.shuffle()
    
    if letterButtons.count == letterBits.count {
        for i in 0..<letterButtons.count {
            letterButtons[i].setTitle(letterBits[i], for: .normal)
        }
    }
}

    ```
  </details> 


<details>
    <summary><h2>Uygulama Görselleri </h2></summary>
    
    
 <table style="width: 100%;">
    <tr>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">ANA Ekran</h4>
            <img src="https://github.com/user-attachments/assets/a9b19eee-54be-409b-8988-d25e8bdff1ea" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Oyunun Kategorisİ Seçilme Ekranı</h4>
            <img src="https://github.com/user-attachments/assets/9a7651c2-ef90-424f-b519-d5d8157753ee" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Seçilen Kategori Oyun Ekranı</h4>
            <img src="https://github.com/user-attachments/assets/9f490634-ed9d-4322-bff6-bdccc1886ff6" style="width: 100%; height: auto;">
        </td>
    </tr>
</table>
  </details> 
