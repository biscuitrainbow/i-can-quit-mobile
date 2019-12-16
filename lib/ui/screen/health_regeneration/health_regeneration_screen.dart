import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/data/static/static_data.dart';
import 'package:i_can_quit/ui/health_regeneration/health_regeneration_item.dart';

class HealthRegenerationScreen extends StatefulWidget {
  static final String route = '/health_regeneration';

  @override
  _HealthRegenerationScreenState createState() => _HealthRegenerationScreenState();
}

class _HealthRegenerationScreenState extends State<HealthRegenerationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การฟื้นฟูสุขภาพ',
          style: GoogleFonts.kanit(),
        ),
      ),
      body: BlocBuilder<SmokingEntryBloc, SmokingEntryState>(
        builder: (context, state) {
          if (state is FetchSmokingEntrySuccess) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: StaticData.healthRegnerations.length,
              itemBuilder: (context, index) {
                final healthRegeneration = StaticData.healthRegnerations[index];

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: HealthRegenerationItem(
                    healthRegeneration: healthRegeneration,
                    latestHasSmokedDateTime: state.latestHasSmokedEntry.datetime,
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
