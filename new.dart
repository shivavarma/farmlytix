// Example in your widget:
Text
("Select your role:
"
, style: Theme.of(context).textTheme.titleLarge),
Text("Choose a sample question:", style: Theme.of(context).textTheme.titleMedium),
// In your ThemeData:
theme: ThemeData(
primarySwatch: Colors.green,
fontFamily: 'Roboto',
scaffoldBackgroundColor: Colors.grey[50],
textTheme: TextTheme(
titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
bodyMedium: TextStyle(fontSize: 16.0),
// ... other text styles
),
colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors
.
orangeAccent
)
, // Example accent
)
,