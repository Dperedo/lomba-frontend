import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/orgas/add_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/delete_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/enable_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/exists_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/update_orga.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/orga.dart';
import '../../../domain/usecases/orgas/get_orgas.dart';
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
  final ExistsOrga _existsOrga;
  final UpdateOrga _updateOrga;

  OrgaBloc(
    this._addOrga,
    this._deleteOrga,
    this._enableOrga,
    this._getOrga,
    this._getOrgas,
    this._updateOrga,
    this._existsOrga,
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
    on<OnOrgaPrepareForAdd>((event, emit) async {
      emit(OrgaAdding(false, false));
    });
    on<OnOrgaPrepareForEdit>((event, emit) async {
      emit(OrgaEditing(event.orga, false));
    });
    on<OnOrgaValidate>((event, emit) async {
      String orgaNoId = '';
      if (event.code != "") {
        final result = await _existsOrga.execute(orgaNoId, event.code);

        result.fold((l) => emit(OrgaError(l.message)), (r) {
          if (r != null) {
            event.state.existCode = (r.code == event.code);
          } else {
            event.state.existCode = false;
          }
        });
      }
    });
    on<OnOrgaValidateEdit>((event, emit) async {
      String orgaNoId = '';
      if (event.code != "") {
        final result = await _existsOrga.execute(orgaNoId, event.code);

        result.fold((l) => emit(OrgaError(l.message)), (r) {
          if (r != null) {
            event.state.existCode = (r.code == event.code);
          } else {
            event.state.existCode = false;
          }
        });
      }
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
    on<OnOrgaShowAddOrgaForm>((event, emit) async {
      emit(OrgaLoading());
    });
    on<OnOrgaSaveNewOrga>((event, emit) async {
      emit(OrgaLoading());
      final result = await _addOrga.execute(event.organame, event.code, true);

      result.fold(
          (l) => emit(OrgaError(l.message)), (r) => {emit(OrgaLoaded(r))});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
