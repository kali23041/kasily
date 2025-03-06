import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildUpcomingEvents(),
          ],
        ),
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
              'Calendar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Your schedule for the month',
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
          backgroundColor: const Color(0xFF2CB67D),
          child: const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Month selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.white.withOpacity(0.7),
                ),
                onPressed: () {},
              ),
              const Text(
                'September 2023',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  color: Colors.white.withOpacity(0.7),
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Days of week
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('M', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('T', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('W', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('T', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('F', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('S', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('S', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          
          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 30, // Days in September
            itemBuilder: (context, index) {
              final day = index + 1;
              final isToday = day == 15; // Assuming today is the 15th
              final hasEvent = [3, 8, 15, 22, 27].contains(day);
              
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isToday ? const Color(0xFF2CB67D).withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isToday 
                      ? Border.all(color: const Color(0xFF2CB67D), width: 1) 
                      : null,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      day.toString(),
                      style: TextStyle(
                        color: isToday ? const Color(0xFF2CB67D) : Colors.white,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (hasEvent)
                      Positioned(
                        bottom: 4,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2CB67D),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    final events = [
      {
        'title': 'Team Meeting',
        'time': '10:00 AM - 11:30 AM',
        'location': 'Conference Room A',
        'color': const Color(0xFF7F5AF0),
      },
      {
        'title': 'Project Deadline',
        'time': '5:00 PM',
        'location': 'Submit via Email',
        'color': const Color(0xFFF25F4C),
      },
      {
        'title': 'Lunch with Client',
        'time': '12:30 PM - 2:00 PM',
        'location': 'Downtown Cafe',
        'color': const Color(0xFF2CB67D),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: event['color'] as Color,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 50,
                    decoration: BoxDecoration(
                      color: event['color'] as Color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['time'] as String,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['location'] as String,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
} 