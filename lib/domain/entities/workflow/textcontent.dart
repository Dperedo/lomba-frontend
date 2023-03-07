import 'package:equatable/equatable.dart';

class TextContent extends Equatable {
  const TextContent({
    required this.text});

    final String text;

  @override
  
  List<Object?> get props => [
    text
  ];
}
  