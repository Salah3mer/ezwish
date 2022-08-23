import 'package:bee/screens/address_screen/address_screen.dart';
import 'package:bee/screens/home_screen/home_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrdarScreen extends StatelessWidget {
  var dateController = TextEditingController();
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
      if (state is AddOrdarSuccessState) {
        myToast(
            mas: state.s.toString(),
            color: state.state ? Colors.green : Colors.red);
        if (state.state) {
          navegatTo(context, HomeScreen());
        }
      }
    }, builder: (context, state) {
      var c = AppCubit.get(context);
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              IconBroken.Arrow___Left_2,
              color: defColor,
              size: 30,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logo.png',
                  width: 35,
                  fit: BoxFit.fitHeight,
                  height: 75,
                ),
                const Text(
                  'Order',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: ConditionalBuilder(
          condition: c.getAddressModel != null,
          fallback: (context) => const Center(
              child: CircularProgressIndicator(
            color: defColor,
          )),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: defColor,
                      height: 1,
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Ordar Naw',
                        style: TextStyle(color: defColor),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      color: defColor,
                      height: 1,
                    )),
                  ],
                ),
                Stepper(
                  physics: BouncingScrollPhysics(),
                  currentStep: c.currentStep,
                  onStepTapped: (int index) {
                    c.stepper(index);
                  },
                  onStepCancel: () {
                    c.steppermin();
                  },
                  onStepContinue: () {
                    c.stepperPluse();
                  },
                  controlsBuilder: (context, ControlsDetails controlsDetails) =>
                      Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            controlsDetails.onStepContinue!.call();
                          },
                          child:
                              Text(c.currentStep != 1 ? 'Continue' : 'Confirm'),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        if (c.currentStep != 1)
                          Expanded(
                              child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey.shade400)),
                            onPressed: () {
                              controlsDetails.onStepCancel!.call();
                            },
                            child: Text('Cancel'),
                          )),
                      ],
                    ),
                  ),
                  steps: [
                    Step(
                      isActive: c.currentStep >= 0,
                      state: c.currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                      title: Text('Chois your address'),
                      content: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              c.fromOrdar = true;
                              navegatTo(context, AddressScreen());
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Add New Address',
                                  style: TextStyle(color: defColor),
                                ),
                                Icon(IconBroken.Plus, color: defColor),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      c.currentSelectedItem(index);
                                      print({
                                        c.getAddressModel!.addressData!
                                            .address[index].id
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: index == c.currentSelected
                                            ? Colors.indigo[200]
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(.15),
                                            blurRadius: 5,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${c.getAddressModel!.addressData!.address[index].city} ${c.getAddressModel!.addressData!.address[index].region} ${c.getAddressModel!.addressData!.address[index].details}')
                                        ],
                                      ),
                                    ),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 5,
                                  ),
                              itemCount: 4)
                        ],
                      ),
                    ),
                    Step(
                      isActive: c.currentStep >= 1,
                      state: c.currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                      title: Text('Day to Deliver'),
                      content: myFormField(
                          prefix: IconBroken.Calendar,
                          controller: dateController,
                          readonly: true,
                          onTap: () {
                            DateTime tommorow =
                                DateTime.now().add(Duration(days: 1));
                            showDatePicker(
                                    context: context,
                                    initialDate: tommorow,
                                    firstDate: tommorow,
                                    lastDate:
                                        DateTime.now().add(Duration(days: 30)))
                                .then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value!);
                            });
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
