# -*- coding: utf-8 -*-
import json
from datetime import datetime
from dateutil.parser import parse
from tzlocal import get_localzone
"""
Display current and next calendar entry from JSON URL.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 30)
    format: display format for this module (default None)
    timeout: time to wait for a response, in seconds (default 5)
    url: specify URL to fetch JSON from (default None)
    max_title_length: maximum length of the title (default 25)
    datetime_format: format string for the time (default "%a %H:%M")
    format = "{title} - {time}" # {diff}

Format placeholders:
    {title} title of the event
    {time} time of the event
    {diff} days until the event

Requires:
    tz_local: pip package for converting timezones

Example:

```
module {
    url = "https://example.org/cal.json"
    max_title_length = 10
}

module {
    url = "https://example.org/cal.json"
    format = "{title}@{time}{diff}"
    datetime_format = "%H:%M"
}
```

@author Daniel Schäfer <mail at danielschaefer.me>
@license GPLv2
"""


class Py3status:
    cache_timeout = 30
    timeout = 5
    url = None
    max_title_length = 25
    datetime_format = "%a %H:%M"
    format = "{title} - {time}"

    next_event = False
    local_tz = get_localzone()


    def rapla(self):
        event_index = int(self.next_event)
        try:
            json_data = self.py3.request(self.url, timeout=self.timeout).json()
            events = json_data['events']

            title = events[event_index]['title'][:self.max_title_length]

            date = parse(events[event_index]['start']).astimezone(self.local_tz)
            time = date.strftime(self.datetime_format)
            days_until  = (date.date() - datetime.today().date()).days
            diff = "+{}d".format(days_until) if days_until > 0 else ""

            text = self.format.format(title=title, time=time, diff=diff)
        except self.py3.RequestException:
            text = "Could not reach URL"

        return {
            'full_text': text,
            'cached_until': self.py3.CACHE_FOREVER
        }

    def on_click(self, event):
            self.next_event = not self.next_event
