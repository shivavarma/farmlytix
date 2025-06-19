import 'package:flutter/material.dart';

void main() {
  runApp(FarmlytixApp());
}

class FarmlytixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmlytix',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: RoleSelectionScreen(),
    );
  }
}

class RoleSelectionScreen extends StatefulWidget {
  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  final Map<String, List<String>> sampleQuestions = {
    "Farm Manager": ["Show irrigation overview", "Give weekly report"],
    "Field Supervisor": ["What is today’s irrigation task?", "Any pest alerts?"],
    "Dairy Supervisor": ["Milk yield summary", "Feed schedule for cows"],
    "Technician": ["Any pending maintenance?", "List repair requests"],
    "Admin": ["Current inventory status", "Expense summary for the week"],
  };

  final Map<String, Map<String, Map<String, String>>> roleBasedData = {
    "Farm Manager": {
      "show irrigation overview": {
        "title": "Irrigation Overview",
        "detail": "All orchards irrigated as scheduled. Block A and B reached optimal soil moisture."
      },
      "give weekly report": {
        "title": "Weekly Summary",
        "detail": "Total yield for the week was 1.2 tons. Costs under budget."
      }
    },
    "Field Supervisor": {
      "what is today’s irrigation task?": {
        "title": "Irrigation Task",
        "detail": "Irrigate mango block A for 30 minutes tomorrow morning."
      },
      "any pest alerts?": {
        "title": "Pest Alert",
        "detail": "Whitefly spotted in tomato field B. Neem spray scheduled."
      }
    },
    "Dairy Supervisor": {
      "milk yield summary": {
        "title": "Milk Yield Log",
        "detail": "Today’s average milk yield is 13.2L. Cows C102 and C104 below expected."
      },
      "feed schedule for cows": {
        "title": "Feed Schedule",
        "detail": "Morning: silage, Evening: green fodder. Vitamin supplements every 3rd day."
      }
    },
    "Technician": {
      "any pending maintenance?": {
        "title": "Maintenance Task",
        "detail": "Drip system in Block B scheduled for inspection at 10 AM."
      },
      "list repair requests": {
        "title": "Repair Request",
        "detail": "Pump #3 reported faulty. Review and resolve by end of day."
      }
    },
    "Admin": {
      "current inventory status": {
        "title": "Stock Update",
        "detail": "Fertilizer stock below reorder level. Purchase order suggested."
      },
      "expense summary for the week": {
        "title": "Expense Summary",
        "detail": "This week’s expenses logged at ₹12,500. Mostly labor and feed costs."
      }
    },
  };

  String selectedRole = "Farm Manager";
  String? selectedQuestion;
  String? title;
  String? detail;

  @override
  Widget build(BuildContext context) {
    final questions = sampleQuestions[selectedRole]!;
    selectedQuestion ??= questions.first;

    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/logo.png', // change path/filename if needed
                    height: 150,       // adjust height to fit your design
                  ),
                ),
                SizedBox(height: 24),
                Text("Select your role:", style: TextStyle(fontSize: 18)),
                DropdownButton<String>(
                  value: selectedRole,
                  isExpanded: true,
                  items: sampleQuestions.keys.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                      selectedQuestion = sampleQuestions[selectedRole]!.first;
                      title = null;
                      detail = null;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text("Choose a sample question:", style: TextStyle(fontSize: 18)),
                DropdownButton<String>(
                  value: selectedQuestion,
                  isExpanded: true,
                  items: sampleQuestions[selectedRole]!.map((question) {
                    return DropdownMenuItem(
                      value: question,
                      child: Text(question),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedQuestion = value;
                    });
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    final query = selectedQuestion!.toLowerCase();
                    final response = roleBasedData[selectedRole]?[query];
                    setState(() {
                      title = response?["title"] ?? "No Data";
                      detail = response?["detail"] ?? "No matching use case found for your role.";
                    });
                  },
                  child: Text("Submit"),
                ),
                SizedBox(height: 24),
                if (title != null && detail != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(detail!),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
