import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PostItem extends Equatable {
  const PostItem({
    required this.order,
    required this.content,
    required this.type,
    required this.format,
    required this.builtIn,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.expires,});

    
    final int order;
    final Object content;
    final Text type;
    final String format;
    final bool builtIn;
    final DateTime created;
    final DateTime? updated;
    final DateTime? deleted;
    final DateTime? expires;
    

  @override
  
  List<Object?> get props => [
     builtIn,created,order,content,type,format
  ];
}