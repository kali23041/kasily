import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _selectedChatIndex = -1;

  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Sarah Johnson',
      'avatar': 'S',
      'color': const Color(0xFF7F5AF0),
      'lastMessage': 'Can you send me the design files?',
      'time': '10:30 AM',
      'unread': 2,
    },
    {
      'name': 'Design Team',
      'avatar': 'D',
      'color': const Color(0xFF2CB67D),
      'lastMessage': 'Meeting at 3 PM today',
      'time': 'Yesterday',
      'unread': 0,
    },
    {
      'name': 'Michael Chen',
      'avatar': 'M',
      'color': const Color(0xFFF9C846),
      'lastMessage': 'I\'ve completed the task',
      'time': 'Yesterday',
      'unread': 0,
    },
    {
      'name': 'Emma Wilson',
      'avatar': 'E',
      'color': const Color(0xFFF25F4C),
      'lastMessage': 'Let\'s discuss the project timeline',
      'time': 'Sep 20',
      'unread': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: _buildHeader(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSearchBar(),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _selectedChatIndex == -1
                ? _buildChatList()
                : _buildChatDetail(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Messages',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'You have 2 unread messages',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFF7F5AF0),
          child: const Icon(
            Icons.chat_bubble,
            color: Colors.white,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search messages...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        final chat = _chats[index];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedChatIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: chat['color'],
                  child: Text(
                    chat['avatar'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chat['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            chat['time'],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat['lastMessage'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (chat['unread'] > 0)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: chat['color'],
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                chat['unread'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatDetail() {
    final chat = _chats[_selectedChatIndex];
    
    return Column(
      children: [
        // Chat header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _selectedChatIndex = -1;
                  });
                },
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: chat['color'],
                child: Text(
                  chat['avatar'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Online',
                      style: TextStyle(
                        color: Colors.green.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white.withOpacity(0.7),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        
        // Chat messages
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            reverse: true,
            children: [
              _buildMessage(
                'Can you send me the design files?',
                false,
                '10:30 AM',
              ),
              _buildMessage(
                'Sure, I\'ll send them right away.',
                true,
                '10:32 AM',
              ),
              _buildMessage(
                'Thanks! I need them for the client meeting tomorrow.',
                false,
                '10:33 AM',
              ),
              _buildMessage(
                'No problem. I\'ve just emailed them to you. Let me know if you need anything else.',
                true,
                '10:35 AM',
              ),
              _buildMessage(
                'Got them, thanks!',
                false,
                '10:40 AM',
              ),
            ],
          ),
        ),
        
        // Message input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.attach_file,
                  color: Colors.white.withOpacity(0.7),
                ),
                onPressed: () {},
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Color(0xFF7F5AF0),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessage(String text, bool isSent, String time) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSent 
              ? const Color(0xFF7F5AF0).withOpacity(0.2) 
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSent 
                ? const Color(0xFF7F5AF0).withOpacity(0.3) 
                : Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 