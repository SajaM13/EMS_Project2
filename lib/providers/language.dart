bool isEng = true;

String getlang(String s) {
  if (isEng)
    return Englishlan[s]!;
  else {
    return Arabiclan[s]!;
  }
}

Map<String, String> Arabiclan = {
  //////// sign up
  'user name': 'اسم المستخدم',
  'email': 'البريد الإلكتروني',
  'password': 'كلمة المرور',
  'phone number': 'رقم الهاتف',
  'done': 'تم',
  'already have an account ?': 'لديك حساب بالفعل؟',
  'login': 'تسجيل الدخول',
  'login as guest': 'تسجيل الدخول كزائر',
  'dont have an account ?': 'لاتملكك حساب ؟',

  ////////// login
  // 'email': 'البريد الإلكتروني',
  // 'password': 'كلمة المرور',

  ///////// home-halls
  'home': 'الرئيسية',
  'halls': 'صالات',

  ///////// home-food
  'food list': 'قائمة الطعام',
  'food': 'الطعام',
  'Search': 'البحث',

  ///////// home-camerawoman
  'media': 'التصوير',
  'contact number': 'معلومات التواصل',

  ///////// home-points
  'delete item': 'حذف عنصر',
  'edit item': 'تعديل عنصر',

  ///////// add food
  'image not selected yet': 'لم يتم اختيار الصورة بعد',
  'food name': 'اسم الاكلة',
  'description': 'الوصف',
  'price': 'السعر',
  'add': 'إضافة',
  // 'done': 'تم',
  'are you sure you want to delete data': ' هل انت متاكد من حذف البيانات',
  'Yes': 'نعم',
  'No': 'لا',
// 'res' : 'حجوزات',
// 'off' : "العروض",
// 'num'
  ///////// add photographer
  'name': 'الاسم',

  'contact info': 'السعر',
  'add photographer name': 'ادخل اسم المصور',
  'add photographer description': 'ادخل وصف المصور',
  'add photographer contact info': 'ادخل هاتف المصور',

///////////// index offers
  'END OF SEASON': 'نهاية الموسم',
  'Description': 'الوصف',
  'Offer Name': 'اسم العرض',
  'Offer Value': 'قيمة العرض',
  'Offer Start Date': 'تاريخ بداية العرض',
  'Offer End Date': 'تاريخ نهاية العرض',

/////////////add offer
  'OoOffers': 'العروض',
  'Start Date': 'تاريخ البداية',
  'End Date': 'تاريخ النهاية',

//////////informatiom halls
  'LOCATION': 'الموقع',
  'TO CONNECT': 'رقم الاتصال',
  'Min HALL CAPACITY': 'سعة الصالة الأصغرية',
  'Max HALL CAPACITY': 'سعة الصالة الأكبرية',
  'PRICE PER CHAIR': 'سعر الكرسي الواحد',
  'Rating': 'التقيم',
  'To find out what days are available for reservations':
      'معرفة الأيام المتوافرة للحجز',
  'offers': 'العروض',
  'Calender': 'التقويم',
  'Today': 'اليوم',

//////////update info halls

  'The location of the hall': 'موقع الصالة',
  'UPDATE': 'تعديل',

//////////// add book
  'BOOK NOW!!!': 'احجز الآن',
  'User Name': ' اسم المستخدم',
  // 'phone number': ' رقم الهاتف',
  'Event Type': 'نوع المناسبة',
  'Number of chairs': 'عدد الكراسي',
  'Number of photo_film': 'عدد أفلام الصور',
  'Not That one photo_film consists of 150 photo':
      'ملاحظة يحوي الفيلم الواحد 150 صورة',
  'Number of video_film': ' عددأفلام الفيديو',
  'Note That one video_film consists of 8 videos':
      'ملاحظة يحوي الفيلم الواحد 8 فيديوهات',
  'Click here to pick a date': 'انقر هنا لاختيار التاريخ',
  'Choose reservation time': 'اختيار وقت الحجز',
  'Note That:Reservation Canceled Automatically After 3 Days':
      'لاحظ أنه يتم إلغاء الحجز تلقائيا بعد ثلاثة أيام ',
  'Choose Food': 'اختيار الطعام',
  'Choose photographer': 'اختيار المصور',
  'Save Book': 'حفظ الحجز',
  'Manage Reservations': 'إدارة الحجز',
  'Reservation Date': 'تاريخ الحجز',
  'Accept': 'القبول',
  'Delete': 'الحذف',

///////////drawer
  'reservations': 'الحجوزات',
  'accepted reservations': 'الحجوزات المقبولة',
  'Offers': 'العروض',
  'Complaint numbers': 'أرقام الشكوى',
  'Language': 'اللغة',
  'LogOut': 'تسجيل الخروج',
  'ar': "العربية",
  'en': "الإنكليزية"

//////
};
Map<String, String> Englishlan = {
  //////// sign up
  'user name': 'user name',
  'email': 'email',
  'password': 'password',
  'phone number': 'phone number',
  'done': 'done',
  'already have an account ?': 'already have an account ?',
  'login': 'login',
  'login as guest': 'login as guest',
  'dont have an account ?': 'dont have an account ?',

  ////////// login
  // 'email': 'email',
  // 'password': 'password',

  ///////// home-halls
  'home': 'home',
  'halls': 'halls',

  ///////// home-food
  'food list': 'food list',
  'food': 'food',
  'Search': 'Search',

  ///////// home-camerawoman
  'media': 'media',
  'contact number': 'contact number',

  ///////// home-points
  'delete item': 'delete item',
  'edit item': 'edit item',

  ///////// add food
  'image not selected yet': 'image not selected yet',
  'food name': 'food name',
  'description': 'description',
  'price': 'price',
  'add': 'add',
  // 'done': 'done',
  'are you sure you want to delete data':
      'are you sure you want to delete data',
  'Yes': 'Yes',
  'No': 'No',
  'ar': "Arabic",
  'en': "English",
  ///////// add photographer
  'name': 'name',
  // 'description': 'description',
  'contact info': 'contact info',
  'add photographer name': 'add photographer name',
  'add photographer description': 'add photographer description',
  'add photographer contact info': 'add photographer contact info',
  // 'add': 'add',
  // 'done': 'done',/

///////////// index offers
  'END OF SEASON': 'END OF SEASON',
  'Description': 'Description',
  'Offer Name': 'Offer Name',
  'Offer Value': 'Offer Value',
  'Offer Start Date': 'Offer Start Date',
  'Offer End Date': 'Offer End Date',

/////////////add offer
  'OoOffers': 'OoOffers',
  'Start Date': 'Start Date',
  'End Date': 'End Date',

//////////informatiom halls
  'LOCATION': 'LOCATION',
  'TO CONNECT': 'TO CONNECT',
  'Min HALL CAPACITY': 'Min HALL CAPACITY',
  'Max HALL CAPACITY': 'Max HALL CAPACITY',
  'PRICE PER CHAIR': 'PRICE PER CHAIR',
  'Rating': 'Rating',
  'To find out what days are available for reservations':
      'To find out what days are available for reservations',
  'offers': 'offers',
  'Calender': 'Calender',
  'Today': 'Today',

//////////update info halls

  'The location of the hall': 'The location of the hall',
  'UPDATE': 'UPDATE',

//////////// add book
  'BOOK NOW!!!': 'BOOK NOW!!!',
  'User Name': 'User Name',
  // 'phone number': 'phone number',
  'Event Type': 'Event Type',
  'Number of chairs': 'Number of chairs',
  'Number of photo_film': 'Number of photo_film',
  'Not That one photo_film consists of 150 photo':
      'Not That one photo_film consists of 150 photo',
  'Number of video_film': ' Number of video_film',
  'Note That one video_film consists of 8 videos':
      'Note That one video_film consists of 8 videos',
  'Click here to pick a date': 'Click here to pick a date',
  'Choose reservation time': 'Choose reservation time',
  'Note That:Reservation Canceled Automatically After 3 Days':
      'Note That:Reservation Canceled Automatically After 3 Days',
  'Choose Food': 'Choose Food',
  'Choose photographer': 'Choose photographer',
  'Save Book': 'Save Book',
  'Manage Reservations': 'Manage Reservations',
  'Reservation Date': 'Reservation Date',
  'Accept': 'Accept',
  'Delete': 'Delete',

///////////drawer
  'reservations': 'reservations',
  'accepted reservations': 'Accepted reservations',
  'Offers': 'Offers',
  'Complaint numbers': 'Complaint numbers',
  'Language': 'Language',
  'LogOut': 'LogOut',
};
