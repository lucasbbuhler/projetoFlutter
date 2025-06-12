import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:primeiroapp/models/course_model.dart';
import 'package:primeiroapp/repository/course.repository.dart';
import 'package:primeiroapp/form_course.dart';
import 'widgets/Appdrawer.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = CourseRepository();
  late Future<List<CourseModel>> futureCourseList;

  @override
  void initState() {
    super.initState();
    futureCourseList = repository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de cursos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
            tooltip: 'Alternar tema',
          ),
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: AppDrawer(theme: theme, colorScheme: colorScheme),
      body: FutureBuilder<List<CourseModel>>(
        future: futureCourseList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum curso encontrado.'));
          }

          final courses = snapshot.data!;
          return buildCoursesList(courses);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormCourse()),
          ).then((value) {
            setState(() {
              futureCourseList = repository.getAll();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildCoursesList(List<CourseModel> courses) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          child: Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => FormCourse(courseEdit: courses[index]),
                      ),
                    ).then((value) {
                      setState(() {
                        futureCourseList = repository.getAll();
                      });
                    });
                  },
                  icon: Icons.edit,
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  label: 'Editar',
                ),
                SlidableAction(
                  onPressed: (context) async {
                    showDialog<String>(
                      context: context,
                      builder:
                          (BuildContext context) => AlertDialog(
                            title: const Text('Confirmação'),
                            content: const Text(
                              'Confirma exclusão deste Curso?',
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed:
                                    () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await repository.deleteCourse(
                                    courses[index].id!,
                                  );
                                  Navigator.pop(context);
                                  setState(() {
                                    futureCourseList = repository.getAll();
                                  });
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                    );
                  },

                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  label: 'Excluir',
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.pix_rounded)),
              title: Text(courses[index].name ?? ''),
              subtitle: Text(courses[index].description ?? ''),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        );
      },
    );
  }
}
