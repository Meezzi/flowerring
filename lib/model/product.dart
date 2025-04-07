class Product {
  final int id;
  final int stock;
  final String imageUrl;
  final String title;
  final String content;
  final int price;
  final double rate;
  final int reviewsCount;
  final List<int> reviewIdList;

  // 생성자
  Product({
    required this.id,
    required this.stock,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.price,
    required this.rate,
    required this.reviewsCount,
    required this.reviewIdList,
  });

  // 상품 데이터를 반환하는 메소드
  static List<Product> getProducts() {
    return [
      Product(
        id: 1,
        stock: 5,
        imageUrl: 'assets/sample.jpg',
        title: '사과',
        content: '맛있는 사과입니다.',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        id: 2,
        stock: 5,
        imageUrl: 'assets/sample.jpg',
        title: '바나나',
        content: '맛있는 바나나입니다..',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        id: 3,
        stock: 5,
        imageUrl: 'assets/sample.jpg',
        title: '오렌지',
        content: '맛있는 오렌지입니다.',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        imageUrl: 'assets/sample.jpg',
        title: '샤인머스켓',
        price: 10000,
        rate: 4.5,
      ),
    ];
  }
}
