# RxCalculator

Rxswift練習 - 計算機

## Usage
cocoapod
```
pod install
```
## TODO
### UnitTest實作
還沒做

### 邏輯錯誤
輸入0.03 目前寫法輸入第二個0時會誤判為0，最後會判斷為3
需要例外處理，或者改寫法，未來有空再來改

### 邏輯錯誤
3+7= 10 按下= 計算出10。 再按+/- ，期望會出現-10，但因為已經計算過，currentNumber = 0，所以出現的結果會是0。 

### Layout
目前是固定大小，但只是練習而已，應該不會想改了


