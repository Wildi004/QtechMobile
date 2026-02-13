import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';

class Pickers {
  static void image({Function(XFile?)? then}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      then?.call(pickedFile);
    } catch (e, s) {
      Errors.check(e, s);
      then?.call(null);
    }
  }
}
