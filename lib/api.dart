import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: HttpLink(uri: 'http://localhost:4000'),
  ),
);

final String getTasksQuery = """
query {
  get_users {
    firstName,
    lastName,
    experience
  }
}
""";
