import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orga.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/orga.dart';
import '../../domain/usecases/get_orgas.dart';
import 'orga_event.dart';
import 'orga_state.dart';

///BLOC de organizaciones.
///
///Considera todos los casos de uso de la organización
class OrgaBloc extends Bloc<OrgaEvent, OrgaState> {
  final AddOrga _addOrga;
  final DeleteOrga _deleteOrga;
  final EnableOrga _enableOrga;
  final GetOrga _getOrga;
  final GetOrgas _getOrgas;
  final UpdateOrga _updateOrga;

  OrgaBloc(
    this._addOrga,
    this._deleteOrga,
    this._enableOrga,
    this._getOrga,
    this._getOrgas,
    this._updateOrga,
  ) : super(OrgaStart()) {
    on<OnOrgaLoad>(
      (event, emit) async {
        emit(OrgaLoading());
        final result = await _getOrga.execute(event.id);

        result.fold(
            (l) => emit(OrgaError(l.message)), (r) => {emit(OrgaLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnOrgaListLoad>(
      (event, emit) async {
        emit(OrgaLoading());
        final result = await _getOrgas.execute(
            event.filter, event.fieldOrder, event.pageNumber, 10);

        result.fold((l) => emit(OrgaError(l.message)),
            (r) => {emit(OrgaListLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnOrgaAdd>((event, emit) async {
      emit(OrgaLoading());
      final result =
          await _addOrga.execute(event.name, event.code, event.enabled);

      result.fold(
          (l) => emit(OrgaError(l.message)), (r) => {emit(OrgaStart())});
    });
    on<OnOrgaEdit>((event, emit) async {
      emit(OrgaLoading());

      final orga = Orga(
          id: event.id,
          name: event.name,
          code: event.code,
          enabled: event.enabled,
          builtIn: false);

      final result = await _updateOrga.execute(event.id, orga);
      result.fold(
          (l) => emit(OrgaError(l.message)), (r) => {emit(OrgaStart())});
    });
    on<OnOrgaEnable>((event, emit) async {
      emit(OrgaLoading());

      final result = await _enableOrga.execute(event.id, event.enabled);
      result.fold(
          (l) => emit(OrgaError(l.message)), (r) => {emit(OrgaLoaded(r))});
    });
    on<OnOrgaDelete>((event, emit) async {
      emit(OrgaLoading());

      final result = await _deleteOrga.execute(event.id);
      result.fold(
          (l) => emit(OrgaError(l.message)), (r) => {emit(OrgaStart())});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
