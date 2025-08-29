import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());

      try {
        // cek permission
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          emit(LocationError("Location services are disabled."));
          return;
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            emit(LocationError("Location permissions are denied"));
            return;
          }
        }

        if (permission == LocationPermission.deniedForever) {
          emit(LocationError("Location permissions are permanently denied."));
          return;
        }

        // dapat posisi
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // konversi ke alamat
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        final place = placemarks[0];
        final address = "${place.locality}, ${place.country}";

        emit(LocationLoaded(address: address, position: position));
      } catch (e) {
        emit(LocationError(e.toString()));
      }
    });
  }
}
