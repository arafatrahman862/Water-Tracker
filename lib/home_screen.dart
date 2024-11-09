import 'package:flutter/material.dart';
import 'package:water_track_app/water_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glaaassNoTEController =
      TextEditingController(text: '1');

  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Tracker"),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWaterTrackCounter(),
            const SizedBox(
              height: 24,
            ),
            Expanded(child: _buildWaterTrackListView())
          ],
        ),
      ),
    );
  }

  Widget _buildWaterTrackListView() {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        final WaterTrack waterTrack = waterTrackList[index];
        return _buildWaterTrackListTile(index);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  Widget _buildWaterTrackListTile( int index) {
    WaterTrack waterTrack = waterTrackList[index];
    return ListTile(
        title:
            Text('${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}'),
        subtitle: Text(
            '${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}'),
        leading: CircleAvatar(child: Text('${waterTrack.noOfGlasses}')),
        trailing:
            IconButton(onPressed: () => _onTapDeleteButton(index), icon: const Icon(Icons.delete)),
      );
  }

  Widget _buildWaterTrackCounter() {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const Text(
          "Glass/s",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _glaaassNoTEController,
                textAlign: TextAlign.center,
              ),
              width: 50,
            ),
            TextButton(
                onPressed: _onTapAddWatertrack, child: const Text('Add')),
          ],
        ),
      ],
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.noOfGlasses;
    }
    return counter;
  }

  void _onTapAddWatertrack() {
    if (_glaaassNoTEController.text.isEmpty) {
      _glaaassNoTEController.text = '1';
    }
    final int noOfGlasses = int.tryParse(_glaaassNoTEController.text) ?? 1;
    WaterTrack waterTrack =
        WaterTrack(noOfGlasses: noOfGlasses, dateTime: DateTime.now());
    waterTrackList.add(waterTrack);
    setState(() {});
  }

  void _onTapDeleteButton(int index) {
    waterTrackList.removeAt(index);
    setState(() {});
  }
}


