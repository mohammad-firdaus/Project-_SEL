import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingEventManagePage extends StatefulWidget {
  const UpcomingEventManagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpcomingEventManagePageState createState() =>
      _UpcomingEventManagePageState();
}

class _UpcomingEventManagePageState extends State<UpcomingEventManagePage> {
  final Color greenColor = Color(0xFF42B642);

  // Sample events data
  List<EventItem> events = [
    EventItem(
      title: 'Beach Cleanup Drive',
      date: DateTime(2025, 11, 15),
      location: 'Pantai Cenang, Langkawi',
      participants: 45,
      isActive: true,
    ),
    EventItem(
      title: 'Recycling Workshop',
      date: DateTime(2025, 11, 20),
      location: 'KLCC, Kuala Lumpur',
      participants: 30,
      isActive: true,
    ),
    EventItem(
      title: 'Green Market Festival',
      date: DateTime(2025, 11, 25),
      location: 'Penang',
      participants: 120,
      isActive: true,
    ),
  ];

  bool showNewEventForm = false;
  bool isEditing = false;
  int? currentEditingIndex;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Format date to required format (e.g. Nov 15, 2025)
  String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  void toggleNewEventForm() {
    setState(() {
      showNewEventForm = !showNewEventForm;
      if (!showNewEventForm) {
        _clearNewEventForm();
      }
    });
  }

  void _clearNewEventForm() {
    titleController.clear();
    dateController.clear();
    locationController.clear();
    descriptionController.clear();
  }

  void saveNewEvent() {
    String title = titleController.text.trim();
    String dateStr = dateController.text.trim();
    String location = locationController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty || dateStr.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    DateTime? date;
    try {
      date = DateFormat('MMM dd, yyyy').parseStrict(dateStr);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Date format should be like: Nov 15, 2025')),
      );
      return;
    }

    setState(() {
      if (isEditing && currentEditingIndex != null) {
        // Update existing event
        events[currentEditingIndex!] = EventItem(
          title: title,
          date: date!,
          location: location,
          participants: events[currentEditingIndex!].participants,
          description: description,
          isActive: events[currentEditingIndex!].isActive,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Event successfully updated')));
      } else {
        // Add new event
        events.insert(
          0,
          EventItem(
            title: title,
            date: date!,
            location: location,
            participants: 0,
            description: description,
            isActive: true,
          ),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Event successfully added')));
      }
      showNewEventForm = false;
      isEditing = false;
      currentEditingIndex = null;
      _clearNewEventForm();
    });
  }

  void _startEditing(int index) {
    final event = events[index];
    titleController.text = event.title;
    dateController.text = formatDate(event.date);
    locationController.text = event.location;
    descriptionController.text = event.description;
    setState(() {
      isEditing = true;
      currentEditingIndex = index;
      showNewEventForm = true;
    });
  }

  void _deleteEvent(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Event'),
        content: Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                events.removeAt(index);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Event deleted')));
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Events',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Add or edit upcoming events',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: greenColor,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add, color: greenColor),
                      label: Text(
                        'Add New Event',
                        style: TextStyle(
                          color: greenColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: BorderSide(color: greenColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: toggleNewEventForm,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (showNewEventForm) _buildNewEventForm(),
                  Column(
                    children: events
                        .map(
                          (event) =>
                              _buildEventCard(context, event, greenColor),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewEventForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing ? 'Edit Event' : 'New Event',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 12),
          Text('Event Title *', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Enter event title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Date *', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
              hintText: 'e.g., Nov 15, 2025',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Location *', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          TextField(
            controller: locationController,
            decoration: InputDecoration(
              hintText: 'Enter location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Description', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Enter event description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save, color: Colors.white),
                  label: Text(
                    isEditing ? 'Update Event' : 'Save Event',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: saveNewEvent,
                ),
              ),
              SizedBox(width: 12),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.grey.shade300,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    setState(() {
                      showNewEventForm = false;
                      isEditing = false;
                      currentEditingIndex = null;
                      _clearNewEventForm();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    EventItem event,
    Color greenColor,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  formatDate(event.date),
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                Spacer(),
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  event.location,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.people, size: 20, color: greenColor),
                SizedBox(width: 8),
                Text(
                  '${event.participants} registered',
                  style: TextStyle(
                    color: greenColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                Material(
                  color: greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () => _startEditing(events.indexOf(event)),
                  ),
                ),
                SizedBox(width: 8),
                Material(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.white),
                    onPressed: () => _deleteEvent(events.indexOf(event)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventItem {
  final String title;
  final DateTime date;
  final String location;
  final int participants;
  final String description;
  final bool isActive;

  EventItem({
    required this.title,
    required this.date,
    required this.location,
    this.participants = 0,
    this.description = '',
    this.isActive = true,
  });
}
