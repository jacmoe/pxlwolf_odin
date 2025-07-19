package pxlwolf_odin

import "core:fmt"
import "core:log"
import "core:os"
import "core:time"
import "core:time/timezone"

create_file_logger :: proc(level := log.Level.Debug) -> log.Logger {
    log_path := create_log_path()
    flags: int = os.O_CREATE | os.O_TRUNC | os.O_WRONLY
    mode: int = os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IROTH
    if log_handle, err := os.open(log_path, flags, mode); err == nil {
        return log.create_file_logger(log_handle, level)
    }
    return log.Logger{}
}

create_log_path :: proc() -> string {
    if !os.exists("./logs") do os.make_directory("./logs")

    the_time := time.now()
    the_date, _ := time.time_to_datetime(the_time)

    tz, _ := timezone.region_load("Europe/Copenhagen")
    defer timezone.region_destroy(tz)
    corrected_date, _ := timezone.datetime_to_tz(the_date, tz)
    corrected_time, _ := time.datetime_to_time(corrected_date)

    date_buf: [time.MIN_YYYY_DATE_LEN]u8
    date_string := time.to_string_dd_mm_yyyy(corrected_time, date_buf[:])
    time_buf: [time.MIN_HMS_LEN]u8
    time_string := time.time_to_string_hms(corrected_time, time_buf[:])

    return fmt.tprintf("./logs/{}_{}.log", date_string, time_string)
}
