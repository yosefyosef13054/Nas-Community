import 'package:equatable/equatable.dart';
import 'package:flutter_contentful/client.dart';
import 'package:flutter_contentful/models/entry.dart';
import 'package:flutter_contentful/models/system_fields.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';

class EventRepository {
  EventRepository(this.contentful);
  final Client contentful;

  Future<List<Item>> findBySlug(String slug) async {
    final collection = await contentful.getEntries({
      'content_type': 'communityProductPage',
      'fields.slug': slug,
    }, Item.fromJson);
    return collection.items;
  }

  // Future<void> getData(slug) async {
  //   final repo = EventRepository(Client(
  //     BearerTokenHTTPClient('WabJrLMKPY2Gkwm1ha9XYV8sd6ZZiM_HDc8Xa2gZ7dY'),
  //     spaceId: 'yv8ba1cqjg8q',
  //   ));

  //   try {
  //     final event = await repo.findBySlug(slug);
  //     // print('Titletttttttt: ${event.fields!.title}');
  //   } catch (e) {
  //     print('erooooor' + e.toString());
  //   }
  // }
}

class Event extends Entry<EventFields> {
  Event({
    required SystemFields sys,
    required EventFields? fields,
  }) : super(
          sys: sys,
        );

  static Event fromJson(Map<String, dynamic> data) {
    return Event(
      sys: SystemFields.fromJson(data["sys"]),
      fields: EventFields.fromJson(data["fields"] ??
          const EventFields(relations: null, slug: '', title: 'test')),
    );
  }
}

@JsonSerializable()
class EventFields extends Equatable {
  const EventFields({
    required this.title,
    required this.slug,
    required this.relations,
  }) : super();

  final String? title;
  final String? slug;
  final List<Event>? relations;

  static EventFields fromJson(Map<String, dynamic> data) {
    return EventFields(
      title: data["title"],
      slug: data["slug"],
      relations: data["relations"] == null
          ? []
          : List.from(data["relations"] ?? [])
              .map((e) => Event.fromJson(e))
              .toList(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
