import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:valet_parking_app/components/custom_add_button.dart';
import 'package:valet_parking_app/components/custom_confirm_dialog.dart';
import 'package:valet_parking_app/components/custom_navigation_bar.dart';
import 'package:valet_parking_app/components/custom_reservation_card.dart';
import 'package:valet_parking_app/components/custom_title.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/models/reservation_model.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/data/utils/date_formatter.dart';
import 'package:valet_parking_app/modules/home/home_controller.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final UserService userService = UserService();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTitle(title: 'Mis Reservas'),
                    userService.getRole() == 'EMPLOYEE_ROLE'
                        ? CustomAddButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.SCAN_QR);
                            },
                            icon: Icons.qr_code_scanner_rounded,
                          )
                        : userService.getRole() == 'USER_ROLE'
                            ? CustomAddButton(
                                onPressed: () {
                                  openDialog(null);
                                },
                              )
                            : const SizedBox(),
                  ],
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Constants.FOCUSED_COLOR), // Change the color here
                        )
                      : controller.reservations.isEmpty
                          ? const Center(
                              child: Text(
                                'No tienes reservas aún.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Constants.FOCUSED_COLOR,
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemCount: controller.reservations.length,
                              itemBuilder: (context, index) {
                                return CustomReservationCard(
                                  reservation: controller.reservations[index],
                                  onEditPressed: () {
                                    openDialog(controller.reservations[index]);
                                  },
                                  onViewDetailPressed: () {
                                    Get.offAllNamed(
                                      Routes.RESERVATION_DETAIL,
                                      arguments: controller.reservations[index].id,
                                    );
                                  },
                                  onDeletePressed: () {
                                    showConfirmDialog(
                                      content: '¿Estás seguro de que deseas eliminar esta reserva?',
                                      onConfirm: () {
                                        controller.deleteReservation(controller.reservations[index].id!);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentIndex: 0),
    );
  }

  void openDialog(ReservationModel? rm) {
    controller.onOpenDialog(rm);
    Get.dialog(
      AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
        title: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Obx(
                  () => getCurrentStepTitle(controller.reservation['currentStep']),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: Get.width * 0.95,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => getCurrentStepContent(controller.reservation['currentStep'])),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() => getCurrentStepActions(controller.reservation['currentStep']).first),
          Obx(() => getCurrentStepActions(controller.reservation['currentStep'])[1]),
        ],
      ),
    );
  }

  Widget getCurrentStepContent(int index) {
    switch (index) {
      case 0:
        return ListView(
          shrinkWrap: true,
          children: controller.cars.map((car) {
            return ListTile(
              title: Text(car.brand),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.model),
                  Text(car.carPlate),
                ],
              ),
              leading: Radio(
                value: car.id,
                groupValue: controller.reservation['car'],
                onChanged: (value) {
                  controller.reservation['car'] = value;
                  controller.reservation.refresh();
                },
              ),
              trailing: Icon(
                Icons.directions_car,
                color: Color(
                  int.parse('0x${car.color}'),
                ),
                size: 30,
              ),
              onTap: () {
                controller.reservation['car'] = car.id;
                controller.reservation.refresh();
              },
            );
          }).toList(),
        );
      case 1:
        return ListView(
          shrinkWrap: true,
          children: controller.parkings.map((parking) {
            return ListTile(
              title: Text(parking.address),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Capacidad: ${parking.maxCapacity}'),
                  Text('Espacios ocupados: ${parking.occupiedSpaces}'),
                ],
              ),
              leading: Radio(
                value: parking.id,
                groupValue: controller.reservation['parking'],
                onChanged: (value) {
                  controller.reservation['parking'] = value;
                  controller.reservation.refresh();
                },
              ),
              trailing: const Icon(
                Icons.location_on,
                color: Constants.FOCUSED_COLOR,
                size: 30,
              ),
              onTap: () {
                controller.reservation['parking'] = parking.id;
                controller.reservation.refresh();
              },
            );
          }).toList(),
        );
      case 2:
        return SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.single,
          initialDisplayDate: controller.reservationInitialState['date'] as DateTime,
          initialSelectedDate: controller.reservation['date'] as DateTime,
          maxDate: getDateTimeNow().add(const Duration(days: 60)),
          minDate: controller.reservationInitialState['date'] as DateTime,
          showActionButtons: false,
          showNavigationArrow: true,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            controller.reservation['date'] = args.value;
            controller.reservation.refresh();
          },
          selectionColor: Constants.FOCUSED_COLOR,
          todayHighlightColor: Constants.FOCUSED_COLOR,
        );
      case 3:
        return TimePickerSpinner(
          locale: const Locale('en', ''),
          time: controller.reservation['date'],
          is24HourMode: false,
          isShowSeconds: false,
          itemHeight: 80,
          minutesInterval: 30,
          normalTextStyle: const TextStyle(
            fontSize: 24,
          ),
          highlightedTextStyle: const TextStyle(fontSize: 24, color: Constants.FOCUSED_COLOR),
          isForce2Digits: true,
          onTimeChange: (time) {
            controller.reservation['date'] = time;
            controller.reservation.refresh();
          },
        );
      default:
        return const SizedBox();
    }
  }

  Widget getCurrentStepTitle(int index) {
    switch (index) {
      case 0:
        return const Text(
          'Seleccionar Vehículo',
          style: TextStyle(
            color: Constants.FOCUSED_COLOR,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        );
      case 1:
        return const Text(
          'Seleccionar\nEstacionamiento',
          style: TextStyle(
            color: Constants.FOCUSED_COLOR,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        );
      case 2:
        return const Text(
          'Seleccionar Día',
          style: TextStyle(
            color: Constants.FOCUSED_COLOR,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        );
      case 3:
        return const Text(
          'Seleccionar Hora',
          style: TextStyle(
            color: Constants.FOCUSED_COLOR,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        );
      default:
        return const SizedBox();
    }
  }

  List<Widget> getCurrentStepActions(int index) {
    switch (index) {
      case 0:
        return [
          Container(),
          TextButton(
            onPressed: controller.reservation['car'] == null
                ? null
                : () {
                    controller.setCurrentStep(1);
                  },
            child: const Text('Siguiente'),
          ),
        ];
      case 1:
        return [
          TextButton(
            onPressed: () {
              controller.setCurrentStep(0);
            },
            child: const Text('Anterior'),
          ),
          TextButton(
            onPressed: controller.reservation['parking'] == null
                ? null
                : () {
                    controller.setCurrentStep(2);
                  },
            child: const Text('Siguiente'),
          ),
        ];
      case 2:
        return [
          TextButton(
            onPressed: () {
              controller.setCurrentStep(1);
            },
            child: const Text('Anterior'),
          ),
          TextButton(
            onPressed: () {
              controller.setCurrentStep(3);
            },
            child: const Text('Siguiente'),
          ),
        ];
      case 3:
        return [
          TextButton(
            onPressed: () {
              controller.setCurrentStep(2);
            },
            child: const Text('Anterior'),
          ),
          TextButton(
            onPressed: controller.reservation['date'].hour < 10 || controller.reservation['date'].hour >= 22
                ? null
                : () {
                    Get.back();
                    if (controller.reservation['id'] == null) {
                      controller.createReservation();
                    } else {
                      controller.editReservation();
                    }
                  },
            child: Text(controller.reservation['id'] == null ? 'Reservar' : 'Editar'),
          ),
        ];
      default:
        return [];
    }
  }
}
