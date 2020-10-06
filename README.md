# Soapboxer

An abridged full-stack implementation of a browser-based video editor prototype. Currently only “cut” functionality is supported.

### Running the front-end code `soapboxer_client`

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Install Node.js dependencies with `npm install` inside the `assets` directory
* Start Phoenix endpoint with `mix phx.server`
* Navigate to the following: [http://localhost:4000/video](http://localhost:4000/video)

#### Creating “cut” edits with the timeline component

* Establish an edit (start -> end) by clicking the timeline to initiate. The marker will turn red denoting an “active” edit. 
* Complete the edit by clicking a valid point on the remaining available timeline. The completed segment will highlight on the timeline.

Valid points are those which do not intersect or overlay existing timelines. The component will not allow invalid selections.

#### Edits

A running list of edits will be printed to the screen for copy-paste to the backend application.

### Running the back-end code `soapboxer`

The following executable is provided:
```
./soapboxer/soapboxer <input_video_path> <edits_json_path>
```

#### Edits file

The edits file consists of a JSON array as described in the “Data Type” section.

### Data Type

Edits are represented by a JSON data structure of the following format: 
```
[
  {"edit_type":"EDIT_TYPE","end": INT,"start": INT}, ...
]
```

