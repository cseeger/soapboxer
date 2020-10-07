# Soapboxer
An abridged full-stack implementation of a browser-based video editor prototype. Currently only “cut” functionality is supported.

### Running the front-end code  - `soapboxer_client`

* `cd soapboxer_client`
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

### Running the back-end code - `soapboxer`

* Install `ffmpeg` 
* `cd soapboxer`

The following executable is provided:
```
./soapboxer/soapboxer <input_video_path> <edits_json_path>
```

Example using existing repo files: `./soapboxer ../input.mp4 edits.txt`

#### Edits file

The edits file consists of a JSON array as described in the “Data Type” section.

### Data Type

Edits are represented by a JSON data structure of the following format: 
```
[
  {"edit_type":"EDIT_TYPE","end": INT,"start": INT}, ...
]
```

Example "cut" edut: `{"edit_type": "cut", "end": 10, "start": 5}`

### Post-mortem

#### Glaring omissions

1. *UI tests* - unfortunately I did not have the time to wrap the UI in tests, which is something I consider vital for production-ready code.
2. *Additional UI elements* - embellishments such as an HTML5 video player, progress/elapsed tooltips, and other video player chrome were omitted in favor of solidifying the timeline component.  
3. *Zoom* - I spent a significant amount of time attempting to coerce zoom functionality from the `ffmpeg` command line tool, but was unsuccessful. Given the timeline I’m under, I decided it was better to attempt a minimal full-stack implementation with cut, rather than continue to burn uninformed cycles with `ffmpeg`. 
4. *Full-stack application vertical* - ideally the application becomes a single code base where the front-end is wired through to the back-end and edits are persisted. This would be a priority were my schedule to allow. 

#### Learnings

*ffmpeg* - prior to this exercise, I had only very casually used `ffmpeg` to encode videos for mobile devices. Never had I made external calls from application code. That said, I learned quite a lot and would love an opportunity to continue gaining proficiency with the tool. 

Regarding zoom, my attempts were based around the following methods and are available at `./zoom_scratch.txt`:

* _Overlay method_: `filter-complex` of `scale` and `overlay`
* _Zoom-in scale + crop_:  simple filter of `scale` and `crop`
* _Zoom-out with pad_: simple filter of `scale` and `pad`

The above commands operate over the entire file by default. Which prevented specify timeline segments, and leading me to believe there is a better way of implementing zoom outside of the command line tool.

Perhaps the answer here is a NIF directly into `libav*`libraries, or maybe there’s a solution working with the video at the individual frame level.

#### On loose prototype specifications

I figured that implementing a hardened timeline component was likely more significant than demonstrating proficiency with CSS frameworks or HTML video. I’d like to think that my resume alone should speak to that. Case in point, I’m using Wistia on the [Waant.com](http://www.waant.com) homepage for our marketing video. 

As for the backend, I hope the `Soapboxer.Cut` module, while admittedly basic, is enough to convey language command and perhaps code clarity.

#### Thank you!

Thanks for the opportunity to work on this exercise. I learned more about `ffmpeg` than I imagined I would and I certainly enjoyed using `Phoenix.LiveView` . 

Please feel free to reach out with any additional question you may have.
