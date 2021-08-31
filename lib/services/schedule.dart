class Schedule {
  String _available, _hour;

  Schedule(this._available, this._hour);

  /*factory Schedule.fromJSON(Map<String, dynamic> json) {
    if (json == null) {
      return Schedule.fromJSON(json);
    } else {
      return Schedule(json["available"], json["hour"]);
    }
  }*/

  get available => this._available;
  get hour => this._hour;
}
