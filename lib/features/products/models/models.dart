// import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});
}

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String categoryId;
  final String description;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.description,
    required this.rating,
    required this.reviewCount,
  });
}

final List<Category> categories = [
  Category(
    id: '1',
    name: "Men clothing and Fashion",
    image: "assets/images/p1.png",
  ),
  Category(
    id: '2',
    name: "Laptops and Accessories",
    image: "assets/images/p2.png",
  ),
  Category(id: '3', name: "Kids and Toys", image: "assets/images/p3.png"),
  Category(id: '4', name: "Sports", image: "assets/images/p4.png"),
  Category(id: '5', name: "Kitchen", image: "assets/images/p5.png"),
  Category(
    id: '6',
    name: "Books and Stationery",
    image: "assets/images/p6.png",
  ),
  Category(id: '7', name: "Fashion and Beauty", image: "assets/images/p7.png"),
  Category(id: '8', name: "Groceries", image: "assets/images/p8.png"),
  Category(id: '9', name: "Pets", image: "assets/images/p9.png"),
];

final List<Product> products = [
  // Men Clothing and Fashion (6 products)
  Product(
    id: '101',
    name: 'Premium Denim Jeans',
    price: 59.99,
    image: 'assets/images/men_jeans.png',
    categoryId: '1',
    description:
        'Comfortable and stylish premium denim jeans, perfect for casual and semi-formal occasions.',
    rating: 4.2,
    reviewCount: 384,
  ),
  Product(
    id: '102',
    name: 'Classic White Shirt',
    price: 29.99,
    image: 'assets/images/men_shirt.png',
    categoryId: '1',
    description:
        'A timeless classic white shirt made from breathable cotton, suitable for both formal and casual wear.',
    rating: 2.8,
    reviewCount: 1247,
  ),
  Product(
    id: '103',
    name: 'Leather Jacket',
    price: 129.99,
    image: 'assets/images/men_jacket.png',
    categoryId: '1',
    description:
        'Durable and stylish leather jacket designed to elevate your fashion while keeping you warm.',
    rating: 4.0,
    reviewCount: 29,
  ),
  Product(
    id: '104',
    name: 'Casual Sneakers',
    price: 79.99,
    image: 'assets/images/men_sneakers.png',
    categoryId: '1',
    description:
        'Trendy and comfortable sneakers suitable for everyday wear and outdoor activities.',
    rating: 3.9,
    reviewCount: 610,
  ),
  Product(
    id: '105',
    name: 'Formal Suit',
    price: 199.99,
    image: 'assets/images/men_suit.png',
    categoryId: '1',
    description:
        'Elegant formal suit tailored for business events, weddings, and formal gatherings.',
    rating: 4.8,
    reviewCount: 175,
  ),
  Product(
    id: '106',
    name: 'Designer Watch',
    price: 149.99,
    image: 'assets/images/men_watch.png',
    categoryId: '1',
    description:
        'Sleek designer watch with a modern dial and leather strap, adding class to any outfit.',
    rating: 3.1,
    reviewCount: 932,
  ),

  // Laptops and Accessories (6 products)
  Product(
    id: '201',
    name: 'Ultrabook Pro',
    price: 999.99,
    image: 'assets/images/laptop_pro.png',
    categoryId: '2',
    description:
        'Lightweight and powerful ultrabook with high-speed performance for professionals on the go.',
    rating: 4.6,
    reviewCount: 68,
  ),
  Product(
    id: '202',
    name: 'Gaming Laptop',
    price: 1299.99,
    image: 'assets/images/laptop_gaming.png',
    categoryId: '2',
    description:
        'High-performance gaming laptop with powerful GPU and advanced cooling system.',
    rating: 2.5,
    reviewCount: 421,
  ),
  Product(
    id: '203',
    name: 'Wireless Mouse',
    price: 29.99,
    image: 'assets/images/laptop_mouse.png',
    categoryId: '2',
    description:
        'Ergonomic wireless mouse with precision tracking and long battery life.',
    rating: 4.9,
    reviewCount: 203,
  ),
  Product(
    id: '204',
    name: 'Mechanical Keyboard',
    price: 89.99,
    image: 'assets/images/laptop_keyboard.png',
    categoryId: '2',
    description:
        'Durable mechanical keyboard with customizable RGB lighting and tactile feedback.',
    rating: 3.7,
    reviewCount: 756,
  ),
  Product(
    id: '205',
    name: 'Laptop Backpack',
    price: 49.99,
    image: 'assets/images/laptop_bag.png',
    categoryId: '2',
    description:
        'Spacious and durable laptop backpack with multiple compartments for tech gear and accessories.',
    rating: 4.2,
    reviewCount: 47,
  ),
  Product(
    id: '206',
    name: 'USB-C Hub',
    price: 39.99,
    image: 'assets/images/laptop_hub.png',
    categoryId: '2',
    description:
        'Multi-port USB-C hub for connecting all your devices with ease and speed.',
    rating: 3.6,
    reviewCount: 1024,
  ),

  // Kids and Toys (6 products)
  Product(
    id: '301',
    name: 'Building Blocks Set',
    price: 34.99,
    image: 'assets/images/kids_blocks.png',
    categoryId: '3',
    description:
        'Colorful building blocks to encourage creativity and problem-solving skills in children.',
    rating: 2.9,
    reviewCount: 315,
  ),
  Product(
    id: '302',
    name: 'Remote Control Car',
    price: 29.99,
    image: 'assets/images/kids_car.png',
    categoryId: '3',
    description:
        'Fun and fast remote control car with easy controls for endless entertainment.',
    rating: 4.1,
    reviewCount: 89,
  ),
  Product(
    id: '303',
    name: 'Educational Tablet',
    price: 59.99,
    image: 'assets/images/kids_tablet.png',
    categoryId: '3',
    description:
        'Interactive tablet loaded with educational apps and games for kids.',
    rating: 3.8,
    reviewCount: 542,
  ),
  Product(
    id: '304',
    name: 'Plush Teddy Bear',
    price: 19.99,
    image: 'assets/images/kids_bear.png',
    categoryId: '3',
    description:
        'Soft and cuddly teddy bear that makes the perfect bedtime companion.',
    rating: 4.3,
    reviewCount: 128,
  ),
  Product(
    id: '305',
    name: 'Art Supplies Kit',
    price: 24.99,
    image: 'assets/images/kids_art.png',
    categoryId: '3',
    description:
        'Complete art kit with crayons, markers, and more to spark creativity.',
    rating: 2.1,
    reviewCount: 33,
  ),
  Product(
    id: '306',
    name: 'Balance Bike',
    price: 79.99,
    image: 'assets/images/kids_bike.png',
    categoryId: '3',
    description:
        'Sturdy balance bike that helps children learn to ride confidently without training wheels.',
    rating: 4.4,
    reviewCount: 578,
  ),

  // Sports (6 products)
  Product(
    id: '401',
    name: 'Running Shoes',
    price: 89.99,
    image: 'assets/images/sports_shoes.png',
    categoryId: '4',
    description:
        'Lightweight running shoes with great cushioning for all-day comfort and athletic performance.',
    rating: 3.5,
    reviewCount: 211,
  ),
  Product(
    id: '402',
    name: 'Yoga Mat',
    price: 24.99,
    image: 'assets/images/sports_mat.png',
    categoryId: '4',
    description:
        'Non-slip yoga mat with soft texture, ideal for yoga, pilates, and stretching.',
    rating: 5.0,
    reviewCount: 965,
  ),
  Product(
    id: '403',
    name: 'Dumbbell Set',
    price: 49.99,
    image: 'assets/images/sports_dumbbell.png',
    categoryId: '4',
    description:
        'Versatile dumbbell set perfect for home workouts and strength training.',
    rating: 1.9,
    reviewCount: 78,
  ),
  Product(
    id: '404',
    name: 'Basketball',
    price: 19.99,
    image: 'assets/images/sports_ball.png',
    categoryId: '4',
    description:
        'Durable basketball suitable for both indoor and outdoor play.',
    rating: 4.7,
    reviewCount: 156,
  ),
  Product(
    id: '405',
    name: 'Fitness Tracker',
    price: 59.99,
    image: 'assets/images/sports_tracker.png',
    categoryId: '4',
    description:
        'Track your steps, heart rate, and workouts with this stylish fitness tracker.',
    rating: 3.3,
    reviewCount: 1120,
  ),
  Product(
    id: '406',
    name: 'Tennis Racket',
    price: 79.99,
    image: 'assets/images/sports_racket.png',
    categoryId: '4',
    description:
        'Lightweight and balanced tennis racket for players of all skill levels.',
    rating: 4.5,
    reviewCount: 341,
  ),

  // Kitchen (6 products)
  Product(
    id: '501',
    name: 'Non-Stick Pan Set',
    price: 89.99,
    image: 'assets/images/kitchen_pan.png',
    categoryId: '5',
    description:
        'High-quality non-stick pan set for effortless cooking and easy cleanup.',
    rating: 1.5,
    reviewCount: 94,
  ),
  Product(
    id: '502',
    name: 'Electric Blender',
    price: 49.99,
    image: 'assets/images/kitchen_blender.png',
    categoryId: '5',
    description: 'Powerful electric blender for smoothies, soups, and more.',
    rating: 4.9,
    reviewCount: 703,
  ),
  Product(
    id: '503',
    name: 'Knife Set',
    price: 69.99,
    image: 'assets/images/kitchen_knife.png',
    categoryId: '5',
    description:
        'Sharp and durable knife set with ergonomic handles for all kitchen tasks.',
    rating: 3.2,
    reviewCount: 267,
  ),
  Product(
    id: '504',
    name: 'Food Storage Containers',
    price: 29.99,
    image: 'assets/images/kitchen_container.png',
    categoryId: '5',
    description:
        'Airtight food containers to keep your leftovers fresh and organized.',
    rating: 4.8,
    reviewCount: 498,
  ),
  Product(
    id: '505',
    name: 'Coffee Maker',
    price: 59.99,
    image: 'assets/images/kitchen_coffee.png',
    categoryId: '5',
    description:
        'Brew your perfect cup every time with this easy-to-use coffee maker.',
    rating: 2.4,
    reviewCount: 52,
  ),
  Product(
    id: '506',
    name: 'Air Fryer',
    price: 99.99,
    image: 'assets/images/kitchen_fryer.png',
    categoryId: '5',
    description:
        'Healthy cooking made easy with this compact and efficient air fryer.',
    rating: 3.0,
    reviewCount: 857,
  ),

  // Books and Stationery (6 products)
  Product(
    id: '601',
    name: 'Notebook Set',
    price: 14.99,
    image: 'assets/images/book_notebook.png',
    categoryId: '6',
    description:
        'Set of premium notebooks with smooth pages, ideal for school, office, or journaling.',
    rating: 4.8,
    reviewCount: 217,
  ),
  Product(
    id: '602',
    name: 'Ballpoint Pen Pack',
    price: 9.99,
    image: 'assets/images/book_pen.png',
    categoryId: '6',
    description:
        'Pack of smooth-writing ballpoint pens with comfortable grips and vibrant ink.',
    rating: 4.3,
    reviewCount: 212,
  ),
  Product(
    id: '603',
    name: 'Desk Organizer',
    price: 19.99,
    image: 'assets/images/book_organizer.png',
    categoryId: '6',
    description:
        'Multi-compartment desk organizer to keep your stationery tidy and accessible.',
    rating: 4,
    reviewCount: 17,
  ),
  Product(
    id: '604',
    name: 'Highlighter Set',
    price: 7.99,
    image: 'assets/images/book_highlighter.png',
    categoryId: '6',
    description:
        'Bright highlighters in assorted colors for effective studying and note-taking.',
    rating: 4.6,
    reviewCount: 35,
  ),
  Product(
    id: '605',
    name: 'Sticky Notes Variety Pack',
    price: 6.99,
    image: 'assets/images/book_sticky.png',
    categoryId: '6',
    description:
        'Colorful sticky notes in various sizes, perfect for reminders and bookmarks.',
    rating: 4.5,
    reviewCount: 57,
  ),
  Product(
    id: '606',
    name: 'Backpack for Students',
    price: 39.99,
    image: 'assets/images/book_bag.png',
    categoryId: '6',
    description:
        'Durable and spacious backpack designed for students, with padded laptop compartment and organizers.',
    rating: 4.4,
    reviewCount: 112,
  ),

  // Fashion and Beauty (6 products)
  Product(
    id: '701',
    name: 'Perfume Set',
    price: 59.99,
    image: 'assets/images/beauty_perfume.png',
    categoryId: '7',
    description:
        'A luxurious collection of fragrances, perfect for any occasion. This perfume set includes a variety of scents to complement your unique style, leaving a lasting impression wherever you go.',
    rating: 3.8,
    reviewCount: 6,
  ),
  Product(
    id: '702',
    name: 'Makeup Palette',
    price: 34.99,
    image: 'assets/images/beauty_palette.png',
    categoryId: '7',
    description:
        'Unleash your creativity with this vibrant makeup palette. Packed with a wide range of shades for eyes, lips, and cheeks, it\'s the ultimate tool for achieving a bold, glamorous look.',
    rating: 4.1,
    reviewCount: 88,
  ),
  Product(
    id: '703',
    name: 'Skincare Kit',
    price: 49.99,
    image: 'assets/images/beauty_skincare.png',
    categoryId: '7',
    description:
        'Nourish and rejuvenate your skin with this comprehensive skincare kit. Designed to cleanse, moisturize, and protect, it\'s perfect for maintaining healthy, radiant skin every day.',
    rating: 4.4,
    reviewCount: 255,
  ),
  Product(
    id: '704',
    name: 'Hair Dryer',
    price: 39.99,
    image: 'assets/images/beauty_dryer.png',
    categoryId: '7',
    description:
        'Dry your hair quickly and efficiently with this professional-grade hair dryer. Equipped with multiple settings and a powerful motor, it ensures a smooth, shiny finish every time.',
    rating: 4.7,
    reviewCount: 163,
  ),
  Product(
    id: '705',
    name: 'Designer Handbag',
    price: 199.99,
    image: 'assets/images/beauty_bag.png',
    categoryId: '7',
    description:
        'Elevate your style with this elegant designer handbag. Crafted from high-quality materials, it offers both functionality and sophistication, making it the perfect accessory for any outfit.',
    rating: 4.2,
    reviewCount: 12,
  ),
  Product(
    id: '706',
    name: 'Silk Scarf',
    price: 29.99,
    image: 'assets/images/beauty_scarf.png',
    categoryId: '7',
    description:
        'Add a touch of luxury to your wardrobe with this exquisite silk scarf. Soft and smooth, it’s perfect for any season and can be styled in a variety of ways to complement your look.',
    rating: 3.8,
    reviewCount: 25,
  ),

  // Groceries (6 products)
  Product(
    id: '801',
    name: 'Organic Coffee',
    price: 12.99,
    image: 'assets/images/grocery_coffee.png',
    categoryId: '8',
    description:
        'Start your day with a rich, flavorful cup of organic coffee. Sourced from the finest beans, it offers a smooth, full-bodied taste with every brew.',
    rating: 4.3,
    reviewCount: 404,
  ),
  Product(
    id: '802',
    name: 'Extra Virgin Olive Oil',
    price: 14.99,
    image: 'assets/images/grocery_oil.png',
    categoryId: '8',
    description:
        'Enhance the flavor of your meals with this high-quality extra virgin olive oil. Cold-pressed and rich in antioxidants, it\'s perfect for cooking, dressings, or drizzling over dishes.',
    rating: 4.4,
    reviewCount: 512,
  ),
  Product(
    id: '803',
    name: 'Honey Jar',
    price: 8.99,
    image: 'assets/images/grocery_honey.png',
    categoryId: '8',
    description:
        'Sweeten your day with pure, natural honey. This jar of honey is sourced from local beekeepers and is perfect for adding to teas, baking, or enjoying straight from the spoon.',
    rating: 4.5,
    reviewCount: 189,
  ),
  Product(
    id: '804',
    name: 'Pasta Pack',
    price: 3.99,
    image: 'assets/images/grocery_pasta.png',
    categoryId: '8',
    description:
        'A pantry staple for pasta lovers. This pack of high-quality pasta is perfect for quick and easy meals, whether you\'re making spaghetti, penne, or your favorite pasta dish.',
    rating: 4.3,
    reviewCount: 323,
  ),
  Product(
    id: '805',
    name: 'Granola Bars',
    price: 5.99,
    image: 'assets/images/grocery_granola.png',
    categoryId: '8',
    description:
        'Packed with wholesome ingredients, these granola bars are a healthy and delicious snack. Perfect for on-the-go, they offer a satisfying mix of oats, nuts, and fruit.',
    rating: 4,
    reviewCount: 59,
  ),
  Product(
    id: '806',
    name: 'Almond Milk',
    price: 4.99,
    image: 'assets/images/grocery_milk.png',
    categoryId: '8',
    description:
        'A dairy-free alternative to traditional milk, almond milk is smooth, creamy, and perfect for coffee, baking, or simply enjoying in a glass. A nutritious and vegan-friendly option.',
    rating: 4.4,
    reviewCount: 83,
  ),

  // Pets (6 products)
  Product(
    id: '901',
    name: 'Dog Food',
    price: 24.99,
    image: 'assets/images/pet_dogfood.png',
    categoryId: '9',
    description:
        'Keep your furry friend healthy and happy with this premium dog food. Packed with essential nutrients and vitamins, it supports overall well-being and provides a balanced diet.',
    rating: 4.6,
    reviewCount: 550,
  ),
  Product(
    id: '902',
    name: 'Cat Tree',
    price: 59.99,
    image: 'assets/images/pet_tree.png',
    categoryId: '9',
    description:
        'Give your cat the perfect playground with this multi-level cat tree. With plenty of scratching posts, cozy hideaways, and perches, it’s ideal for your feline friend to climb and relax.',
    rating: 3.5,
    reviewCount: 22,
  ),
  Product(
    id: '903',
    name: 'Pet Bed',
    price: 39.99,
    image: 'assets/images/pet_bed.png',
    categoryId: '9',
    description:
        'Provide your pet with a comfortable and cozy place to rest. This soft pet bed is designed for ultimate comfort, giving your pet a peaceful and supportive sleep every night.',
    rating: 4.2,
    reviewCount: 53,
  ),
  Product(
    id: '904',
    name: 'Aquarium Kit',
    price: 89.99,
    image: 'assets/images/pet_aquarium.png',
    categoryId: '9',
    description:
        'Create a serene underwater world for your fish with this complete aquarium kit. It includes everything you need to set up and maintain a healthy aquatic environment for your pets.',
    rating: 4.0,
    reviewCount: 6,
  ),
  Product(
    id: '905',
    name: 'Chew Toys',
    price: 14.99,
    image: 'assets/images/pet_toys.png',
    categoryId: '9',
    description:
        'Keep your pet entertained and active with these durable chew toys. Perfect for dogs of all sizes, they help promote dental health while providing hours of fun.',
    rating: 4.6,
    reviewCount: 312,
  ),
  Product(
    id: '906',
    name: 'Grooming Kit',
    price: 29.99,
    image: 'assets/images/pet_grooming.png',
    categoryId: '9',
    description:
        'Maintain your pet\'s coat with this essential grooming kit. It includes everything you need for brushing, trimming, and cleaning, ensuring your pet always looks their best.',
    rating: 4.3,
    reviewCount: 217,
  ),
];
