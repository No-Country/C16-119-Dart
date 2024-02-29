import 'package:log_print/log_print.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/scanner/domain/domain.dart';
import 'package:table_tap_customer/features/scanner/infrastructure/infrastructure.dart';

part 'tables_provider.g.dart';

@Riverpod(keepAlive: true)
class TablesList extends _$TablesList {
  final TablesRepositoryImpl tablesRepositoryImpl =
      TablesRepositoryImpl(TablesDatasourceImpl());
  @override
  List<Table> build() => [];

  Future loadNextPage() async {
    List<Table> tablesList = await tablesRepositoryImpl.getTablesByPage();

    // if ( state.isLoading || state.isLastPage ) return;
    state = [...state, ...tablesList];

    // final products = await productsRepository.getProductsByPage(
    //     limit: state.limit, offset: state.offset);

    // if ( products.isEmpty ) {
    //   state = state.copyWith(
    //     isLoading: false,
    //     isLastPage: true
    //   );
    //   return;
  }

  Future saveOrder() async {}
  Future fillTable(String idTable) async {
    bool isOccupyTable = await tablesRepositoryImpl.changeStatusTable(idTable, false);
  }
}
