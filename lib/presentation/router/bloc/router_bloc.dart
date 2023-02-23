import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/sidedrawer/get_side_options.dart';
import 'package:lomba_frontend/presentation/router/bloc/router_event.dart';
import 'package:lomba_frontend/presentation/router/bloc/router_state.dart';
import 'package:rxdart/rxdart.dart';

class RouterPageBloc extends Bloc<RouterPageEvent, RouterPageState> {
  final GetSideOptions _getOptions;

  RouterPageBloc(this._getOptions): super(RouterPageEmpty()) {
    on<OnRouterPageLoading>(
      (event, emit) async {
        final page = event.destination.name.toLowerCase();
        var resultPage = page.substring(4);
        
        final result = await _getOptions.execute();

        result.fold((l) => {emit(RouterPageError(l.message))},
         (opt) {
          if(opt.contains(resultPage)) {
            emit(RouterPageRole());
          } else {
            emit(const RouterPageError(''));
          }
         });
      }
    );
    on<OnRouterPageReset>(
      (event, emit) async {
        emit(RouterPageEmpty());  
      }
    );
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}