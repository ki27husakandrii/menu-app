import '../../domain/entities/ingredient.dart';
import '../../domain/entities/menu_item.dart';

const String kCatBurgers = 'Бургери та Гриль';
const String kCatPizza = 'Піца';
const String kCatSalads = 'Салати';
const String kCatDesserts = 'Десерти';
const String kCatDrinks = 'Напої';

const String _burgerImage =
    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd';
const String _cheeseburgerImage =
    'https://images.unsplash.com/photo-1553979459-d2229ba7433b';
const String _margheritaImage =
    'https://images.unsplash.com/photo-1513104890138-7c749659a591';
const String _pepperoniImage =
    'https://images.unsplash.com/photo-1621538997517-58ce53933faa';
const String _cheesecakeImage =
    'https://images.unsplash.com/photo-1588291258143-d31a5dfe6c30';
const String _caesarImage =
    'https://cdn.pixabay.com/photo/2014/01/17/08/56/caesar-246818_1280.jpg';
const String _greekImage =
    'https://cdn.pixabay.com/photo/2017/03/25/10/21/salad-2173214_1280.jpg';
const String _tiramisuImage =
    'https://cdn.pixabay.com/photo/2020/09/18/13/18/tiramisu-5581806_1280.jpg';
const String _lemonadeImage =
    'https://cdn.pixabay.com/photo/2022/10/06/14/02/lemon-juice-7502776_1280.jpg';

const List<MenuItem> kMenuSeed = [
  MenuItem(
    id: 'burger-truffle',
    name: 'Бургер "Трюфельний Крафт"',
    category: kCatBurgers,
    price: 265,
    minutes: 20,
    rating: 4.9,
    reviews: 124,
    imageUrl: _burgerImage,
    ingredients: [
      Ingredient('Яловичина (Black Angus)', 180, IngredientKind.meat),
      Ingredient('Булочка бріош з кунжутом', 80, IngredientKind.bread),
      Ingredient('Сир Чеддер витриманий', 40, IngredientKind.dairy),
      Ingredient('Карамелізована цибуля', 30, IngredientKind.vegetable),
      Ingredient('Фірмовий трюфельний соус', 25, IngredientKind.sauce),
    ],
  ),
  MenuItem(
    id: 'burger-classic',
    name: 'Чізбургер Класичний',
    category: kCatBurgers,
    price: 189,
    minutes: 15,
    rating: 4.7,
    reviews: 98,
    imageUrl: _cheeseburgerImage,
    ingredients: [
      Ingredient('Яловичина', 150, IngredientKind.meat),
      Ingredient('Булочка з кунжутом', 70, IngredientKind.bread),
      Ingredient('Сир Чеддер', 30, IngredientKind.dairy),
      Ingredient('Мариновані огірки', 20, IngredientKind.vegetable),
      Ingredient('Фірмовий соус', 20, IngredientKind.sauce),
    ],
  ),
  MenuItem(
    id: 'pizza-margherita',
    name: 'Піца Маргарита',
    category: kCatPizza,
    price: 210,
    minutes: 18,
    rating: 4.8,
    reviews: 156,
    imageUrl: _margheritaImage,
    ingredients: [
      Ingredient('Тісто', 220, IngredientKind.bread),
      Ingredient('Томатний соус', 80, IngredientKind.sauce),
      Ingredient('Моцарела', 120, IngredientKind.dairy),
      Ingredient('Свіжий базилік', 10, IngredientKind.vegetable),
    ],
  ),
  MenuItem(
    id: 'pizza-pepperoni',
    name: 'Піца Пепероні',
    category: kCatPizza,
    price: 235,
    minutes: 18,
    rating: 4.8,
    reviews: 187,
    imageUrl: _pepperoniImage,
    ingredients: [
      Ingredient('Тісто', 220, IngredientKind.bread),
      Ingredient('Томатний соус', 80, IngredientKind.sauce),
      Ingredient('Моцарела', 110, IngredientKind.dairy),
      Ingredient('Салямі пепероні', 70, IngredientKind.meat),
    ],
  ),
  MenuItem(
    id: 'salad-caesar',
    name: 'Салат Цезар з куркою',
    category: kCatSalads,
    price: 175,
    minutes: 10,
    rating: 4.6,
    reviews: 74,
    imageUrl: _caesarImage,
    ingredients: [
      Ingredient('Куряче філе', 100, IngredientKind.meat),
      Ingredient('Салат ромен', 80, IngredientKind.vegetable),
      Ingredient('Пармезан', 20, IngredientKind.dairy),
      Ingredient('Сухарики', 25, IngredientKind.bread),
      Ingredient('Соус Цезар', 30, IngredientKind.sauce),
    ],
  ),
  MenuItem(
    id: 'salad-greek',
    name: 'Грецький салат',
    category: kCatSalads,
    price: 150,
    minutes: 8,
    rating: 4.5,
    reviews: 61,
    imageUrl: _greekImage,
    ingredients: [
      Ingredient('Помідори', 90, IngredientKind.vegetable),
      Ingredient('Огірки', 80, IngredientKind.vegetable),
      Ingredient('Сир фета', 50, IngredientKind.dairy),
      Ingredient('Оливки', 30, IngredientKind.vegetable),
      Ingredient('Оливкова олія', 15, IngredientKind.sauce),
    ],
  ),
  MenuItem(
    id: 'dessert-cheesecake',
    name: 'Чізкейк Нью-Йорк',
    category: kCatDesserts,
    price: 130,
    minutes: 5,
    rating: 4.9,
    reviews: 203,
    imageUrl: _cheesecakeImage,
    ingredients: [
      Ingredient('Вершковий сир', 120, IngredientKind.dairy),
      Ingredient('Основа з печива', 50, IngredientKind.bread),
      Ingredient('Ягідний соус', 30, IngredientKind.dessert),
    ],
  ),
  MenuItem(
    id: 'dessert-tiramisu',
    name: 'Тірамісу',
    category: kCatDesserts,
    price: 140,
    minutes: 5,
    rating: 4.8,
    reviews: 167,
    imageUrl: _tiramisuImage,
    ingredients: [
      Ingredient('Маскарпоне', 90, IngredientKind.dairy),
      Ingredient('Савоярді', 40, IngredientKind.bread),
      Ingredient('Еспресо', 30, IngredientKind.drink),
      Ingredient('Какао', 5, IngredientKind.dessert),
    ],
  ),
  MenuItem(
    id: 'drink-lemonade',
    name: 'Домашній лимонад',
    category: kCatDrinks,
    price: 65,
    minutes: 3,
    rating: 4.7,
    reviews: 89,
    imageUrl: _lemonadeImage,
    ingredients: [
      Ingredient('Лимони', 60, IngredientKind.vegetable),
      Ingredient('М\'ята', 5, IngredientKind.vegetable),
      Ingredient('Содова', 300, IngredientKind.drink),
      Ingredient('Цукровий сироп', 20, IngredientKind.sauce),
    ],
  ),
];
