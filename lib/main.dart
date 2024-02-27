import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WorkoutInputScreen(),
    );
  }
}

class WorkoutInputScreen extends StatefulWidget {
  @override
  _WorkoutInputScreenState createState() => _WorkoutInputScreenState();
}

class _WorkoutInputScreenState extends State<WorkoutInputScreen> {
  TextEditingController workoutController = TextEditingController();
  List<String> analyzedMuscleGroups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Analyzer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: workoutController,
              decoration: InputDecoration(
                labelText: 'Enter Your Workout (comma-separated)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                analyzeWorkout(workoutController.text);
              },
              child: Text('Analyze Workout'),
            ),
            SizedBox(height: 20),
            Text(
              'Analyzed Muscle Groups: ${analyzedMuscleGroups.isNotEmpty ? analyzedMuscleGroups.join(", ") : "None"}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void analyzeWorkout(String workout) {
    List<String> exercises = workout.split(',').map((e) => e.trim()).toList();
    setState(() {
      analyzedMuscleGroups = analyzeMuscleGroups(exercises);
    });
  }

  List<String> analyzeMuscleGroups(List<String> exercises) {
    Set<String> muscleGroups = Set<String>();
    for (String exercise in exercises) {
      // Use a more sophisticated algorithm or external API for accurate analysis
      if (upperBodyExercises.contains(exercise.toLowerCase())) {
        muscleGroups.add('Upper Body');
      } else if (lowerBodyExercises.contains(exercise.toLowerCase())) {
        muscleGroups.add('Lower Body');
      } else {
        muscleGroups.add('Other');
      }
    }
    return muscleGroups.toList();
  }

  // Sample exercise lists
  List<String> upperBodyExercises = [
    'bench press',
    'push-up',
    'pull-up',
    'shoulder press',
    'bicep curl',
    'tricep dip',
  ];

  List<String> lowerBodyExercises = [
    'squat',
    'deadlift',
    'leg press',
    'lunges',
    'calf raise',
  ];
}
