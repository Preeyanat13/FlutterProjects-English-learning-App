class FlashCard {
  final String word;
  final String meaning;
  final String? imagePath; // ใส่รูป
  final String category;   // หมวดหมู่

  FlashCard({
    required this.word,
    required this.meaning,
    this.imagePath,
    required this.category,
  });
}

final List<FlashCard> flashCards = [
  // --- ผลไม้ ---
  FlashCard(word: "Apple", meaning: "แอปเปิ้ล", imagePath: "assets/images/apple.png", category: "ผลไม้"),
  FlashCard(word: "Banana", meaning: "กล้วย", imagePath: "assets/images/banana.webp", category: "ผลไม้"),
  FlashCard(word: "Grapes", meaning: "องุ่น", imagePath: "assets/images/grapes.jpg", category: "ผลไม้"),
  FlashCard(word: "Orange", meaning: "ส้ม", imagePath: "assets/images/orange.jpg", category: "ผลไม้"),
  FlashCard(word: "Pineapple", meaning: "สับปะรด", imagePath: "assets/images/pineapple.png", category: "ผลไม้"),
  FlashCard(word: "Strawberry", meaning: "สตรอว์เบอร์รี่", imagePath: "assets/images/strawberry.png", category: "ผลไม้"),
  FlashCard(word: "Mango", meaning: "มะม่วง", imagePath: "assets/images/mango.jpg", category: "ผลไม้"),
  FlashCard(word: "Watermelon", meaning: "แตงโม", imagePath: "assets/images/watermelon.jpg", category: "ผลไม้"),
  FlashCard(word: "Cherry", meaning: "เชอร์รี่", imagePath: "assets/images/cherry.png", category: "ผลไม้"),
  FlashCard(word: "Durian", meaning: "ทุเรียน", imagePath: "assets/images/durian.png", category: "ผลไม้"),

  // --- สัตว์ ---
  FlashCard(word: "Cat", meaning: "แมว", imagePath: "assets/images/cat.png", category: "สัตว์"),
  FlashCard(word: "Dog", meaning: "สุนัข", imagePath: "assets/images/dog.png", category: "สัตว์"),
  FlashCard(word: "Elephant", meaning: "ช้าง", imagePath: "assets/images/elephant.png", category: "สัตว์"),
  FlashCard(word: "Lion", meaning: "สิงโต", imagePath: "assets/images/lion.jpg", category: "สัตว์"),
  FlashCard(word: "Tiger", meaning: "เสือ", imagePath: "assets/images/tiger.png", category: "สัตว์"),
  FlashCard(word: "Monkey", meaning: "ลิง", imagePath: "assets/images/monkey.jpg", category: "สัตว์"),
  FlashCard(word: "Whale", meaning: "ปลาวาฬ", imagePath: "assets/images/whale.png", category: "สัตว์"),
  FlashCard(word: "Bird", meaning: "นก", imagePath: "assets/images/bird.jpg", category: "สัตว์"),
  FlashCard(word: "Rabbit", meaning: "กระต่าย", imagePath: "assets/images/rabbit.jpeg", category: "สัตว์"),
  FlashCard(word: "Horse", meaning: "ม้า", imagePath: "assets/images/horse.png", category: "สัตว์"),

  // --- ของใช้ ---
  FlashCard(word: "Book", meaning: "หนังสือ", imagePath: "assets/images/book.png", category: "ของใช้"),
  FlashCard(word: "Car", meaning: "รถยนต์", imagePath: "assets/images/car.png", category: "ของใช้"),
  FlashCard(word: "Chair", meaning: "เก้าอี้", imagePath: "assets/images/chair.png", category: "ของใช้"),
  FlashCard(word: "Table", meaning: "โต๊ะ", imagePath: "assets/images/table.png", category: "ของใช้"),
  FlashCard(word: "Pen", meaning: "ปากกา", imagePath: "assets/images/pen.jpg", category: "ของใช้"),
  FlashCard(word: "Clock", meaning: "นาฬิกา", imagePath: "assets/images/clock.webp", category: "ของใช้"),
  FlashCard(word: "Bag", meaning: "กระเป๋า", imagePath: "assets/images/bag.png", category: "ของใช้"),
  FlashCard(word: "Phone", meaning: "โทรศัพท์", imagePath: "assets/images/phone.jpg", category: "ของใช้"),
  FlashCard(word: "Laptop", meaning: "แล็ปท็อป", imagePath: "assets/images/laptop.jpg", category: "ของใช้"),
  FlashCard(word: "Camera", meaning: "กล้องถ่ายรูป", imagePath: "assets/images/camera.jpg", category: "ของใช้"),

  // --- สี ---
  FlashCard(word: "Red", meaning: "สีแดง", imagePath: "assets/images/red.jpg", category: "สี"),
  FlashCard(word: "Blue", meaning: "สีน้ำเงิน", imagePath: "assets/images/blue.jpg", category: "สี"),
  FlashCard(word: "Green", meaning: "สีเขียว", imagePath: "assets/images/green.webp", category: "สี"),
  FlashCard(word: "Yellow", meaning: "สีเหลือง", imagePath: "assets/images/yellow.jpg", category: "สี"),
  FlashCard(word: "Black", meaning: "สีดำ", imagePath: "assets/images/Black.png", category: "สี"),
  FlashCard(word: "White", meaning: "สีขาว", imagePath: "assets/images/white.png", category: "สี"),
  FlashCard(word: "Pink", meaning: "สีชมพู", imagePath: "assets/images/pink.jpg", category: "สี"),
  FlashCard(word: "Purple", meaning: "สีม่วง", imagePath: "assets/images/purple.jpg", category: "สี"),
  FlashCard(word: "Orange", meaning: "สีส้ม", imagePath: "assets/images/orange1.webp", category: "สี"),
  FlashCard(word: "Brown", meaning: "สีน้ำตาล", imagePath: "assets/images/brown.jpg", category: "สี"),
  
  // --- ยานพาหนะ ---
  FlashCard(word: "Bus", meaning: "รถบัส", imagePath: "assets/images/bus.png", category: "ยานพาหนะ"),
  FlashCard(word: "Bicycle", meaning: "จักรยาน", imagePath: "assets/images/bicycle.png", category: "ยานพาหนะ"),
  FlashCard(word: "Motorcycle", meaning: "มอเตอร์ไซค์", imagePath: "assets/images/motorcycle.jpeg", category: "ยานพาหนะ"),
  FlashCard(word: "Airplane", meaning: "เครื่องบิน", imagePath: "assets/images/airplane.jpg", category: "ยานพาหนะ"),
  FlashCard(word: "Boat", meaning: "เรือ", imagePath: "assets/images/boat.png", category: "ยานพาหนะ"),
  FlashCard(word: "Train", meaning: "รถไฟ", imagePath: "assets/images/train.jpg", category: "ยานพาหนะ"),
  FlashCard(word: "Truck", meaning: "รถบรรทุก", imagePath: "assets/images/truck.png", category: "ยานพาหนะ"),
  FlashCard(word: "Taxi", meaning: "แท็กซี่", imagePath: "assets/images/taxi.jpg", category: "ยานพาหนะ"),
  FlashCard(word: "Helicopter", meaning: "เฮลิคอปเตอร์", imagePath: "assets/images/helicopter.png", category: "ยานพาหนะ"),
  FlashCard(word: "Subway", meaning: "รถไฟใต้ดิน", imagePath: "assets/images/subway.png", category: "ยานพาหนะ"),
  
  // --- อาชีพ ---
  FlashCard(word: "Doctor", meaning: "หมอ", imagePath: "assets/images/doctor.jpg", category: "อาชีพ"),
  FlashCard(word: "Teacher", meaning: "ครู", imagePath: "assets/images/teacher.jpg", category: "อาชีพ"),
  FlashCard(word: "Engineer", meaning: "วิศวกร", imagePath: "assets/images/engineer.png", category: "อาชีพ"),
  FlashCard(word: "Nurse", meaning: "พยาบาล", imagePath: "assets/images/nurse.png", category: "อาชีพ"),
  FlashCard(word: "Chef", meaning: "เชฟ", imagePath: "assets/images/chef.png", category: "อาชีพ"),
  FlashCard(word: "Police Officer", meaning: "ตำรวจ", imagePath: "assets/images/police_officer.jpg", category: "อาชีพ"),
  FlashCard(word: "Firefighter", meaning: "นักดับเพลิง", imagePath: "assets/images/firefighter.jpg", category: "อาชีพ"),
  FlashCard(word: "Pilot", meaning: "นักบิน", imagePath: "assets/images/pilot.jpg", category: "อาชีพ"),
  FlashCard(word: "Farmer", meaning: "ชาวนา", imagePath: "assets/images/farmer.jpg", category: "อาชีพ"),
  FlashCard(word: "Artist", meaning: "ศิลปิน", imagePath: "assets/images/artist.png", category: "อาชีพ"),

  // --- กีฬา ---
  FlashCard(word: "Football", meaning: "ฟุตบอล", imagePath: "assets/images/football.jpg", category: "กีฬา"),
  FlashCard(word: "Basketball", meaning: "บาสเกตบอล", imagePath: "assets/images/basketball.jpg", category: "กีฬา"),
  FlashCard(word: "Tennis", meaning: "เทนนิส", imagePath: "assets/images/tennis.jpg", category: "กีฬา"),
  FlashCard(word: "Swimming", meaning: "ว่ายน้ำ", imagePath: "assets/images/swimming.jpg", category: "กีฬา"),
  FlashCard(word: "Running", meaning: "วิ่ง", imagePath: "assets/images/running.jpg", category: "กีฬา"),
  FlashCard(word: "Cycling", meaning: "ปั่นจักรยาน", imagePath: "assets/images/cycling.jpeg", category: "กีฬา"),
  FlashCard(word: "Golf", meaning: "กอล์ฟ", imagePath: "assets/images/golf.png", category: "กีฬา"),
  FlashCard(word: "Boxing", meaning: "มวย", imagePath: "assets/images/boxing.jpg", category: "กีฬา"),
  FlashCard(word: "Volleyball", meaning: "วอลเลย์บอล", imagePath: "assets/images/volleyball.jpg", category: "กีฬา"),
  FlashCard(word: "Cricket", meaning: "คริกเก็ต", imagePath: "assets/images/cricket.png", category: "กีฬา"),

  // --- สถานที่ ---
  FlashCard(word: "School", meaning: "โรงเรียน", imagePath: "assets/images/school.png", category: "สถานที่"),
  FlashCard(word: "Hospital", meaning: "โรงพยาบาล", imagePath: "assets/images/hospital.jpg", category: "สถานที่"),
  FlashCard(word: "Library", meaning: "ห้องสมุด", imagePath: "assets/images/library.jpg", category: "สถานที่"),
  FlashCard(word: "Park", meaning: "สวนสาธารณะ", imagePath: "assets/images/park.jpg", category: "สถานที่"),
  FlashCard(word: "Restaurant", meaning: "ร้านอาหาร", imagePath: "assets/images/restaurant.jpg", category: "สถานที่"),
  FlashCard(word: "Airport", meaning: "สนามบิน", imagePath: "assets/images/airport.png", category: "สถานที่"),
  FlashCard(word: "Bank", meaning: "ธนาคาร", imagePath: "assets/images/bank.webp", category: "สถานที่"),
  FlashCard(word: "Museum", meaning: "พิพิธภัณฑ์", imagePath: "assets/images/museum.jpeg", category: "สถานที่"),
  FlashCard(word: "Hotel", meaning: "โรงแรม", imagePath: "assets/images/hotel.jpg", category: "สถานที่"),
  FlashCard(word: "Beach", meaning: "ชายหาด", imagePath: "assets/images/beach.jpg", category: "สถานที่"),
];

 
