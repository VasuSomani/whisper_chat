import 'package:flutter/material.dart';
import 'package:whisper_chat/services/room_service.dart';

class RoomsHistory extends StatelessWidget {
  const RoomsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (RoomService.lastFiveRooms.isNotEmpty)
          const Divider(
            color: Colors.grey,
            thickness: 3,
          ),
        if (RoomService.lastFiveRooms.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Recent Joined Rooms",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black,
                    letterSpacing: 0,
                    fontSize: 20,
                  ),
            ),
          ),
        ...RoomService.lastFiveRooms
            .map((roomID) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black.withOpacity(0.8),
                    onPrimary: Colors.white,
                  ),
                  onPressed: () async {
                    await RoomService()
                        .joinPrivateRoom(roomID, context)
                        .then((value) {
                      Navigator.pushNamed(context, '/chat', arguments: roomID);
                    });
                  },
                  child: Text(
                    'Room ID : $roomID',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          letterSpacing: 0,
                          fontSize: 15,
                        ),
                  ),
                ),
              );
            })
            .toList()
            .reversed,
      ],
    );
  }
}
