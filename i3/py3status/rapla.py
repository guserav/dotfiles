# -*- coding: utf-8 -*-
import json
import datetime as dt
from dateutil.parser import parse
from tzlocal import get_localzone
import pytz
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
    day_format = "%a"
    datetime_format = "%-H:%M"
    time_format = "%-H:%M"
    format = "{remaining}h until {end}!"
    next_format = "{title} ({day} {start}-{end})"

    next_event = False
    local_tz = get_localzone()


    def rapla(self):
        event_index = int(self.next_event)
        now = dt.datetime.now(pytz.utc)
        color = self.py3.COLOR_MUTED
        try:
            json_data = self.py3.request(self.url, timeout=self.timeout).json()
            # get the first two events that haven't ended yet
            events = [
                event for event
                in json_data['events']
                if parse(event['end']).astimezone(self.local_tz) > now
            ][:2]

            # display next event
            if self.next_event or parse(events[0]['start']) > now:
                start = parse(events[event_index]['start']) \
                        .astimezone(self.local_tz)
                end = parse(events[event_index]['end']) \
                        .astimezone(self.local_tz)
                title = events[event_index]['title'][:self.max_title_length]

                diff = (start.date() - dt.datetime.today().date())
                if diff.days > 0:
                    days_until = "+{}d".format(diff.days)
                else:
                    days_until = ""
                    color = self.py3.COLOR_DEGRADED

                text = self.next_format.format(
                        title=title,
                        day=start.strftime(self.day_format),
                        start=start.strftime(self.datetime_format),
                        end=end.strftime(self.datetime_format),
                        diff=diff)
            else: # display start and end of current event
                end = parse(events[0]['end']).astimezone(self.local_tz)
                rem_sec = int((end - now).total_seconds())
                remaining = dt.time(rem_sec // 3600, rem_sec % 3600 // 60, 0)

                text = self.format.format(
                        remaining=remaining.strftime(self.time_format),
                        end=end.strftime(self.time_format))
                color = self.py3.COLOR_GOOD if rem_sec < 3600 else self.py3.COLOR_BAD
        except self.py3.RequestException:
            text = "Could not reach URL"

        return {
            'full_text': text,
            'color': color,
            'cached_until': self.py3.CACHE_FOREVER
        }

    def on_click(self, event):
            self.next_event = not self.next_event
