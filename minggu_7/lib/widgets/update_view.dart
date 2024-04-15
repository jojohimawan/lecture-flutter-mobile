import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minggu_7/data/status.dart';
import 'package:minggu_7/theme/theme.dart';
import 'package:minggu_7/data/channel.dart';

class UpdateView extends StatelessWidget {
  const UpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        _buildStatusHeader(),
        _buildStatusSection(),
        _buildChannelsHeader(),
        _buildChannelsSection(context),
      ]),
    );
  }

  Widget _buildStatusHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Status',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _buildStatusSection() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: List.generate(statusList.length, (index) {
            return Column(children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.account_circle,
                      size: 64, color: Colors.grey[300])),
              Text(
                statusList[index].name,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              )
            ]);
          }),
        ));
  }

  Widget _buildChannelsHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Channels',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _buildChannelsSection(context) {
    return Column(
        children: List.generate(channelList.length, (index) {
      return Column(
        children: [
          _constructChannelHeader(
              channelList[index].logoUrl, channelList[index].name),
          _constructChannelBody(
              channelList[index].content, channelList[index].thumbnailUrl),
          _constructChannelFooter(channelList[index].count),
          const SizedBox(
            height: 16,
          )
        ],
      );
    }));
  }
}

Widget _constructChannelHeader(String logoUrl, String name) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CircleAvatar(backgroundImage: NetworkImage(logoUrl)),
      ),
      Text(
        name,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      )
    ],
  );
}

Widget _constructChannelBody(String content, String thumbnailUrl) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              content,
              style: TextStyle(color: Colors.grey[600]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              thumbnailUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    ),
  );
}

Widget _constructChannelFooter(String count) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Badge(
          backgroundColor: whatsappSecondary,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          '${count} Unread',
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: whatsappSecondary),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          '17:23',
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Colors.grey[600]),
        ),
      )
    ],
  );
}

Widget _buildOldListview() {
  return Expanded(
    child: ListView.builder(
      itemCount: statusList.length,
      itemBuilder: (_, index) {
        final status = statusList[index];
        return ListTile(
          leading: const Icon(
            Icons.account_circle,
            color: Colors.black26,
            size: 58,
          ),
          title: Text(
            status.name,
          ),
          subtitle: Text(
            status.statusDate,
          ),
        );
      },
    ),
  );
}