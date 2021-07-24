# SkeletonViewTutorial
☠️ 오픈소스 라이브러리 SkeletonView 를 사용해보자

<img src = "https://user-images.githubusercontent.com/69136340/126873750-e176c158-7a68-41c2-a768-73359bf3fdcb.gif" width ="250">

[GitHub - Juanpe/SkeletonView](https://github.com/Juanpe/SkeletonView)

- SkeletonView 는 사용자에게 어떤 일이 일어나고 있음을 보여주고 어떤 콘텐츠를 기다리고 있는지 준비하는 방법으로 소개된다.

### Installation

- CocoaPods:

```swift
pod 'SkeletonView'
```

### Usage

1️⃣ 적당한 곳에 import 한다.

```swift
import SkeletonView
```

2️⃣ view 를 `skeletonables` 하게 만드는 방법은 2가지가 있다.

**Using code:**

```
avatarImageView.isSkeletonable = true
```

**Using IB/Storyboards:**

<img width="300" alt="1" src="https://user-images.githubusercontent.com/69136340/126871520-7f4a2ce0-b00b-42a2-b599-330c43e82274.png">

3️⃣ 다음 4가지 선택으로 skeleton 을 보여줄 수 있다.

```swift
(1) view.showSkeleton()                 // Solid
(2) view.showGradientSkeleton()         // Gradient
(3) view.showAnimatedSkeleton()         // Solid animated
(4) view.showAnimatedGradientSkeleton() // Gradient animated
```

📣 **IMPORTANT!**

`SkeletonView` 은 재귀적이기 때문에 모든 skeletonable view 에서 skeleton 을 보여주고 싶다면 메인 컨테이너 뷰에서 위의 show 메서드를 호출하면 된다.

---

**UITableView**

UITableView 에서 skeleton 을 사용하고 싶다면 `SkeletonTableViewDataSource` 프로토콜을 채택해야한다.

```swift
public protocol SkeletonTableViewDataSource: UITableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int // Default: 1
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? // Default: nil
    func collectionSkeletonView(_ skeletonView: UITableView, prepareCellForSkeleton cell: UITableViewCell, at indexPath: IndexPath)
}
```

보는 것처럼 SkeletonTableViewDataSource 는 UITableViewDataSource 를 상속받기 때문에 대체 가능하다.

**UICollectionView**

 `UICollectionView` 에서는 `SkeletonCollectionViewDataSource` 프로토콜을 채택해야 한다.

```swift
public protocol SkeletonCollectionViewDataSource: UICollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int  // default: 1
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? // default: nil
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell?  // default: nil
    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath)
}
```

### **🔠 Texts**

텍스트가 있는 elements 를 사용할 때 `SkeletonView` 는 시뮬레이션하기 위해서 그려본다. 게다가 원하는 라인 수를 결정할 수 있다. `numberOfLines` 이 0 으로 설정되어 있다면 전체 골격을 채우는 데 필요한 선 수를 계산하여 그려진다. 대신 0보다 큰 숫자로 설정하면 이 수의 선만 그린다.

```swift
// Corner radius of lines 
// 0...100 (default: 70)
descriptionTextView.lastLineFillPercent = 50

// Filling percent of the last line.
// 0...10 (default: 0)
descriptionTextView.linesCornerRadius = 5
```

- storyboard 에서도 설정 가능

Corner radius of lines.

<img width="600" alt="스크린샷 2021-07-24 오후 8 52 49" src="https://user-images.githubusercontent.com/69136340/126871530-b81e8430-93c0-4cc5-90fe-34168f7ff867.png">

Filling percent of the last line.

<img width="600" alt="스크린샷 2021-07-24 오후 8 53 12" src="https://user-images.githubusercontent.com/69136340/126871534-6af34ddf-355b-4626-8138-972becf2c314.png">

### 실습해보자

- ViewController.swift

```swift
import UIKit
import SkeletonView

class ViewController: UIViewController {
    var countData: [Int] = []

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var skeletonCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skeletonCollectionView.delegate = self
        skeletonCollectionView.dataSource = self
        skeletonCollectionView.register(UINib(nibName: "SkeletonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SkeletonCollectionViewCell")
        
        skeletonCollectionView.isSkeletonable = true
        skeletonCollectionView.showSkeleton()
        // 다음과 같이 설정 가능
//        skeletonCollectionView.showSkeleton(usingColor: .clouds, transition: .crossDissolve(0.25))
        
        // 네트워크 통신 대신 DisdspatchQueue 를 통해서 2초간 딜레이를 주어서 구현
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            for i in 0..<10 {
                self.countData.append(i)
            }
            
            self.skeletonCollectionView.stopSkeletonAnimation()
            self.skeletonCollectionView.hideSkeleton()
            // 다음과 같이 설정 가능
    //        skeletonCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
}
```

exestion

```swift
// MARK: - SkeletonTableViewDelegate
extension ViewController: SkeletonCollectionViewDelegate { }

// MARK: - SkeletonTableViewDataSource
extension ViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SkeletonCollectionViewCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkeletonCollectionViewCell", for: indexPath) as? SkeletonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.skeletonImageView.image = UIImage(named: "icon") ?? UIImage()
        cell.skeletonFirstLabel.text = String(countData[indexPath.row])
        cell.skeletonTextView.text = String(countData[indexPath.row])

        return cell
    }
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 컬렉션뷰를 다 채우기 위한 개수
        return UICollectionView.automaticNumberOfSkeletonItems
        
        // skeletonView 가 보여질 때 
        // return 1
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        return CGSize(width: cellWidth, height: 150)
    }
}
```

- SkeletonCollectionViewCell.xib

<img width="600" alt="스크린샷 2021-07-25 오전 12 28 53" src="https://user-images.githubusercontent.com/69136340/126873478-8708bf20-4535-49f0-8a69-ccca05445fc5.png">

- SkeletonCollectionViewCell.swift

```swift
import UIKit

class SkeletonCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var skeletonTextView: UITextView!
    @IBOutlet weak var skeletonFirstLabel: UILabel!
    @IBOutlet weak var skeletonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isSkeletonable = true
        self.skeletonImageView.isSkeletonable = true
        self.skeletonFirstLabel.isSkeletonable = true
        self.skeletonTextView.isSkeletonable = true
        
        // 둥근 모서리
        
        self.skeletonImageView.skeletonCornerRadius = 10
        self.skeletonFirstLabel.linesCornerRadius = 5
        self.skeletonTextView.linesCornerRadius = 5

        // 마지막 줄에 skeleton 채우는 비율
        
        // numberOfLines 가 1 이면 적용되지 않음
        self.skeletonFirstLabel.numberOfLines = 2
        self.skeletonFirstLabel.lastLineFillPercent = 50

        self.skeletonTextView.lastLineFillPercent = 50
    }
}
```
