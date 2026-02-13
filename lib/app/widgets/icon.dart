import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

IconData getIcon(String key) {
  switch (key) {
    case 'note':
      return Hi.note;
    case 'chartLineData01':
      return Hi.chartLineData01;
    case 'note01':
      return Hi.note01;
    case 'fileAttachment':
      return Hi.fileAttachment;
    default:
      return Icons.help_outline;
  }
}
