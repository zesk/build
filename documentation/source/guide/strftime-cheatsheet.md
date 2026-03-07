# strftime cheatsheet

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

Used in `date` and other programs. Wrote this so I don't have to search to find the right character.

## Years

- `%Y` - the year with century as a decimal number.
- `%y` - the year without century as a decimal number (`00`-`99`).
- `%C` -  (`year / 100`) as decimal number; single digits are preceded by a zero.
- `%G` - a year as a decimal number with century. This year is the one that contains the greater part of the week (
  Monday as the first day of the week).
- `%g` - the same year as in `%G`, but as a decimal number without century (`00`-`99`).

## Yearday/Week Number

- `%j` - the day of the year as a decimal number (`001`-`366`).
- `%U` - the week number of the year (Sunday as the first day of the week) as a decimal number (`00`-`53`).
- `%V` - the week number of the year (Monday as the first day of the week) as a decimal number (`01`-`53`). If the week
  containing January 1 has four or more days in the new year, then it is week 1; otherwise it is the last week of the
  previous year, and the next week is week 1.
- `%W` - the week number of the year (Monday as the first day of the week) as a decimal number (`00`-`53`).

## Months

- `%B` - national representation of the full month name.
- `%b` - national representation of the abbreviated month name.
- `%h` - the same as `%b`.
- `%m` - the month as a decimal number (`01`-`12`).

## Day of the month (1 through 31)

- `%e` - the day of the month as a decimal number (`1`-`31`); single digits are preceded by a blank.
- `%d` - the day of the month as a decimal number (`01`-`31`).

## Day of the week (Monday, etc.)

- `%A` - national representation of the full weekday name.
- `%a` - national representation of the abbreviated weekday name.
- `%w` - the weekday (Sunday as the first day of the week) as a decimal number (`0`-`6`).
- `%u` - the weekday (Monday as the first day of the week) as a decimal number (`1`-`7`).

## Hour of the day

- `%I` - the hour (12-hour clock) as a decimal number (`01`-`12`).
- `%H` - the hour (24-hour clock) as a decimal number (`00`-`23`).
- `%k` - the hour (24-hour clock) as a decimal number (`0`-`23`); single digits are preceded by a blank.
- `%l` - the hour (12-hour clock) as a decimal number (`1`-`12`); single digits are preceded by a blank.
- `%p` - national representation of either "ante meridiem" (a.m.)  or "post meridiem" (p.m.)  as appropriate.

## Minute of the hour

- `%M` - the minute as a decimal number (00-59).

## Seconds of the minute

- `%S` - the second as a decimal number (00-60).

# Time Zones

- `%Z` - the time zone name.
- `%z` - the time zone offset from UTC; a leading plus sign stands for east of UTC, a minus sign for west of UTC, hours
  and minutes follow with two digits each and no delimiter between them (common form for RFC 822 date headers).

# Timestamp

- `%s` - the number of seconds since the Epoch, UTC (see mktime(3)).

# Combinations

- `%X` - national representation of the time.
- `%x` - national representation of the date.
- `%+` - national representation of the date and time (the format is similar to that produced by date(1)).
- `%c` - national representation of time and date.
- `%D` - equivalent to `%m/%d/%y`.
- `%F` - is equivalent to `%Y-%m-%d`.
- `%R` - is equivalent to `%H:%M`.
- `%r` - is equivalent to `%I:%M:%S %p`.
- `%v` - is equivalent to `%e-%b-%Y`.
- `%T` - is equivalent to `%H:%M:%S`.

# Characters

- `%n` - a newline
- `%t` - a tab
- `%%` - The literal character `%`

# GNU/POSIX Extensions

- `%-`*   GNU libc extension. Do not do any padding when performing numerical outputs.
- `%_`*   GNU libc extension. Explicitly specify space for padding.
- `%0`*   GNU libc extension. Explicitly specify zero for padding.
- `%E* %O*` POSIX locale extensions. The sequences `%Ec %EC %Ex %EX %Ey %EY %Od %Oe %OH %OI %Om %OM %OS %Ou %OU %OV %Ow
  %OW %Oy` are supposed to provide alternate representations.
- `%O*`   the same as `%E*`.

Additionally `%OB` implemented to represent alternative months names (used standalone, without day mentioned).

<!-- TEMPLATE guideFooter 3 -->
<hr />

[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
