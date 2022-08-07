import 'package:get/get.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US':{
      'popular' : 'Popular',
      'lasted' : 'Lasted',
    },
    'th_TH':{
      'popular' : 'ข่าวฮิต',
      'lasted' : 'ล่าสุด',
    },
  };
}
