package pxlwolf_odin

import "base:runtime"
import "core:fmt"
import "core:log"
import "core:os"
import "core:path/filepath"
import "core:time"
import "core:time/datetime"
import "core:time/timezone"
import "core:math"

main :: proc()
{
    context.logger = log.create_multi_logger(log.create_console_logger())
    log.infof("Application started")

    context.logger = create_logger()
    defer log.destroy_multi_logger(context.logger)

    log.infof("Doing stuff")

    log.infof("Application stopped")
}

create_logger :: proc() -> log.Logger
{
    logger: log.Logger
    log_file_name := createLogPath()
    flags: int = os.O_CREATE | os.O_TRUNC | os.O_WRONLY
    mode: int = os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IROTH
    if log_handle, err := os.open(log_file_name, flags, mode); err == 0
    {
        logger = log.create_multi_logger(log.create_console_logger(), log.create_file_logger(log_handle),)
        context.logger = logger
        log.log(.Info, "Creating multi_logger")
    } else {
        logger = log.create_multi_logger(log.create_console_logger())
        context.logger = logger
        log.logf(.Warning, "Log file could not be created! Filename: {}", log_file_name)
    }
    return logger
}

createLogPath :: proc() -> string {
    if !os.exists("./logs") do os.make_directory("./logs")

    the_time := time.now()
    the_date, _ := time.time_to_datetime(the_time)

    tz, tz_err := timezone.region_load("Europe/Copenhagen")
    corrected_date, _ := timezone.datetime_to_tz(the_date, tz)
    corrected_time, _ := time.datetime_to_time(corrected_date)

    date_buf: [time.MIN_YYYY_DATE_LEN]u8
    date_string := time.to_string_dd_mm_yyyy(corrected_time, date_buf[:])
    time_buf: [time.MIN_HMS_LEN]u8
    time_string := time.time_to_string_hms(corrected_time, time_buf[:])

    return fmt.tprintf("./logs/{}_{}.log", date_string, time_string, )
}
