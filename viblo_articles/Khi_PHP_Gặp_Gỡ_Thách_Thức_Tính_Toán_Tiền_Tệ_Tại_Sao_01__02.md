# Khi PHP Gặp Gỡ Thách Thức Tính Toán Tiền Tệ, Tại Sao 0.1 + 0.2 != 0.3?

### Tổng quan:
Mình cũng đã từng join nhiều dự án về ecommerce và dấn thân vào luồng nghiệp vụ checkout sản phẩm, tính toán hóa đơn cho khách, cũng gặp phải rất nhiều vấn đề sai lệch ảo ma nhìn vào mắt thường thì thật là ảo diệu, không detect được nguyên nhân. 
Xử lý tiền tệ trong lập trình không chỉ là một vấn đề kỹ thuật đơn thuần mà còn là thách thức nghiêm túc có thể gây ra hậu quả tài chính thực tế (Liên quan đến tiền bạc thì phải thật chính xác). 
Vấn đề làm tròn lên, làm tròn xuống và cách làm tròn như thế nào để đảm bảo kết quả chính xác cũng là thứ cần disscuss thật rõ trong quá trình implement.

```
$addResult = 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1;
if($addResult === 1) {
    echo "Bằng nhau";
} else {
    echo "Không bằng nhau";
}
```

Hẹ hẹ, nó không bằng nhau các bạn ạ, tại sao lại như vậy ?

**Hiện Tượng Floating-Point Arithmetic**
Vấn đề được đề cập trong bài viết là một hiện tượng phổ biến trong lập trình máy tính: sự không chính xác của phép tính số thực. 
Khi thực hiện phép tính **0.1 + 0.1 + ... (10 lần)** trong PHP, kết quả không phải là 1.0 mà là **0.9999999999999999**

Nguyên nhân của vấn đề này nằm ở cách máy tính lưu trữ số thực theo chuẩn **IEEE 754**. Máy tính sử dụng hệ nhị phân để biểu diễn số, trong khi con người sử dụng hệ thập phân. 
Nhiều số thập phân đơn giản như 0.1 không thể được biểu diễn chính xác trong hệ nhị phân, dẫn đến sai số tích lũy.

**Tác Động Thực Tế Nghiêm Trọng**

Những sai số nhỏ này có thể gây ra hậu quả nghiêm trọng trong các hệ thống thực tế:

- **Sổ sách kế toán không khớp**: Sai lệch tích lũy có thể làm cho báo cáo tài chính không chính xác
- **Sai số thuế**: Ảnh hưởng trực tiếp đến việc tính toán thuế và các khoản phí
- **Vấn đề tuân thủ**: Vi phạm các quy định tài chính và kế toán
- **Mất lòng tin khách hàng**: Khi hóa đơn hiển thị bị lệch tiền (Ví dụ trong trường hợp mình làm tròn xuống 99.99999 **->** 99 )

Mọi người có thể tham khảo một số bài viết để hiểu hơn về floating point, chắc hồi đại học mọi người cũng có được học rồi ^^, ở bài viết này mình focus vào giải pháp để có thể tránh lỗi khi implement:

[Why is Floating Point Arithmetic a problem in computing?](https://www.geeksforgeeks.org/techtips/gfact-why-is-floating-point-arithmetic-a-problem-in-computing/)

[0.1 + 0.2 = 0.30000...04? - Lập trình viên không nên bỏ qua khái niệm này!](https://viblo.asia/p/01-02-03000004-lap-trinh-vien-khong-nen-bo-qua-khai-niem-nay-3RlL5GBP4bB)

### Lesson learn:
- **Không bao giờ sử dụng float cho tiền tệ**: Luôn sử dụng BCMath, integers (cents), hoặc specialized libraries
- **Sử dụng công cụ hiện đại**: Tận dụng PHP 8.4's BCMath\Number
- **Design for precision và auditability**: Hệ thống tài chính phải có khả năng audit và độ chính xác tuyệt đối
- **Design for Auditability**: Mọi thay đổi về tiền phải có audit trail
- **Test Edge Cases Extensively** Floating-point errors thường xuất hiện ở các trường hợp biên

### Giải Pháp
#### 1. BCMath Extension - Tính Toán Chính Xác Tuyệt Đối

**BCMath** là extension của PHP hỗ trợ tính toán số học với độ chính xác tùy ý, sử dụng chuỗi để biểu diễn và xử lý số.
Thay vì dựa vào biểu diễn nhị phân có thể sai lệch, **BCMath** xử lý trực tiếp trên các ký tự số.

```
$yen = 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1;
$dollar = bcadd($yen, $exRate);
var_dump($dollar)
```

**Ưu điểm của BCMath:**
- **Độ chính xác cao:** Hỗ trợ đến 2,147,483,647 chữ số thập phân
- **Kết quả dự đoán được:** Không có sai số tích lũy
- **Hỗ trợ đầy đủ:** Các phép toán cơ bản và so sánh

**Nhược điểm:**
- **Perfomance thấp hơn:** Chậm hơn so với phép toán thông thường
- **Phức tạp trong sử dụng:** Cần nhớ sử dụng các hàm đặc biệt



#### 2. PHP 8.4 BCMath\Number Class - Cách Tiếp Cận Object-Oriented
PHP 8.4 đã giới thiệu class **BCMath\Number** mới với khả năng operator overloading, cung cấp cú pháp tự nhiên hơn:

- **Operator overloading** là một kỹ thuật trong lập trình hướng đối tượng cho phép chúng ta định nghĩa lại cách các toán tử như **+, -, *, /, ==, <, >** hoạt động với đối tượng thay vì kiểu dữ liệu nguyên thủy như số nguyên, chuỗi,...

Ví dụ tính lãi suất kép với cú pháp tự nhiên:

```
use BCMath\Number;

function calculateCompoundInterest($principal, $rate, $years) {
    $p = new Number($principal);
    $r = new Number($rate);
    $t = new Number($years);
    $one = new Number('1');
    
    // A = P(1 + r)^t
    $amount = $p * ($one + $r) ** $t;
    $interest = $amount - $p;
    
    return [
        'principal' => $p->value,
        'amount' => $amount->value,
        'interest' => $interest->value
    ];
}

$result = calculateCompoundInterest('1000', '0.05', '10');
```


#### 3. So Sánh Số Chính Xác với BCMath
**Floating-point comparison** là nguồn gốc của [nhiều bug tài chính](https://www.geeksforgeeks.org/techtips/gfact-why-is-floating-point-arithmetic-a-problem-in-computing/)

```
// SAI - Floating-point comparison
$calculated = 0.1 + 0.2;
if ($calculated === 0.3) {  // Sẽ trả về false!
    echo "Bằng nhau";
} else {
    echo "Không bằng nhau";  // Kết quả này sẽ được in
}

// ĐÚNG - BCMath comparison
function moneyEquals($amount1, $amount2, $precision = 2) {
    return bccomp($amount1, $amount2, $precision) === 0;
}

if (moneyEquals(bcadd('0.1', '0.2', 2), '0.3')) {
    echo "Bằng nhau";  // Kết quả chính xác
}
```


### Thiết Kế Phần Mềm: Value Objects và Domain-Driven Design

**Primitive Obsession** là anti-pattern phổ biến trong phát triển phần mềm, khi developers lạm dụng các kiểu dữ liệu nguyên thủy để biểu diễn các khái niệm phức tạp. 
Thay vì sử dụng float, string để biểu diễn tiền tệ, chúng ta cần tạo các đối tượng tiền tệ chuyên biệt.

**Value Objects**: Nếu mọi người làm việc trong các dự án theo DDD ( Domain-Driven Design ) thì sẽ gặp keyword này rồi, [đây là pattern trong Domain-Driven Design giúp đóng gói các giá trị và business rules.](https://www.mbrookson.uk/blog/the-value-of-value-objects)

Ví dụ chúng ta có thể triển khai 1 value object Money như sau:
```
class Money {
    private string $amount;
    private string $currency;
    
    public function __construct(string $amount, string $currency) {
        if (!$this->isValidAmount($amount)) {
            throw new InvalidArgumentException('Invalid amount format');
        }
        if (!$this->isValidCurrency($currency)) {
            throw new InvalidArgumentException('Invalid currency code');
        }
        
        $this->amount = $amount;
        $this->currency = $currency;
    }
    
    public function add(Money $other): Money {
        $this->assertSameCurrency($other);
        
        return new Money(
            bcadd($this->amount, $other->amount, 2), 
            $this->currency
        );
    }
    
    public function multiply(string $multiplier): Money {
        return new Money(
            bcmul($this->amount, $multiplier, 2),
            $this->currency
        );
    }
    
    public function equals(Money $other): bool {
        return $this->currency === $other->currency 
            && bccomp($this->amount, $other->amount, 2) === 0;
    }
    
    private function assertSameCurrency(Money $other): void {
        if ($this->currency !== $other->currency) {
            throw new InvalidArgumentException(
                "Cannot operate on different currencies: {$this->currency} vs {$other->currency}"
            );
        }
    }
    
    public function format(): string {
        return number_format((float)$this->amount, 2) . ' ' . $this->currency;
    }
}
```

**Tại sao nên dùng Value Objects:**

**Immutability**: Đối tượng không thể thay đổi sau khi tạo, tránh side effects

**Encapsulation**: Đóng gói business rules và validation logic

**Type Safety**: Ngăn chặn việc nhầm lẫn giữa các loại dữ liệu khác nhau


**Ví Dụ Thực Tế: Implement tính giá sản phẩm bao gồm thuế chính xác**
```
class Product {
    private Money $price;
    private Tax $tax;
    
    public function __construct(Money $price, Tax $tax) {
        $this->price = $price;
        $this->tax = $tax;
    }
    
    public function calculateTotalPrice(): Money {
        $taxAmount = $this->tax->calculateFor($this->price);
        return $this->price->add($taxAmount);
    }
}

class Tax {
    private string $rate;
    
    public function __construct(string $rate) {
        if (bccomp($rate, '0', 4) < 0 || bccomp($rate, '1', 4) > 0) {
            throw new InvalidArgumentException('Tax rate must be between 0 and 1');
        }
        $this->rate = $rate;
    }
    
    public function calculateFor(Money $amount): Money {
        $taxAmount = bcmul($amount->getAmount(), $this->rate, 2);
        return new Money($taxAmount, $amount->getCurrency());
    }
}

$price = new Money('99.99', 'EUR');
$vat = new Tax('0.21');  // 21% VAT
$product = new Product($price, $vat);

$totalPrice = $product->calculateTotalPrice();
echo $totalPrice->format();  // 120.99 EUR
```

### Best Practices Cho Xử Lý Tiền Tệ
#### 1. Database Design
```
-- SỬ DỤNG DECIMAL thay vì FLOAT/DOUBLE
CREATE TABLE transactions (
    id BIGINT PRIMARY KEY,
    amount DECIMAL(15,2) NOT NULL,  -- 15 digits total, 2 after decimal
    currency CHAR(3) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- LƯU TRỮ THEO MINOR UNIT (cents/pence)
CREATE TABLE orders (
    id BIGINT PRIMARY KEY,
    amount_cents INT NOT NULL,  -- Lưu trữ theo cents
    currency CHAR(3) NOT NULL
);
```

#### 3. Nên triển khai validation và Business Rules

```
class Price extends Money
{
    public function __construct(string $amount, string $currency)
    {
        if (bccomp($amount, '0', 2) < 0) {
            throw new InvalidArgumentException('Price cannot be negative');
        }
        
        if (bccomp($amount, '999999.99', 2) > 0) {
            throw new InvalidArgumentException('Price exceeds maximum allowed value');
        }
        
        parent::__construct($amount, $currency);
    }
    
    public function applyDiscount(Percentage $discount): Price
    {
        $discountAmount = bcmul(
            $this->getAmount(), 
            $discount->getValue(), 
            4
        );
        $newAmount = bcsub($this->getAmount(), $discountAmount, 2);
        
        return new Price($newAmount, $this->getCurrency());
    }
}

class Percentage
{
    private string $value;
    
    public function __construct(string $value)
    {
        if (bccomp($value, '0', 4) < 0 || bccomp($value, '1', 4) > 0) {
            throw new InvalidArgumentException('Percentage must be between 0 and 1');
        }
        $this->value = $value;
    }
    
    public function getValue(): string
    {
        return $this->value;
    }
}
```

### Thư Viện và Tools Hỗ Trợ
**Brick/Money Library - Giải Pháp Production-Ready**
[Brick/Money ](https://github.com/brick/money)là một trong những thư viện PHP phổ biến nhất cho xử lý tiền tệ

Sử dụng khá đơn giản:

```
use Brick\Money\Money;
use Brick\Money\Context\CashContext;
use Brick\Money\Context\DefaultContext;

// Tạo Money objects
$price = Money::of(50, 'USD');
$discount = Money::of('12.50', 'USD');

// Tính toán với rounding context
$discountedPrice = $price->minus($discount, new CashContext(5)); // Round to nickel
$withTax = $discountedPrice->multipliedBy('1.08', new DefaultContext());

echo $withTax->formatTo('en_US'); // $40.50
```

### Kết Luận
Xử lý tiền tệ trong PHP đòi hỏi sự hiểu biết sâu sắc về cả kỹ thuật lẫp trình và business domain. Việc sử dụng floating-point arithmetic cho tính toán tài chính không chỉ là lỗi kỹ thuật mà còn có thể dẫn đến hậu quả pháp lý và tài chính nghiêm trọng.
Việc đầu tư thời gian để hiểu và implement đúng cách xử lý tiền tệ sẽ tiết kiệm được rất nhiều trouble và cost trong tương lai, đồng thời tạo ra foundation vững chắc cho các hệ thống tài chính phức tạp.