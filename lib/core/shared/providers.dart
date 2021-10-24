import 'package:flutter_playground/core/infrastructure/sembast_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sembastProvider=Provider((ref) => SembastDatabase());