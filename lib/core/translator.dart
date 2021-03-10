import 'package:get/get.dart';

class Translator extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'all': 'All',
          'complete': 'Complete',
          'incomplete': 'Incomplete',
          'no_data': 'No data',
          'dismiss': 'Dismiss',
          'cancel': 'Cancel',
          'error': 'Error',
          'add_new_todo': 'Add new to-do',
          'delete': 'Delete',
          'error_empty_todo': 'Description cannot be null',
        },
        'vi_VN': {
          'all': 'Tất cả',
          'complete': 'Hoàn thành',
          'incomplete': 'Chưa hoàn thành',
          'dismiss': 'Bỏ qua',
          'cancel': 'Hủy',
          'error': 'Lỗi',
          'add_new_todo': 'Thêm to-do mới',
          'delete': 'Xóa',
          'error_empty_todo': 'Không thể để trống nội dung',
        }
      };
}
