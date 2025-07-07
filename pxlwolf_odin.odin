package pxlwolf_odin

import "base:runtime"
import "core:fmt"
import "core:log"
import "core:os"
import "core:path/filepath"
import t "core:time"
import dt "core:time/datetime"
import "core:math"


main :: proc()
{
    context.logger = log.create_multi_logger(log.create_console_logger())
    defer log.destroy_multi_logger(context.logger)

    setup_logging()

    log.infof("Application started")
    log.infof("Doing stuff")
    log.infof("Application stopped")
}

setup_logging :: proc()
{
    log_file_name := createLogPath()
    flags: int = os.O_CREATE | os.O_TRUNC | os.O_WRONLY
    mode: int = os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IROTH
    if log_handle, err := os.open(log_file_name, flags, mode); err == 0
    {
        context.logger = log.create_multi_logger(log.create_console_logger(), log.create_file_logger(log_handle),)
        log.log(.Info, "Creating multi_logger")
    } else {
        log.logf(.Warning, "Log file could not be created! Filename: {}", log_file_name)
    }
}


// Lifted from https://github.com/xandaron/Valhalla/
createLogPath :: proc() -> string {
    if !os.exists("./logs") do os.make_directory("./logs")

        // Maybe I can check how many files are in the directory and then create a new file with the next number.
        now := t.now()
        year, month, day := t.date(now)
        dateTime: dt.DateTime = {
            date = dt.Date{year = (i64)(year), month = (i8)(month), day = (i8)(day)},
        }
        midnight, _ := t.datetime_to_time(dateTime)
        seconds := math.floor(t.duration_seconds(t.diff(midnight, now)))

        hours := math.floor(seconds / t.SECONDS_PER_HOUR)
        seconds -= hours * t.SECONDS_PER_HOUR
        minutes := math.floor(seconds / t.SECONDS_PER_MINUTE)
        seconds -= minutes * t.SECONDS_PER_MINUTE

        str: string = fmt.tprintf(
            "./logs/{:4i}{:2i}{:2i}{:2.0f}{:2.0f}{:2.0f}.log",
            dateTime.year,
            dateTime.month,
            dateTime.day,
            hours,
            minutes,
            seconds,
        )
        return str
}
