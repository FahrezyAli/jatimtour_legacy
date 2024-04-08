import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jatimtour/models/event.dart';

class EventRegister extends StatefulWidget {
  final Event? event;
  const EventRegister({Key? key, required this.event}) : super(key: key);

  @override
  State<EventRegister> createState() => _EventRegisterState();
}

class _EventRegisterState extends State<EventRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quotaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController endPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      nameController.text = widget.event!.name;
      descriptionController.text = widget.event!.description;
      cityController.text = widget.event!.city;
      addressController.text = widget.event!.address;
      typeController.text = widget.event!.type;
      dateController.text = DateFormat('dd-MM-yyyy').format(widget.event!.date);
      priceController.text = widget.event!.price;
      endPriceController.text = widget.event!.endPrice;
    }
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  String? _eventType;
  String? _selectedCity;
  List<Event> events = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Buat Event',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              TextField(
                controller: nameController,
                maxLength: 100,
                decoration: const InputDecoration(
                    hintText: 'Nama Event', border: InputBorder.none),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: descriptionController,
                maxLength: 500,
                decoration: const InputDecoration(
                    hintText: 'Deskripsi', border: InputBorder.none),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: InputDecoration(
                  hintText: 'Tanggal Event',
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: typeController,
                    decoration: InputDecoration(
                      hintText: 'Tipe Event',
                      border: InputBorder.none,
                      suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Online',
                                  groupValue: _eventType,
                                  onChanged: (value) {
                                    setState(() {
                                      _eventType = value;
                                      typeController.text = '';
                                    });
                                  },
                                ),
                                const Text('Online'),
                                Radio<String>(
                                  value: 'Offline',
                                  groupValue: _eventType,
                                  onChanged: (value) {
                                    setState(() {
                                      _eventType = value;
                                    });
                                  },
                                ),
                                const Text('Offline'),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: addressController,
                    maxLength: 500,
                    decoration: const InputDecoration(
                        hintText: 'Alamat', border: InputBorder.none),
                  ),
                  const SizedBox(height: 5),
                  DropdownButton<String>(
                    hint: Text(_selectedCity ?? 'Kota'),
                    value: _selectedCity,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                    items: <String>[
                      'BANGKALAN',
                      'BANYUWANGI',
                      'BATU',
                      'BLITAR',
                      'BOJONEGORO',
                      'BONDOWOSO',
                      'GRESIK',
                      'JEMBER',
                      'JOMBANG',
                      'KEDIRI',
                      'PAMENANG',
                      'LAMONGAN',
                      'LUMAJANG',
                      'MADIUN',
                      'MAGETAN',
                      'MALANG',
                      'MOJOKERTO',
                      'NGANJUK',
                      'NGAWI',
                      'PACITAN',
                      'PAMEKASAN',
                      'PASURUAN',
                      'PONOROGO',
                      'PROBOLINGGO',
                      'SAMPANG',
                      'SIDOARJO',
                      'SITUBONDO',
                      'SUMENEP',
                      'TRENGGALEK',
                      'TUBAN',
                      'TULUNGAGUNG',
                      'SURABAYA'
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    underline: Container(),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: quotaController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(
                        hintText: 'Kuota', border: InputBorder.none),
                  ),
                  const SizedBox(height: 5),
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                      controller: priceController,
                      maxLength: 100,
                      decoration: InputDecoration(
                        hintText: 'Harga Awal',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    )),
                    SizedBox(width: 5),
                    Text(' s/d '),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: endPriceController,
                        maxLength: 100,
                        decoration: InputDecoration(
                          hintText: 'Harga Akhir',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ]),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      String name = nameController.text.trim();
                      String description = descriptionController.text.trim();
                      String city = _selectedCity ?? '';
                      String address = addressController.text.trim();
                      String type = _eventType ?? '';
                      DateTime date = _selectedDate ?? DateTime.now();

                      String quota = quotaController.text.trim();
                      String price = priceController.text.trim();
                      String endPrice = endPriceController.text.trim();

                      if (name.isNotEmpty &&
                          description.isNotEmpty &&
                          city.isNotEmpty &&
                          address.isNotEmpty &&
                          type.isNotEmpty &&
                          quota.isNotEmpty &&
                          price.isNotEmpty &&
                          endPrice.isNotEmpty) {
                        if (widget.event != null) {
                          Event updatedEvent = Event(
                            name: name,
                            description: description,
                            city: city,
                            address: address,
                            type: type,
                            date: date,
                            quota: quota,
                            price: price,
                            endPrice: endPrice,
                          );
                          // Navigate back to the previous screen and pass the updated event as the result
                          Navigator.pop(context, updatedEvent);
                        } else {
                          setState(() {
                            nameController.text = '';
                            descriptionController.text = '';
                            cityController.text = '';
                            addressController.text = '';
                            typeController.text = '';
                            dateController.text = '';
                            quotaController.text = '';
                            priceController.text = '';
                            endPriceController.text = '';
                            events.add(Event(
                              name: name,
                              description: description,
                              city: city,
                              address: address,
                              type: type,
                              date: date,
                              quota: quota,
                              price: price,
                              endPrice: endPrice,
                            ));
                          });
                          Navigator.pop(context, events.last);
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ],
          ),
        ));
  }
}
