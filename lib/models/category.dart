class Category {
  final String id;
  final String name;
  final String img;
  final String description;

  Category({required this.id, required this.name, required this.img , required this.description});

  factory Category.fromJson(Map<String, dynamic> data){
    return Category(
        id : data['idCategory'],
        name : data['strCategory'],
        img : data['strCategoryThumb'],
        description : data['strCategoryDescription']
    );
  }
}