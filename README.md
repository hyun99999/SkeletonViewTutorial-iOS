# SkeletonViewTutorial-iOS
☠️ 오픈소스 라이브러리 SkeletonView 을 활용한 튜토리얼

[GitHub - Juanpe/SkeletonView](https://github.com/Juanpe/SkeletonView)

- skeleton view 는 예를 들어 네트워크 통신을 통해서 데이터를 기다리는 동안 화면에 아무것도 띄우지 않기 보다 뭔가 진행되고 있는 듯한 느낌을 사용자에게 주어 체감시간을 줄여줄 수 있다.

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

<img width="600" alt="스크린샷 2021-07-24 오후 8 52 49" src="https://user-images.githubusercontent.com/69136340/126871530-b81e8430-93c0-4cc5-90fe-34168f7ff867.png">


Filling percent of the last line.

<img width="600" alt="스크린샷 2021-07-24 오후 8 53 12" src="https://user-images.githubusercontent.com/69136340/126871534-6af34ddf-355b-4626-8138-972becf2c314.png">

### 실습해보자

- ViewController.swift

```swift

```

exestion

```swift

```

- SkeletonCollectionViewCel.swift

```swift
import UIKit

class SkeletonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var skeletonThirdLabel: UILabel!
    @IBOutlet weak var skeletonSecondLabel: UILabel!
    @IBOutlet weak var skeletonFirstLabel: UILabel!
    @IBOutlet weak var skeletonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isSkeletonable = true
        self.skeletonImageView.isSkeletonable = true
        self.skeletonFirstLabel.isSkeletonable = true
        self.skeletonSecondLabel.isSkeletonable = true
        self.skeletonThirdLabel.isSkeletonable = true
        
        skeletonImageView.skeletonCornerRadius = 10
        skeletonFirstLabel.skeletonCornerRadius = 10
        skeletonSecondLabel.skeletonCornerRadius = 10
        skeletonThirdLabel.skeletonCornerRadius = 10
        
        skeletonFirstLabel.lastLineFillPercent = 30
        skeletonSecondLabel.lastLineFillPercent = 50
        skeletonThirdLabel.lastLineFillPercent = 70
    }
}
```
