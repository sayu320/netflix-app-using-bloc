// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:netflix_app/application/downloads/downloads_bloc.dart' as _i9;
import 'package:netflix_app/application/fast_laugh/fast_laugh_bloc.dart'
    as _i10;
import 'package:netflix_app/application/home/home_bloc.dart' as _i11;
import 'package:netflix_app/application/hot_and_new/hot_and_new_bloc.dart'
    as _i12;
import 'package:netflix_app/application/search/search_bloc.dart' as _i13;
import 'package:netflix_app/domain/downloads/i_downloads_repo.dart' as _i5;
import 'package:netflix_app/domain/hot_and_new_resp/hot_and_new_service.dart'
    as _i3;
import 'package:netflix_app/infrastructure/downloads/downloads_repository.dart'
    as _i6;
import 'package:netflix_app/infrastructure/hot_and_new/hot_and_new_impl.dart'
    as _i4;
import 'package:netflix_app/infrastructure/search/search_impl.dart' as _i8;
import 'package:netflix_app/presentation/search/search_services.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.HotAndNewService>(() => _i4.HotAndNewImplementation());
    gh.lazySingleton<_i5.IDownloadsRepo>(() => _i6.DownloadsRepository());
    gh.lazySingleton<_i7.SearchService>(() => _i8.SearchImpl());
    gh.factory<_i9.DownloadsBloc>(
        () => _i9.DownloadsBloc(gh<_i5.IDownloadsRepo>()));
    gh.factory<_i10.FastLaughBloc>(
        () => _i10.FastLaughBloc(gh<_i5.IDownloadsRepo>()));
    gh.factory<_i11.HomeBloc>(() => _i11.HomeBloc(gh<_i3.HotAndNewService>()));
    gh.factory<_i12.HotAndNewBloc>(
        () => _i12.HotAndNewBloc(gh<_i3.HotAndNewService>()));
    gh.factory<_i13.SearchBloc>(() => _i13.SearchBloc(
          gh<_i5.IDownloadsRepo>(),
          gh<_i7.SearchService>(),
        ));
    return this;
  }
}
