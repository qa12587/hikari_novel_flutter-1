import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

class Migration {
  static Future<void> fromOneToTwo() async {
    //删除不必要的键值对
    if (Hive.isBoxOpen("loginInfo")) {
      final loginInfo = await Hive.openBox("loginInfo");
      loginInfo.delete("username");
      loginInfo.delete("password");
    }

    //删除已缓存的章节。因为数据源不一样，不是该数据源的内容在解析器内会出错
    final dir = await getApplicationSupportDirectory();
    final cacheDir = Directory("${dir.path}/cached_chapter");
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
    }
    //TODO 数据库相关的迁移 1->2
  }
}