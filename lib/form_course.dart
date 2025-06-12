import 'package:flutter/material.dart';
import 'package:primeiroapp/models/course_model.dart';
import 'package:primeiroapp/repository/course.repository.dart';

class FormCourse extends StatefulWidget {
  const FormCourse({super.key, this.courseEdit});

  final CourseModel? courseEdit;

  @override
  State<FormCourse> createState() => _FormCourseState();
}

class _FormCourseState extends State<FormCourse> {
  String id = '';
  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescController = TextEditingController();
  TextEditingController textStartAtController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final repository = CourseRepository();

  @override
  void initState() {
    super.initState();
    if (widget.courseEdit != null) {
      textNameController.text = widget.courseEdit?.name ?? '';
      textDescController.text = widget.courseEdit?.description ?? '';
      textStartAtController.text = widget.courseEdit!.startAt ?? '';
      id = widget.courseEdit?.id ?? '';
    }
  }

  putUpdateCourse() async {
    try {
      await repository.putUpdateCourse(
        CourseModel(
          id: id,
          name: textNameController.text,
          description: textDescController.text,
          startAt: textStartAtController.text,
        ),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Dados salvos!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  postNewCourse() async {
    try {
      await repository.postNewCourse(
        CourseModel(
          name: textNameController.text,
          description: textDescController.text,
          startAt: textStartAtController.text,
        ),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Dados salvos!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Preencha o nome do curso",
                ),
                controller: textNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null; //válido
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Preencha a descrição do curso",
                ),
                controller: textDescController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null; //válido
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Preencha a data de início do curso",
                ),
                controller: textStartAtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null; //válido
                },
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (widget.courseEdit != null) {
                        putUpdateCourse();
                      } else {
                        postNewCourse();
                      }
                    }
                  },
                  child: Text("Salvar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
