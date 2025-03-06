import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    return SafeArea(
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
            if (_selectedTabIndex == 0)
              _buildTasksSection()
            else if (_selectedTabIndex == 1)
              _buildAnalyticsSection()
            else
              _buildTeamSection(),
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
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          final isSelected = index == _selectedProjectIndex;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.only(
              right: 16,
              top: isSelected ? 0 : 10,
              bottom: isSelected ? 10 : 0,
            ),
            width: 200,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedProjectIndex = index;
                    _completionPercentage = project['progress'];
                  });
                },
                borderRadius: BorderRadius.circular(16),
                splashColor: project['color'].withOpacity(0.1),
                highlightColor: project['color'].withOpacity(0.05),
                child: Container(
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
                          // Folder icon
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: project['color'].withOpacity(isSelected ? 0.3 : 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.folder_outlined,
                              color: project['color'],
                              size: 20,
                            ),
                          ),
                          const Spacer(),
                          // Task count badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.task_alt,
                                  color: project['color'],
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${project['completed']}/${project['tasks']}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Project name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isSelected)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 2,
                              width: 40,
                              decoration: BoxDecoration(
                                color: project['color'],
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Progress bar
                      Stack(
                        children: [
                          // Background track
                          Container(
                            height: 4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          // Progress
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutCubic,
                            height: 4,
                            width: (project['progress'] * 168),
                            decoration: BoxDecoration(
                              color: project['color'],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Percentage and due date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(project['progress'] * 100).toInt()}% completed',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 11,
                            ),
                          ),
                          // Due date
                          Text(
                            'Due Oct 15',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Today\'s Tasks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white.withOpacity(0.7),
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Sep 25, 2023',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final task = _tasks[index];
            
            return AnimatedOpacity(
              duration: Duration(milliseconds: 500 + (index * 100)),
              opacity: 1.0,
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(0, 0, 0)
                  ..scale(task['isCompleted'] ? 0.98 : 1.0),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: task['isCompleted']
                      ? Colors.white.withOpacity(0.03)
                      : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        task['isCompleted'] = !task['isCompleted'];
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    splashColor: _getPriorityColor(task['priority']).withOpacity(0.1),
                    highlightColor: _getPriorityColor(task['priority']).withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Animated checkbox without border
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: task['isCompleted']
                                  ? _projects[_selectedProjectIndex]['color']
                                  : Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: task['isCompleted'] ? 1.0 : 0.0,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          
                          // Task details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Task title with strike-through animation
                                    Expanded(
                                      child: AnimatedDefaultTextStyle(
                                        duration: const Duration(milliseconds: 300),
                                        style: TextStyle(
                                          color: task['isCompleted']
                                              ? Colors.white.withOpacity(0.5)
                                              : Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          decoration: task['isCompleted']
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          decorationColor: Colors.white.withOpacity(0.5),
                                          decorationThickness: 2,
                                        ),
                                        child: Text(
                                          task['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    
                                    // Due time with animated color
                                    AnimatedDefaultTextStyle(
                                      duration: const Duration(milliseconds: 300),
                                      style: TextStyle(
                                        color: _isTaskOverdue(task['dueDate'])
                                            ? const Color(0xFFF25F4C)
                                            : Colors.white.withOpacity(0.5),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      child: Text(task['dueDate']),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                
                                // Task metadata
                                Row(
                                  children: [
                                    // Priority tag without border
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(task['priority']).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            _getPriorityIcon(task['priority']),
                                            color: _getPriorityColor(task['priority']),
                                            size: 10,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            task['priority'],
                                            style: TextStyle(
                                              color: _getPriorityColor(task['priority']),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    
                                    // Project tag without border
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _projects[_selectedProjectIndex]['color'].withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.folder_outlined,
                                            color: _projects[_selectedProjectIndex]['color'],
                                            size: 10,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            _projects[_selectedProjectIndex]['name'],
                                            style: TextStyle(
                                              color: _projects[_selectedProjectIndex]['color'],
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // More options button
                          Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white.withOpacity(0.5),
                                size: 18,
                              ),
                              onPressed: () {
                                _showTaskOptions(context, index);
                              },
                              splashColor: _getPriorityColor(task['priority']).withOpacity(0.1),
                              highlightColor: _getPriorityColor(task['priority']).withOpacity(0.05),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        
        // Add task button without border
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Add new task functionality
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: _projects[_selectedProjectIndex]['color'],
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add New Task',
                      style: TextStyle(
                        color: _projects[_selectedProjectIndex]['color'],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to determine if a task is overdue
  bool _isTaskOverdue(String dueDate) {
    return dueDate == 'Today' || dueDate == 'Yesterday';
  }

  // Helper method to get priority icon
  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case 'High':
        return Icons.priority_high;
      case 'Medium':
        return Icons.remove;
      case 'Low':
        return Icons.arrow_downward;
      default:
        return Icons.circle;
    }
  }

  // Show task options bottom sheet
  void _showTaskOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F28),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTaskOption(Icons.edit_outlined, 'Edit Task', Colors.blue),
              _buildTaskOption(Icons.calendar_today_outlined, 'Reschedule', Colors.orange),
              _buildTaskOption(Icons.delete_outline, 'Delete Task', Colors.red),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build task option
  Widget _buildTaskOption(IconData icon, String label, Color color) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
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
