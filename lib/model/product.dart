class Product {
  int id;
  int stock;
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
        imageUrl: 'assets/images/cardigan.png',
        title: '[인생 가디건] 봄봄 라운드 연두 가디건',
        content: '가디건입니다.',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        id: 2,
        stock: 5,
        imageUrl: 'assets/images/girl_clothes.png',
        title: '[당일출고🚀/문의폭주] 봄 베이직 원피스',
        content: '맛있는 바나나입니다..',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        id: 3,
        stock: 5,
        imageUrl: 'assets/images/bag.png',
        title: '[봄🌷/파스텔] 봄 가방 데일리룩 ',
        content: '맛있는 오렌지입니다.',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        id: 4,
        stock: 5,
        imageUrl: 'assets/images/flower.png',
        title: '[자체제작] 봄 꽃다발 연인 기념일 100송이 장미 꽃다발',
        content: '맛있는 오렌지입니다.',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        id: 5,
        stock: 5,
        imageUrl: 'assets/images/kids_clothes.png',
        title: '봄 아기옷 꾸안꾸 데일리룩',
        content: '맛있는 오렌지입니다.',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        id: 6,
        stock: 5,
        imageUrl: 'assets/images/one_piece.png',
        title: '[기본템/주문폭주🤍] 엘르 니트 원피스',
        content: '맛있는 오렌지입니다.',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
      Product(
        id: 7,
        stock: 5,
        imageUrl: 'assets/images/book.png',
        title: '[문학] 봄 독서 해리포터',
        content: '맛있는 오렌지입니다.',
        price: 10000,
        rate: 4.5,
        reviewsCount: 0,
        reviewIdList: [],
      ),
    ];
  }
}
