import 'package:super_app/features/chat/common/entities/entities.dart';
import 'package:get/get.dart';

class ContactState {
  var count = 0.obs;
  RxList<ContactItem> contactList = <ContactItem>[].obs;
}
