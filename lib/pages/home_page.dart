import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _completionPercentage = 0.68;
  int _selectedProjectIndex = 0;
  int _selectedTabIndex = 0;
  
  final List<Map<String, dynamic>> _projects = [
    {
      'name': 'Mobile App Redesign',
      'progress': 0.68,
      'color': const Color(0xFF7F5AF0),
      'tasks': 12,
      'completed': 8,
    },
    {
      'name': 'Website Development',
      'progress': 0.45,
      'color': const Color(0xFF2CB67D),
      'tasks': 18,
      'completed': 8,
    },
    {
      'name': 'Marketing Campaign',
      'progress': 0.92,
      'color': const Color(0xFFF25F4C),
      'tasks': 10,
      'completed': 9,
    },
  ];
  
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Design User Interface',
      'dueDate': 'Today',
      'priority': 'High',
      'isCompleted': true,
    },
    {
      'title': 'Implement Authentication',
      'dueDate': 'Tomorrow',
      'priority': 'High',
      'isCompleted': false,
    },
    {
      'title': 'Create API Documentation',
      'dueDate': 'Sep 28',
      'priority': 'Medium',
      'isCompleted': false,
    },
    {
      'title': 'Test Payment Gateway',
      'dueDate': 'Sep 30',
      'priority': 'High',
      'isCompleted': false,
    },
    {
      'title': 'Optimize Performance',
      'dueDate': 'Oct 2',
      'priority': 'Medium',
      'isCompleted': false,
    },
  ];

  final List<Map<String, dynamic>> _team = [
    {
      'name': 'Sarah Johnson',
      'role': 'UI Designer',
      'avatar': 'S',
      'color': const Color(0xFF7F5AF0),
      'tasks': 8,
    },
    {
      'name': 'Michael Chen',
      'role': 'Developer',
      'avatar': 'M',
      'color': const Color(0xFF2CB67D),
      'tasks': 12,
    },
    {
      'name': 'Emma Wilson',
      'role': 'Project Manager',
      'avatar': 'E',
      'color': const Color(0xFFF9C846),
      'tasks': 5,
    },
    {
      'name': 'James Taylor',
      'role': 'QA Engineer',
      'avatar': 'J',
      'color': const Color(0xFFF25F4C),
      'tasks': 7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16161A),
      extendBody: true,
      body: Stack(
        children: [
          // Main content with full page scroll
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with user info
                  _buildHeader(),
                  
                  const SizedBox(height: 20),
                  
                  // Project progress cards
                  _buildProjectsCarousel(),
                  
                  const SizedBox(height: 20),
                  
                  // Tab bar for different sections
                  _buildTabBar(),
                  
                  const SizedBox(height: 16),
                  
                  // Tab content based on selected tab
                  _selectedTabIndex == 0
                      ? _buildTasksSection()
                      : _selectedTabIndex == 1
                          ? _buildAnalyticsSection()
                          : _buildTeamSection(),
                ],
              ),
            ),
          ),
          
          // Bottom navbar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Navbar(),
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
              'Hello, Alex',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'You have 5 tasks today',
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
          child: const Text(
            'A',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsCarousel() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          final isSelected = index == _selectedProjectIndex;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedProjectIndex = index;
                _completionPercentage = project['progress'];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              width: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected 
                    ? project['color'].withOpacity(0.15) 
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: project['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.folder_outlined,
                          color: project['color'],
                          size: 20,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.more_vert,
                        color: Colors.white.withOpacity(0.7),
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${project['completed']}/${project['tasks']} tasks',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: project['progress'],
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: project['color'],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${(project['progress'] * 100).toInt()}% completed',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        _buildTabButton(0, 'Tasks'),
        const SizedBox(width: 16),
        _buildTabButton(1, 'Analytics'),
        const SizedBox(width: 16),
        _buildTabButton(2, 'Team'),
      ],
    );
  }

  Widget _buildTabButton(int index, String label) {
    final isSelected = _selectedTabIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF7F5AF0).withOpacity(0.2) 
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Tasks',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final task = _tasks[index];
            
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                leading: Checkbox(
                  value: task['isCompleted'],
                  onChanged: (value) {
                    setState(() {
                      _tasks[index]['isCompleted'] = value;
                    });
                  },
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return _projects[_selectedProjectIndex]['color'];
                      }
                      return Colors.white.withOpacity(0.2);
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                title: Text(
                  task['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: task['isCompleted'] 
                        ? TextDecoration.lineThrough 
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6, 
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(task['priority']).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          task['priority'],
                          style: TextStyle(
                            color: _getPriorityColor(task['priority']),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        task['dueDate'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Icon(
                  Icons.more_vert,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnalyticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Project Progress',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        
        // Circular progress indicator
        Center(
          child: SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: _completionPercentage,
                  strokeWidth: 12,
                  backgroundColor: Colors.white.withOpacity(0.05),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _projects[_selectedProjectIndex]['color'],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(_completionPercentage * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Completed',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Statistics
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              'Total Tasks',
              _projects[_selectedProjectIndex]['tasks'].toString(),
              Icons.task_alt,
              const Color(0xFF7F5AF0),
            ),
            _buildStatItem(
              'Completed',
              _projects[_selectedProjectIndex]['completed'].toString(),
              Icons.check_circle_outline,
              const Color(0xFF2CB67D),
            ),
            _buildStatItem(
              'Pending',
              (_projects[_selectedProjectIndex]['tasks'] - 
               _projects[_selectedProjectIndex]['completed']).toString(),
              Icons.pending_actions,
              const Color(0xFFF9C846),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Project details
        const Text(
          'Project Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildDetailRow('Project Name', _projects[_selectedProjectIndex]['name']),
              const SizedBox(height: 12),
              _buildDetailRow('Start Date', 'September 1, 2023'),
              const SizedBox(height: 12),
              _buildDetailRow('Deadline', 'October 15, 2023'),
              const SizedBox(height: 12),
              _buildDetailRow('Team Members', '4 members'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Team Members',
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
          itemCount: _team.length,
          itemBuilder: (context, index) {
            final member = _team[index];
            
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor: member['color'],
                  child: Text(
                    member['avatar'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                title: Text(
                  member['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  member['role'],
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8, 
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: member['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${member['tasks']} tasks',
                    style: TextStyle(
                      color: member['color'],
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        
        const SizedBox(height: 24),
        
        // Team performance
        const Text(
          'Team Performance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildPerformanceRow('Tasks Completed This Week', '32'),
              const SizedBox(height: 12),
              _buildPerformanceRow('Average Completion Time', '2.5 days'),
              const SizedBox(height: 12),
              _buildPerformanceRow('Team Efficiency', '87%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 22,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color(0xFFF25F4C);
      case 'Medium':
        return const Color(0xFFF9C846);
      case 'Low':
        return const Color(0xFF2CB67D);
      default:
        return const Color(0xFF7F5AF0);
    }
  }
}

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
          _buildNavItem(1, Icons.calendar_today_outlined, Icons.calendar_today, 'Calendar'),
          _buildNavItem(2, Icons.chat_bubble_outline, Icons.chat_bubble, 'Chat'),
          _buildNavItem(3, Icons.person_outline, Icons.person, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7F5AF0).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 