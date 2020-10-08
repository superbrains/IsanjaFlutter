// To parse this JSON data, do
//
//     final teamClass = teamClassFromJson(jsonString);

import 'dart:convert';

List<TeamClass> teamClassFromJson(String str) => List<TeamClass>.from(json.decode(str).map((x) => TeamClass.fromJson(x)));

String teamClassToJson(List<TeamClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamClass {
    TeamClass({
        this.id,
        this.team,
    });

    int id;
    String team;

    factory TeamClass.fromJson(Map<String, dynamic> json) => TeamClass(
        id: json["id"],
        team: json["team"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "team": team,
    };
}
