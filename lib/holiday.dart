import 'package:flutter/material.dart';
import 'models/holiday_model.dart';
import 'repository/holiday_repository.dart';
import 'widgets/Appdrawer.dart';
import 'package:intl/intl.dart';

class HolidayScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HolidayScreen({super.key, required this.toggleTheme});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  final HolidayRepository repository = HolidayRepository();
  late Future<List<HolidayModel>> futureHolidays;
  String formatarDataPtBr(String dataIso) {
    final DateTime parsedDate = DateTime.parse(dataIso);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    futureHolidays = repository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feriados 2025"),
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
      body: FutureBuilder<List<HolidayModel>>(
        future: futureHolidays,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum feriado encontrado.'));
          }

          final holidays = snapshot.data!;
          return ListView.builder(
            itemCount: holidays.length,
            itemBuilder: (context, index) {
              final h = holidays[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Material(
                  color: theme.cardColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    splashColor: colorScheme.primary.withAlpha(25),
                    highlightColor: Colors.grey.withAlpha(25),
                    onTap: () {},
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.event)),
                      title: Text(
                        h.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${formatarDataPtBr(h.date)} • nacional'),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
